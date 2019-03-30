#!/usr/bin/env fish
function github --description 'Open the GitHub page for the current git branch'
    set -l fetch_url (git ls-remote --get-url ^/dev/null)

    if [ $status -gt 0 ]
        echo 'Not in a git repository.' >&2
        return 1
    else if [ -z $fetch_url ]
        echo 'Not in a git repository.' >&2
        return 1
    else if [ -z (echo $fetch_url | grep "^git@github.com" ) ]
        echo 'The upstream remote of the current branch is not a GitHub repository.' >&2
        return 2
    end

    # generate the repository's GitHub homepage from the fetch url, e.g.
    # git@github.com:patrickf3139/open_github.git -> https://github.com/patrickf3139/open_github
    set github_base_url (echo "$fetch_url" | sed 's|git@github.com:\(.*\)\.git|https://github.com/\1|')

    if set -q argv[1]; and [ "$argv[1]" = "--pr" ]
        set url (__get_pr_url "$github_base_url")
    else
        set url (__get_branch_url "$github_base_url")
    end

    if [ -z $url ]
        echo 'Failed to generate the url!' >&2
        return 3
    else
        command open "$url"
    end
end
