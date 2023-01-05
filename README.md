# .dotfiles

- Clone this repo to a good location like: `~/.dotfiles`
- Run `./setup.sh` to link the dotfiles
- Run `./packages.sh` to install the packages (the list is at `./packages.txt`)

Custom zsh configurations can be set in the `./home/.zsh/custom` folder and will
be ignored by git.

## Initialization/Updating

When you run the `./setup.sh` script, it will pull the repository. Oh-my-zsh is
a git submodule and the setup script initializes/updates it every time it gets
ran. As well, it pulls `powerlevel10k`, `zsh-autosuggestions` and
`zsh-syntax-highlighting` are downloaded. This script works as an initialization
and a pull script.

## Structure

The setup script will link all of the files in `./home` to the current user's
home directory. By default, it will link each child of `./home` to `~/child`,
except the `.config` and `.scripts` directories, which will link their children:
`home/.config/nvim` will map to `~/.config/nvim`, (allows `~/.config` to have
folders that aren't linked and tracked)
