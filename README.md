# bash-script-backup-files
Bash script which allows to create compressed archive.

# Requirements
Due to create lock file you have to have superuser privileges.

# Variables
Name of lock file.
````bash
lock_file_name="${0}.lock"
````

Directory where to store lock file.
````bash
lock_file_path="/var/lock/"
````

Full lock file path.
````bash
lock_file="${lock_file_path}${lock_file_name}"
````

Directory to backup.
````bash
backup_dir="${1}"
````

Suffix of backup file name.
````bash
backup_file_name="backup.tar.gz"
````

Full name of backup.
````bash
backup_full_name="$(date +%F-%H-%M)"."${backup_file_name}"
````

# How to use it?
````bash
sudo ./backup_files.sh [FILE/DIR...]
````

# Example
````bash
sudo ./backup_files.sh /tmp
````



