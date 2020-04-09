#!/bin/sh

# check that 7z is installed
command -v 7z >/dev/null 2>&1 || { echo >&2 "This script requires 7z.  Aborting."; exit 1; }

jdgui="/opt/jd-cli"
dex2jar="/opt/dex-tools-2.1-SNAPSHOT/d2j-dex2jar.sh"

if [ $# -eq 0 ]
  then
    echo "Usage: extract.sh <test.apk>"
    exit 1
fi

# extracting the apk
echo "apk file: $1"
DIRECTORY=$(dirname ${1})
FILE=$(basename ${1})

echo "Creating directory $FILE.files"
# echo "mkdir $1.files"
mkdir $1.files

echo "Extracting apk to $1.files/"
7z x $1 -o$1.files/

echo "Generating $FILE.jar in $1.files/"
# echo "$dex2jar $dexfile -o $1.files/$FILE.jar"
$dex2jar $1 -o $FILE.jar

echo "Opening jd-gui with .jar file"
# echo "$jdgui $1.files/$FILE.jar"
$jdgui -od $1.src $FILE.jar 2> /dev/null

echo "Removing created .jar file"
rm $FILE.jar
