#!/bin/sh

# Verify that 7z is installed
command -v 7z >/dev/null 2>&1 || { echo >&2 "This script requires 7z.  Aborting."; exit 1; }

jd="/opt/jd-cli"
dex2jar="/opt/dex-tools-2.1-SNAPSHOT/d2j-dex2jar.sh"

if [ $# -eq 0 ]
  then
    echo "Usage: extract.sh <test.apk>"
    exit 1
fi

# Extract the apk
echo "apk file: $1"
DIRECTORY=$(dirname ${1})
FILE=$(basename ${1})

echo "[7z] Extracting apk files to: $1.files/"
mkdir $1.files
7z x $1 -o$1.files/

echo "[dex2jar] Creating temporary .jar file"
$dex2jar $1 -o $FILE.jar

echo "[jd-cli] Extracting source files to: $1.src/"
$jd --outputDir $1.src $FILE.jar 2> /dev/null

echo "Removing temporary .jar file"
rm $FILE.jar
