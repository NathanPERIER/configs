
# Bash configuration

## Files

- **Main configuration file**: `bashrc.sh` -> `~/.bashrc`
- **Variables script**: `bash_variables.sh` -> `~/.config/bash/variables`
- **Local script**: `~/.bash_local`
- **Aliases script**: `bash_aliases.sh` -> `~/.config/bash/aliases`
- **Prompt script**: `bash_prompt.sh` -> `~/.config/bash/prompt`

### Login shell

Bash uses a specific script for login shells, which can be used to modify environment variables for the entire user session. There is also an optional additional file for case-by-case customisations :

- **Main configuration file**: `profile.sh` -> `~/.profile`
- **Local script**: `~/.profile_local`

The file tracked in this repository adds the following directories to the `PATH` if they are not already there :

- `/usr/sbin`
- `${HOME}/bin`
- `${HOME}/.local/bin`

## Features

### Prompt

There are several prompts presets that can be enabled by setting the `prompt_style` and `colour_prompt_style` in the local configurtion file. By default, `colour_prompt_style` takes the value of `prompt_style`, which is the `default` prompt.

If a `starship_theme` variable exists and the `starship` binary is installed, the other variables are not taken into account and [starship](https://starship.rs/) is used to manage the prompt, using the associated TOML configuration in `~/.config/starship`.

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
