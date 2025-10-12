
# VSCode configuration files

| System  | Configuration directory location       |
|---------|----------------------------------------|
| Linux   | `~/.config/Code`                       |
| Windows | `C:/Users/<USER>/AppData/Roaming/Code` |

## General settings

Location: `${config_dir}/User/settings.json`

## Key bindings

Location: `${config_dir}/User/keybindings.json`

| Binding          | Action                       |
|------------------|------------------------------|
| `Ctrl+T N`       | New terminal tab             |
| `Ctrl+T S`       | Split terminal               |
| `Ctrl+G Left`    | Go to previous terminal      |
| `Ctrl+G Right`   | Go to next terminal          |
| `Ctrl+G Up`      | Go to editor (from terminal) |
| `Ctrl+G Down`    | Go to terminal (from editor) |
| `Ctrl+G L`       | Go to editor line            |
| `Ctrl+Up`        | Insert cursor above          |
| `Ctrl+Down`      | Insert cursor below          |
| `Ctrl+Alt+Up`    | Move selected line(s) up     |
| `Ctrl+Alt+Down`  | Move selected line(s) down   |
| `Ctrl+:`         | Toggle comments              |
| `Ctrl+I`         | Insert snippet               |
| `Ctrl+Shift+:`   | Block comment                |
| `Ctrl+Shift+D`   | Duplicate selection          |
| `Alt+D`          | Delete selected line(s)      |
| `Ctrl+O`         | Quick open                   |
| `Ctrl+P`         | File picker                  |

## Snippets

Location: `${config_dir}/User/snippets/<language>.json`

### C++ (as `cpp`)

| Snippet     | Content                                           |
|-------------|---------------------------------------------------|
| `namespace` | Basic namespace declaration with trailing comment |
| `copy`      | Disabled copy constructor and assignment operator |
| `move`      | Disabled move constructor and assignment operator |
