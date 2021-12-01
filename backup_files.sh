#!/bin/bash
#
# Create compressed archive.

set -eu

lock_file_name="${0}_lock"
lock_file="/tmp/${lock_file_name}"
backup_dir="${1}"
backup_file="backup.tar.gz"
backup_name="$(date +%F-%H-%M)"."${backup_file}"


function is_running() {
    if [[ -e "${lock_file}" ]]; then
        printf "Found lock file, another instance of script is running?.\nExiting.\n" >&2
        exit 1
    fi
}

function create_lock_file() {
    touch "${lock_file}" || {
        printf "Cannot create lock file.\nExiting.\n" >&2
        exit 2
    }
}

function delete_lock_file() {
    rm -f "${lock_file}" || {
        printf "Cannot delete lock file.\nExiting.\n" >&2
        exit 3
    }
}


function handle_overwrite() {
    if [[ -e "${backup_name}" ]]; then
        printf "Found copy of backup file.\nExiting.\n" >&2
        delete_lock_file
        exit 5
    fi
}

function archive_files() {
    tar -zpcf "$(date +%F-%H-%M)"."${backup_file}" "${backup_dir}" || {
        printf "Cannot archive files.\nExiting.\n" >&2
        delete_lock_file
        exit 6
    }
}


trap delete_lock_file SIGINT SIGTERM

is_running
create_lock_file
handle_overwrite
archive_files
## Only for lock tests.
sleep 5
delete_lock_file

## TODO
## flock instead of touch lock file
## local variables?
## add connection to remote server

