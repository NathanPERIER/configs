
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
| `wdiff`                           | Word-level diff (using `git`)                                                  |
| `ipinfo`                          | Get the public IP address the machine uses to access the internet              |
| `music-dl`                        | Download musics via `yt-dlp` (only enabled if the program is installed)        |
| `mktgz`                           | Compress files in a `.tar.gz`                                                  |
| `untgz`                           | Uncompress a `.tar.gz`                                                         |
| `lstar`                           | Like `ls`/`find` in a `.tar`/`.tar.gz`/...                                     |
| `f <pattern>`                     | Find a file by name in the current directory                                   |
| `ff <pattern> [filename_pattern]` | Find files containing a given pattern in the current directory                 |
| `mext <file> <extension>`         | Move extension, appends or removes an extension at the end of a file name (or swaps files if both exist) |
| `syslog`                          | Read the syslog output                                                         |
| `here`                            | Open a new terminal in the current location (desktop only)                     |
| `xo`                              | Open a file/folder with the default program (desktop only)                     |
| `mk`                              | Compile with `make` on all cores                                               |
| `solong`                          | Kill a program by name (`pkill`) with the `SIGKILL` signal                     |
| `q`, `wq`                         | Exit the current terminal                                                      |
| `dodo`                            | Shuts the computer down (desktop only)                                         |

> Note: if the variable `colour_support` is set to `yes`, automatic colouring will be enabled for `ls`, `grep` and `ip` (i.e. the text will coloured only if the output is a terminal). This is autodetected in the variables script but can be overridden.

### Prompt

There are several prompts presets that can be enabled by setting the `prompt_style` and `colour_prompt_style` in the local configurtion file. By default, `colour_prompt_style` takes the value of `prompt_style`, which is the `default` prompt.

For coloured prompts, the user can also define the `user_colour_code` and `path_colour_code` (from `30` to `37`) to tweak the colours. By default, the username and hostname are in green for non-root users and mangenta for root, and the path is in blue.

If the variable `prompt_detect_sudo` is set to `true`, the prompt will display `(user as root)` instead of `root` as the user when it detects that the `sudo` command is being used. This is not enabled for the `basic` prompt.

If the variable `prompt_shorten_path` is set to `true` and there is an executable in `PATH` called `pwd-short`, the prompt will use this instead of the default path. It is one way to reduce the space taken by the prompt when working with very long paths. This is not enabled for the `basic` prompt.

If the `PS1` variable is defined in the local configuration file, the prompt style variables must be set to `local` to prevent the script from overriding the value.

Here are the values that can be used for prompt styles :

#### `basic`

The most classic style of bash prompt that most distributions will use by default. This is the only preset that does not support `prompt_detect_sudo` and `prompt_shorten_path`.

#### `default`

Essentially the same as `basic`, but supports all the configuration variables.

#### `owo`

For colour prompts only. Displays a face at the left of the prompt that gets sadge when a command fails.

Detects if the previous command ended at the beginning of a new line and goes to the next line if necessary.

#### `multiline`

For colour prompts only. Displays the prompt on two lines with :

- The date, the error code (if non-zero) and the path on the first line
- The user and the hostname

Detects if the previous command ended at the beginning of a new line and goes to the next line if necessary.
