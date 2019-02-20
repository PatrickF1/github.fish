function github --description 'Open the GitHub page for the current git branch'
    set -l fetch_url (git ls-remote --get-url ^/dev/null)

    if [ $status -gt 0 ]
        echo 'Not in a git repository.' >&2
        return 1
    else if [ -z $fetch_url ]
        echo 'Not in a git repository.' >&2
        return 1
    else if [ -z (echo $fetch_url | grep github ) ]
        echo 'The remote "origin" is not a GitHub repository.' >&2
        return 2
    end

    if set -q $argv[1]; and [ "$argv[1]" = "--pr" ]
        set url (__get_pr_url "$fetch_url")
    else
        set url (__get_branch_url "$fetch_url")
    end

    if [ -z $url ]
        echo 'Failed to generate the url!' >&2
        return 3
    else
        command open "$url"
    end
end
