# How to use OCLint

## Installation

```
brew tap oclint/formulae
brew install
```

## Updating

```
brew update
brew upgrade oclint
```

## Other Tools

### xcpretty


```
gem install xcpretty
```

If you are using rvm

```
cd $YOUR_LOCAL_PROJECT_FOLDER
bundle install
```

## How to use

### Xcode

1. Open Xcode
2. Change to OCLint Target
3. Adjust Build Phases Script
  Filter the files you want to check, or comment that ruby line if you want to lint the whole project
4. Build (command + B)
5. Check those warnings

```
source ~/.bash_profile
cd ${SRCROOT}
xcodebuild clean
xcodebuild | xcpretty -r json-compilation-database
cat build/reports/compilation_db.json > compile_commands.json
# filter selected files
sh 'ruby Scripts/OCLint/oclint_filter.rb ".+AAConstants.m" ".+AAAppDelegate.m"'
oclint-json-compilation-database -e "APIV1/3rdLibs/.+" -- -report-type xcode
```

## Generate html report from command line

1. Go to Project SRC Folder
2. Run the following script
3. Open "report.html" file to check all the warnings


```
source ~/.bash_profile
source "$HOME/.rvm/scripts/rvm"
xcodebuild clean
xcodebuild | xcpretty -r json-compilation-database
cat build/reports/compilation_db.json > compile_commands.json
ruby Scripts/OCLint/oclint_filter.rb ".+AAConstants.m" ".+AAAppDelegate.m"
oclint-json-compilation-database -e "APIV1/3rdLibs/.+" -- -report-type html -o report.html
```

## OCLint rules

Rules are list in file .oclint
