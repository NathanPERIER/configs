
# Git configuration files

## Install

`config` -> `~/.config/git/config`

In order to enable updating the config file without overwriting local data (e.g. username, email, ...), the configuration is actually stored in another file that is loaded by the main configuration (`~/.gitconfig`) :

```bash
git config --global --add include.path '~/.config/git/config'
```

## Content

- Default branch is `master`
- Editor is `vim`
- `git pull --rebase` by default

### Custom commands

| Command                   | Effect                                                   |
|---------------------------|----------------------------------------------------------|
| `st`                      | Summarized `status`                                      |
| `ll`                      | Compact pretty `log`                                     |
| `lg`                      | Detailed pretty `log`                                    |
| `df`                      | `diff` with `vimdiff`                                    |
| `lb`                      | Pretty list of branches                                  |
| `rb <branch>`             | Remove branch                                            |
| `root`                    | Prints the path to the root of the repository            |
| `last`                    | Detailed information on the commit at `HEAD`             |
| `rclone`                  | Parallel recursive `clone`                               |
| `sup`                     | Recursive submodule update                               |
| `recurse <cmd> [args...]` | Executes a command in the repository and its submodules  |
| `staged`                  | `diff` between `HEAD` and staged files                   |
| `unstage <path...>`       | Ustages modifications                                    |
| `sweep`                   | Removes all ingored files                                |
| `wipe`                    | Removes all untracked files                              |
| `nope`                    | Cancels last `commit`, leaves modifications in stage     |
| `poule`                   | Funny `pull`                                             |
| `pousse`                  | Funny `push`                                             |
| `fpull`                   | Synchronises the current branch with its upstream        |
| `fpush`                   | Force `push` but asks the user if they are *sure*        |
| `cfg`                     | Edit this configuration (`~/.config/git/config`)         |
| `lcfg`                    | Edit the local configuration (`~/.gitconfig`)            |
| `rcfg`                    | Edit the repository configuration (`<root>/.git/config`) |

