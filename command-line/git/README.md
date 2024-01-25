
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

| Command             | Effect                                                   |
|---------------------|----------------------------------------------------------|
| `st`                | Summarized `status`                                      |
| `ll`                | Compact pretty `log`                                     |
| `lg`                | Detailed pretty `log`                                    |
| `df`                | `diff` with `vimdiff`                                    |
| `lb`                | Pretty list of branches                                  |
| `rb <branch>`       | Remove branch                                            |
| `root`              | Prints the path to the root of the repository            |
| `last`              | Detailed information on the commit at `HEAD`             |
| `rclone`            | Parallel recursive `clone`                               |
| `sup`               | Recursive submodule update                               |
| `staged`            | `diff` between `HEAD` and staged files                   |
| `unstage <path...>` | Ustages modifications                                    |
| `sweep`             | Removes all ingored files                                |
| `wipe`              | Erases all modifications (staged and untracked)          |
| `nope`              | Cancels last `commit`, leaves modifications in stage     |
| `poule`             | Funny `pull`                                             |
| `pousse`            | Funny `push`                                             |
| `fpush`             | Force `push` but asks the user if they are *sure*        |
| `cfg`               | Edit this configuration (`~/.config/git/config`)         |
| `lcfg`              | Edit the local configuration (`~/.gitconfig`)            |
| `rcfg`              | Edit the repository configuration (`<root>/.git/config`) |

