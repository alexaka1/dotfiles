#!/usr/bin/env bash

update_file_with_delimiters() {
    local source_file="$1"
    local destination_file="$2"

    # Read the content from the source file
    local new_content=$(cat "$source_file")

    # Check if the delimiters exist in the destination file
    if grep -q "#### copied from alexaka1's dotfiles" "$destination_file"; then
        # Replace the content between the delimiters
        awk -v new_content="$new_content" '
        BEGIN { found = 0 }
        {
            if ($0 == "#### copied from alexaka1'\''s dotfiles") {
                print new_content
                found = 1
                while (getline > 0) {
                    if ($0 == "#### copied from alexaka1'\''s dotfiles") {
                        found = 0
                        break
                    }
                }
            }
            if (found == 0) print
        }
        ' "$destination_file" > "$destination_file.tmp" && mv "$destination_file.tmp" "$destination_file"
    else
        # Append the content if the delimiters do not exist
        echo -e "\n#### copied from alexaka1's dotfiles" >> "$destination_file"
        echo -e "\n$new_content" >> "$destination_file"
        echo -e "\n#### copied from alexaka1's dotfiles" >> "$destination_file"
    fi

    echo "The file '$destination_file' has been updated with content from '$source_file'."
}

update_file_with_delimiters zprofile $HOME/.zprofile
update_file_with_delimiters zshenv $HOME/.zshenv
update_file_with_delimiters zshrc $HOME/.zshrc

source $HOME/.zshrc

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

source $HOME/.zshrc

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

brew install --cask iterm2
brew install --cask commander-one
brew install coreutils
brew install jq