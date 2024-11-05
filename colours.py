#!/usr/bin/python3

import re
import sys


col_reg = re.compile(r'(clear|bold|dim|italic|underline|strikethrough)|([fb]g:)?(?:((?:bright-)?(?:black|red|green|yellow|blue|magenta|cyan|white|default)|dark-grey)|#([0-9a-fA-F]{6})|([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5]))')

def convert_colour(name: str) -> str :
    m = col_reg.fullmatch(name)
    if m is None :
        return ''
    if m.group(1) is not None :
        match m.group(1) :
            case 'clear':
                return '0'
            case 'bold':
                return '1'
            case 'dim':
                return '2'
            case 'italic':
                return '3'
            case 'underline':
                return '4'
            case 'strikethrough':
                return '9'
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
    match col_name :
        case 'black':
            col_val = 0
        case 'red':
            col_val = 1
        case 'green':
            col_val = 2
        case 'yellow':
            col_val = 3
        case 'blue':
            col_val = 4
        case 'magenta':
            col_val = 5
        case 'cyan':
            col_val = 6
        case 'white':
            col_val = 7
    return f"{30 + background_val + bright_val + col_val}"


def main():
    res = []
    for repr in sys.argv[1].split() :
        col_code = convert_colour(repr.strip())
        if len(col_code) > 0 :
            res.append(col_code)
    if len(res) > 0 :
        full_code = ";".join(res)
        print(full_code)
        print(f"\x1b[{full_code}mtest\x1b[0m")
        


if __name__ == '__main__' :
    main()
