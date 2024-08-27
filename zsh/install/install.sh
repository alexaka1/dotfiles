#!/bin/zsh

# Function to copy content from a source file to target file, between specific comments
function update_delimiters {
    # Declare local variables
    local src_file="$1"
    local target_file="$2"
    local start_comment="#### copied from alexaka1's dotfiles - start"
    local end_comment="#### copied from alexaka1's dotfiles - end"

    # Check if the target file exists, create if it doesn't
    if [[ ! -f "$target_file" ]]; then
        touch "$target_file"
    fi

    # Read the content of the source file
    local file_content
    file_content=$(<"$src_file")

    # Check if the target file contains the start and end comments
    if grep -q "$start_comment" "$target_file"; then
        # Replace the content between the comments
        sed -i.bak -e "/$start_comment/,/$end_comment/{//!d;}" "$target_file"
        sed -i.bak -e "/$start_comment/r /dev/stdin" "$target_file" <<<"$file_content"
    else
        # Append the content to the end of the file, between the comments
        {
            echo ""
            echo "$start_comment"
            echo "$file_content"
            echo "$end_comment"
            echo ""
        } >> "$target_file"
    fi
}

update_delimiters ~/.alexaka1/zsh/zprofile $HOME/.zprofile
update_delimiters ~/.alexaka1/zsh/zshenv $HOME/.zshenv
update_delimiters ~/.alexaka1/zsh/zshrc $HOME/.zshrc

source $HOME/.zshrc

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

source $HOME/.zshrc

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

brew install --cask iterm2
brew install --cask commander-one
brew install coreutils
brew install jq