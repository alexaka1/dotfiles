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

#if ! command -v somecommand >/dev/null 2>&1; then
#    installhere
#fi

if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
source $HOME/.zshrc
brew analytics off

source $HOME/.zshrc

# then https://github.com/drduh/YubiKey-Guide?tab=readme-ov-file#copy-public-key
if [[ ! -f "$HOME/.gnupg/gpg.conf" ]]; then
    curl https://raw.githubusercontent.com/drduh/config/master/gpg.conf > $HOME/.gnupg/gpg.conf
    curl https://raw.githubusercontent.com/drduh/config/master/gpg-agent.conf > $HOME/.gnupg/gpg-agent.conf
    sed -i.bak 's|^pinentry-program .*|pinentry-program /usr/local/bin/pinentry-mac|' $HOME/.gnupg/gpg-agent.conf
fi