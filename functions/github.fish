#!/usr/bin/env fish
function github --description 'Open the GitHub page for the current git branch'
    set -l fetch_url (git ls-remote --get-url ^/dev/null)

    if [ $status -gt 0 ] || [ -z $fetch_url ]
        echo 'Not in a git repository.' >&2
        return 1
    else if not string match --entire --quiet "git@github.com" $fetch_url
        echo 'The upstream remote of the current branch is not a GitHub repository.' >&2
        return 2
    end

    # generate the repository's GitHub homepage from the fetch url, e.g.
    # git@github.com:patrickf1/github.fish -> https://github.com/patrickf1/github.fish
    set github_base_url (echo "$fetch_url" | sed 's|git@github.com:\(.*\)\.git|https://github.com/\1|')

    # https://fishshell.com/docs/current/commands.html#argparse
    argparse --name='github' --max-args=0 'p/pr' 'd/debug' -- $argv
    or return
    set debug_mode $_flag_debug

    if set -q _flag_pr
        set url (__get_pr_url "$github_base_url" $debug_mode)
    else
        set url (__get_branch_url "$github_base_url")
    end
    set -q debug_mode[1]; and echo "Url generated was $url" >&2

    if [ -z $url ]
        echo 'Failed to generate the url!' >&2
        return 3
    else
        open "$url"
    end
end
