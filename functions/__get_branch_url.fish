# meant only to be called by github.fish
function __get_branch_url
    set -l fetch_url $argv[1]
    set -l branch (command git rev-parse --abbrev-ref HEAD)

    if [ $branch = 'HEAD' ]
        # couldn't find a branch or tag, so use the commit hash
        set branch (command git rev-parse HEAD)
    end

    set -l url (echo "$fetch_url/tree/$branch" | sed 's|git@github.com:\(.*\)\.git|https://github.com/\1|')
    echo "$url"
end