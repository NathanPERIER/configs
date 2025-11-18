
# Shell configuration

## Startup sequence

This repository completely overwrites the main startup scripts for supported shells.

In order to organise the features, the configuration is split into several sub-scripts, which are exectued in the following order :

1. **Variables script**: Sets some variables that will be used by the following scripts, based on pre-defined rules.
2. **Local script**: Optional, allows case-by-case customisations (e.g. modifying variables, sourcing external scripts, ...).
3. **Aliases script**: Creates aliases and functions that can be used during the session.
4. **Prompt script**: Initialises the prompt to be used for the current session.

Only the second script is not tracked by this repository. It is important that user customisations be made exclusively there.

## Features

### Variables

#### Environment

The variables script exports the following varaibles to the global environment :

| Variable        | Values                                         |
|-----------------|------------------------------------------------|
| `MACHINE_TYPE`  | `wsl`, `desktop`, `server`                     |
| `TERMINAL_TYPE` | `gnome`, `windows`, `vscode`, `xterm`, `other` |

> [!WARNING]
> The desktop/server detection is currently done by checking some environment variables and the existance of a given binary, may not work reliably on all systems.

#### User

The following variables enable the user to control the features offered by subsequent scripts :

| Variable         | Default                      | Effect                                                  |
|------------------|------------------------------|---------------------------------------------------------|
| `colour_support` | auto-detected (`yes` / `no`) | Enables coloured output for common utilities by default |
| `shared_homedir` | `false`                      | Indicated that the home directory might be shared by several users (e.g. `root`) and that some intrusive features must be disabled |

Variables for controlling the prompt are specific to the type of shell and are not described here.

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
| `ed`, `nano`, `emacs`             | Redirect any file editor to `vim` (unless in shared environments)                        |
| `eb`                              | Edit the main configuration file                                                         |
| `ebv`                             | Edit the variables configuration script                                                  |
| `ebl`                             | Edit the local configuration script                                                      |
| `eba`                             | Edit the aliases configuration script                                                    |
| `ebp`                             | Edit the prompt configuration script                                                     |
| `sb`                              | Source the shell configuration file                                                      |
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

If the variable `colour_support` is set to `yes`, automatic colouring will be enabled for `ls`, `diff`, `grep` and `ip` (i.e. the text will coloured only if the output is a terminal).
