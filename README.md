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

### Optionally: create bash shortcut function
Run this command from the project directory:
```
echo "journal() { "$PWD"/journaler.sh \$@; }" >> ~/.bash_profile
```

You should now be able to run the program simply using:
```
journal
```

## Feature flags
Heres a list of flags to access additional features:

- Open a specific journal entry: `-d <DD-MM-YYY>`
- Change your default text editor command: `--change-editor <text-editor-cmd>`

## To-do

- [ ] Append time of entry to each entry

Tested with bash 3.2
