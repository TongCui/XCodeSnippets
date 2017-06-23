OCLint

[Using OCLint in Xcode](http://oclint-docs.readthedocs.io/en/stable/guide/xcode.html)

# Prerequisite

- oclint (homebrew)
- xcpretty
- rvm

# Steps

## Setting up Target
- Add a new target, choose **Aggregate**
- Add Run Script in Build Phase

## Script

```
source ~/.bash_profile
cd ${SRCROOT}
xcodebuild clean
xcodebuild | xcpretty -r json-compilation-database -o compile_commands.json
oclint-json-compilation-database -e "APIV1/3rdLibs/.+" -- -report-type xcode

``` 
