evalcache () {
    local cache_dir="${XDG_CACHE_HOME}/zsh/eval"
    local cache_file="${cache_dir}/${(j:_:)@:gs/\//_}.zsh"

    if [[ -r "${cache_file}" ]] && ! whence ${1} > /dev/null; then
        # remove cache file when it's present, but arg isn't executable
        echo "evalcache ERROR: $1 isn't executable, removing cache file" >&2
        command rm -f "${cache_file}*"
    elif [[ ! -e "${cache_file}" || -n "${cache_file}"(#qN.mh+20) ]]; then
        # revalidate cache every 20 hours
        # cache miss
        if (( ${+commands[${1}]} )); then
            mkdir -p "${cache_dir}"
            command "$@" > "${cache_file}"
            source "${cache_file}"
        else
            echo "evalcache ERROR: $1 is not available in PATH" >&2
        fi
    else
        # cache hit
        source "${cache_file}"
    fi
}

compdefcache () {
    local cache_dir="${XDG_CACHE_HOME}/zsh/fpath"
    local cache_file="${cache_dir}/_${1##/*}"

    # revalidate cache every 20 hours
    if [[ -r "${cache_file}" ]] && ! whence ${1} > /dev/null; then
        # remove cache file when it's present, but arg isn't executable
        echo "compdefcache ERROR: $1 isn't executable, removing cache file" >&2
        command rm -f "${cache_file}"
    elif [[ ! -e "${cache_file}" || -n "${cache_file}"(#qN.mh+20) ]]; then
        # revalidate cache every 20 hours
        # cache miss, create compdef file
        if (( ${+commands[${1}]} )); then
            mkdir -p "${cache_dir}"
            command "$@" > "${cache_file}"
        else
            echo "compdefcache ERROR: $1 is not available in PATH" >&2
        fi
    else
        # cache hit, do nothing
    fi
}
