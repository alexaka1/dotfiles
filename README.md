# dotfiles

My basic setup.

## Installation (MacOS)

Firstly we need git, which is cleanest to get from xcode command line tools.

```shell
xcode-select --install
```

Now clone the repo.

```shell
git clone https://github.com/alexaka1/dotfiles.git ~/.alexaka1
cd ~/.alexaka1
```

### Zsh

```shell
cd ~/.alexaka1/zsh
chmod +x ./install/install.sh
./install/install.sh
```

then restart your terminal.

### Apps (Homebrew)

Use `apps/homebrew/apps` to install any app you need. Look up what each app does before installing.
