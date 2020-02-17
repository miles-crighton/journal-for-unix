# Journaler for Unix

A bash script for quickly generating and accessing local journal entries

## How to install and use

Clone the repository to your desired journaling directory
```
git clone https://github.com/miles-crighton/journal-for-unix.git
```
Run the bash script 
```
./journaler.sh
```
Input your preferred text editor and journal away!

## Feature flags
Heres a list of flags to access additional features:

- Open a specific journal entry: `-d <DD-MM-YYY>`
- Change your default text editor command: `--change-editor <text-editor-cmd>`

## To-do

- [ ] Check permission on clone
- [ ] Add info on adding bash alias

Tested with bash 3.2
