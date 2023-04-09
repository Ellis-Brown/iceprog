#!/bin/bash
set -euo pipefail

# create a .iceprog-es4 directory in the home directory
mkdir -p ~/.iceprog-es4


# Look at the architecture of the machine and download a binary based on mac vs linux (looking at uname)
if [[ $(uname) == "Darwin" ]]; then
    curl -L "https://raw.githubusercontent.com/Ellis-Brown/iceprog/main/iceprog" -o iceprog
else
    curl -L "https://raw.githubusercontent.com/Ellis-Brown/iceprog/main/linux-iceprog" -o iceprog
fi

# change permissions to make it executable
chmod +x iceprog

# move executable to the .iceprog-es4 directory
mv iceprog ~/.iceprog-es4/iceprog

# spit out a helpful message about adding to PATH based on the shell
if [[ $SHELL == "/bin/bash" ]]; then
    echo 'export PATH='$HOME'/.iceprog-es4:$PATH' >> "$HOME"/.bashrc
elif [[ $SHELL == "/bin/zsh" ]]; then
    echo 'export PATH='$HOME'/.iceprog-es4:$PATH' >> "$HOME"/.zshrc
elif [[ $SHELL == "/bin/tcsh" ]]; then
    echo 'setenv PATH '$HOME'/.iceprog-es4:$PATH' >> "$HOME"/.cshrc
else
    echo "WARNING: Unrecognized shell. Please add "$HOME"/.iceprog-es4 to your PATH"
fi

succ=0

# check for successful installation
if "$HOME"/.iceprog-es4/iceprog --help 2>/dev/null; then
    printf "\n"
    succ=1
else
    echo "iceprog failed to install. Please try again."
fi

if [[ $succ == 1 ]]; then
    # Check which shell to print the correct message
    if [[ $SHELL == "/bin/bash" ]]; then
        echo "iceprog installed successfully! Please update your PATH by running"
        printf '\n\tsource '$HOME'/.bashrc\n'
    elif [[ $SHELL == "/bin/zsh" ]]; then
        echo "iceprog installed successfully! Please update your PATH by running"
        printf '\n\tsource '$HOME'/.zshrc\n'
    elif [[ $SHELL == "/bin/tcsh" ]]; then
        echo "iceprog installed successfully! Please update your PATH by running"
        printf '\n\tsource '$HOME'/.cshrc\n'
    else
        echo "iceprog installed successfully! Please restart your terminal to update your PATH."
    fi
else
    echo "iceprog failed to install. Please try again or contact Professor Bell."
fi
