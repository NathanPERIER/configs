#!/usr/bin/python3

import re
import sys
import traceback

import yaml


def help():
    print(f"usage: {sys.argv[0]} <bash|fish> <classes> <colours>")


col_reg = re.compile(r'(clear|bold|dim|italic|underline|strikethrough)|([fb]g:)?(?:((?:bright-)?(?:black|red|green|yellow|blue|magenta|cyan|white|default)|dark-grey)|#([0-9a-fA-F]{6})|([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5]))')
raw_code_reg = re.compile(r'[0-9]+(?:;[0-9]+)*')

modifier_codes = {
    'clear':         0,
    'bold':          1,
    'dim':           2,
    'italic':        3,
    'underline':     4,
    'strikethrough': 9
}

# Index in a list would be more efficient... if not for the ValueError
basic_colour_codes = {
    'black':   0,
    'red':     1,
    'green':   2,
    'yellow':  3,
    'blue':    4,
    'magenta': 5,
    'cyan':    6,
    'white':   7
}

def convert_colour_component(name: str) -> str :
    m = col_reg.fullmatch(name)
    if m is None :
        return ''
    if m.group(1) is not None :
        if m.group(1) in modifier_codes :
            return str(modifier_codes[m.group(1)])
        return ''
    # background
    background_val = 0
    if m.group(2) is not None and m.group(2).startswith('b') :
        background_val = 10
    # RGB colours
    if m.group(4) is not None :
        r = int(m.group(4)[0:2], 16)
        g = int(m.group(4)[2:4], 16)
        b = int(m.group(4)[4:6], 16)
        return f"{38 + background_val};2;{r};{g};{b}"
    # 256 colours
    if m.group(5) is not None :
        return f"{38 + background_val};5;{m.group(5)}"
    # 8 colours
    col_name = m.group(3)
    if col_name is None :
        col_name = 'default'
    if col_name == 'dark-grey':
        col_name = 'bright-black'
    bright_val = 0
    if col_name.startswith('bright-'):
        col_name = col_name[7:]
        bright_val = 60
    col_val = 9
    if col_name in basic_colour_codes :
        col_val = basic_colour_codes[col_name]
    return f"{30 + background_val + bright_val + col_val}"


def convert_colour(repr: str) -> str :
    if raw_code_reg.fullmatch(repr) is not None :
        return repr
    res: list[str] = []
    for cpt in repr.split() :
        cpt_code = convert_colour_component(cpt)
        if len(cpt_code) > 0 :
            res.append(cpt_code)
    return ";".join(res)


def load_yaml(path: str):
    with open(path, 'r') as f:
        return yaml.safe_load(f)


class BashShell:
    def set_variable(self, name: str, value: str) -> str :
        return f"{name}='{value}'"
    def export_variable(self, name: str, value: str) -> str :
        return f"export {name}='{value}'"

class FishShell:
    def set_variable(self, name: str, value: str) -> str :
        return f"set {name} '{value}'"
    def export_variable(self, name: str, value: str) -> str :
        return f"set -x {name} '{value}'"

def get_shell(name: str):
    if name in ['bash', 'sh'] :
        return BashShell()
    if name == 'fish' :
        return FishShell()
    raise ValueError(f"Bad shell type: {name}")

ls_types_names = {
    'normal':                'no',
    'file':                  'fi',
    'reset':                 'rs',
    'directory':             'di',
    'multi_hard_link':       'mh',
    'sym_link':              'ln',
    'orphan':                'or',
    'missing':               'mi',
    'fifo':                  'pi',
    'socket':                'so',
    'door':                  'do',
    'block_device':          'bd',
    'char_device':           'cd',
    'setuid':                'su',
    'setgid':                'sg',
    'capability':            'ca',
    'sticky_other_writable': 'tw',
    'other_writable':        'ow',
    'sticky':                'st',
    'executable':            'ex'
}


def print_gcc_var(gcc_colours: "dict[str, str]", shell):
    res: list[str] = []
    for elt, col_repr in gcc_colours.items() :
        col_code = convert_colour(col_repr)
        if len(col_code) > 0 :
            res.append(f"{elt}={col_code}")
    if len(res) > 0 :
        print(shell.export_variable('GCC_COLORS', ':'.join(res)))
        print(shell.set_variable('gcc_colors_ok', 'true'))

def print_ls_var(classes, colours, shell) :
    ls_classes = {}
    for cls_id, cls in classes.items() :
        patterns = []
        default_code = convert_colour(cls['default'])
        if len(default_code) == 0 :
            default_code = '0'
        if 'extensions' in cls :
            patterns.extend(f"*.{ext}" for ext in cls['extensions'])
        if 'patterns' in cls :
            patterns.extend(cls['patterns'])
        if len(patterns) > 0 :
            ls_classes[cls_id] = (default_code, patterns)
    if 'classes' in colours :
        for cls_id, col_repr in colours['classes'].items() :
            col_code = convert_colour(col_repr)
            if len(col_code) > 0 and cls_id in ls_classes :
                ls_classes[cls_id] = (col_code, ls_classes[cls_id][1])
    res = []
    if 'types' in colours :
        for type_name, col_repr in colours['types'].items() :
            col_code = convert_colour(col_repr)
            if type_name in ls_types_names and len(col_code) > 0 :
                res.append(f"{ls_types_names[type_name]}={col_code}")
    for col_code, patterns in ls_classes.values() :
        for p in patterns :
            res.append(f"{p}={col_code}")
    print(shell.export_variable('LS_COLORS', ':'.join(res)))
    print(shell.set_variable('ls_colors_ok', 'true'))

def print_vars(classes, colours, shell) :
    if 'gcc_colours' in colours :
        print_gcc_var(colours['gcc_colours'], shell)
    if 'ls_colours' in colours :
        print_ls_var(classes, colours['ls_colours'], shell)




def main():
    if len(sys.argv) > 1 and sys.argv[1] in ['-h', '--help'] :
        help()
        sys.exit(0)
    
    if len(sys.argv) != 4 :
        sys.exit(1)

    try:
        shell = get_shell(sys.argv[1])
        classes = load_yaml(sys.argv[2])
        colours = load_yaml(sys.argv[3])
        print_vars(classes, colours, shell)
        # code = convert_colour(sys.argv[1])
        # if len(code) > 0 :
        #     print(code)
        #     print(f"\x1b[{code}mtest\x1b[0m")
    except Exception:
        print(traceback.format_exc(), file=sys.stderr)
        


if __name__ == '__main__' :
    main()
