
# Bash configuration

## Install

Main configuration file : `bashrc.sh` -> `~/.bashrc`

Additional files :

- `bash_aliases.sh` -> `~/.config/bash/aliases`
- `bash_variables.sh` -> `~/.config/bash/variables`
- `bash_prompt.sh` -> `~/.config/bash/prompt`

### Start sequence

The `~/.bashrc` sources the files in the following order if they exist :

1. `~/.config/bash/variables`
2. `~/.bash_local`
3. `~/.config/bash/aliases`
4. `~/.config/bash/prompt`

The `~/.bash_local` file is intended to set machine-specific variables. It can namely be used to modify variables set by the firt file, which may have an influence on the following scripts.

## Features

### Environment variables

| Variable        | Values                                         |
|-----------------|------------------------------------------------|
| `MACHINE_TYPE`  | `wsl`, `desktop`, `server`                     |
| `TERMINAL_TYPE` | `gnome`, `windows`, `vscode`, `xterm`, `other` | 

> Note: the desktop/server detection is currently done by checking the presence of an X server, which may not be accurate and will only work on Debian systems

### Aliases and functions

| Command                           | Description                                                                              |
|-----------------------------------|------------------------------------------------------------------------------------------|
| `l`                               | Short `ls`                                                                               |
| `ll`                              | Detailed `ls`                                                                            |
| `lli`                             | Detailed `ls` with inodes                                                                |
| `lla`                             | Detailed `ls` including hidden files                                                     |
| `ok`, `mb`                        | Does nothing and returns `0`, used to clear the return code                              |
| `xx`                              | Clears the terminal                                                                      |
| `python`                          | Force call to `python3`                                                                  |
| `pip`                             | Force call to `pip3`                                                                     |
| `eclp`                            | You do not want to ask                                                                   |
| `ed`, `nano`, `emacs`             | Redirect any file editor to `vim`                                                        |
| `eb`                              | Edit `~/.bashrc`                                                                         |
| `ebv`                             | Edit `~/.config/bash/variables`                                                          |
| `ebl`                             | Edit `~/.bash_local'`                                                                    |
| `eba`                             | Edit `~/.config/bash/aliases'`                                                           |
| `ebp`                             | Edit `~/.config/bash/prompt'`                                                            |
| `sb`                              | Source `~/.bashrc`                                                                       |
| `led <path>`                      | `ll` if the target is a directory, `ed` if it is a writable file (or doesn't exist), else `less` |
| `mkd <path>`                      | Create a directory and `cd` into it                                            |
| `rmd`                             | Remove the current directory if empty and `cd` to its parent                   |
| `ipinfo`                          | Get the public IP address the machine uses to access the internet              |
| `music-dl`                        | Download musics via `yt-dlp` (only enabled if the program is installed)        |
| `mktgz`                           | Compress files in a `.tar.gz`                                                  |
| `untgz`                           | Uncompress a `.tar.gz`                                                         |
| `f <pattern>`                     | Find a file by name in the current directory                                   |
| `ff <pattern> [filename_pattern]` | Find files containing a given pattern in the current directory                 |
| `syslog`                          | Read the syslog output                                                         |
| `here`                            | Open a new terminal in the current location (desktop only)                     |
| `xo`                              | Open a file/folder with the default program (desktop only)                     |
| `mk`                              | Compile with `make` on all cores                                               |
| `solong`                          | Kill a program by name (`pkill`) with the `SIGKILL` signal                     |
| `q`, `wq`                         | Exit the current terminal                                                      |
| `dodo`                            | Shuts the computer down (desktop only)                                         |

> Note: if the variable `colour_support` is set to `yes`, automatic colouring will be enabled for `ls`, `grep` and `ip` (i.e. the text will coloured only if the output is a terminal). This is autodetected in the variables script but can be overridden.

