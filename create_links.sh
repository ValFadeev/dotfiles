#! /bin/bash

set -e

create_links_from() {
    local input="$1"
    while IFS= read -r item
    do
        local src="$HOME/.${item}"
        local trg=".dotfiles/${item}"
        if [[ -f "${src}" ]] || [[ -d "${src}" ]]; then
            echo "${src} already exists!"
        else
            echo "Creating link ${src} -> ${trg}..."
            ln -s "${trg}" "${src}"
        fi
    done < "$input"
    echo "Done!"
}

main() {
    create_links_from link_list
}

main "$@"
