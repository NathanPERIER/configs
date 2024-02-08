
# Vim configuration files

## Install

- `vimrc` -> `~/.vimrc`
- `options.vim` -> `~/.vim/options.vim`
- `commands.vim` -> `~/.vim/commands.vim`
- `mappings.vim` -> `~/.vim/mappings.vim`
- `filetypes.vim` -> `~/.vim/filetypes.vim`

## Content

- Enable colour syntax
- Disable bell and mouse interaction
- Detect `fish` script files (extension or shebang)
- Match angle brackets
- Break lines, avoid breaking words, show line breaks
- Smart indentation (a tab is four spaces)

### Custom commands

| Command | Effect             |
|---------|--------------------|
| `Ws`    | Write file as sudo |

### Custom mappings

| Mapping             | Effect                                        |
|---------------------|-----------------------------------------------|
| `,` `Space` `Space` | Open terminal in new pane                     |
| `Ctrl+T` `N`        | Open terminal in new tab                      |
| `,` `V` `V`         | Edit main config file (`~/.vimrc`) in new tab |
| `,` `S` `V`         | Apply configuration                           |
| `,` `Esc` `Esc`     | Clear search highlights                       |
| `,` `N`             | Enable/disable line numbering                 |
| `Ctrl+Right`        | Go to next tab                                |
| `Ctrl+G` `Right`    | Go to next tab                                |
| `Ctrl+Left`         | Go to previous tab                            |
| `Ctrl+G` `Left`     | Go to previous tab                            |

