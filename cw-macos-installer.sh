#!/bin/bash

# Configuration
REPO="matt-charr/cw-releases"
TARGET_PATTERN="cw-*-macos.zip"
DEST_DIR="cw-macos"

echo "=== Step 1 : Check if Homebrew is installed ====="
if ! command -v brew &> /dev/null
then
    echo "Homebrew is not installed. Installation..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ $? -ne 0 ]; then
        echo "Homebrew downloaded with failure."
        exit 1
    fi
    echo "Homebrew downloaded with success."
fi

echo "=== Step 2 : Check if Github CLI is installed ==="
if ! command -v gh &> /dev/null
then
    echo "Github CLI is not installed. Installation..."
    brew install gh
    if [ $? -ne 0 ]; then
        echo "GitHub CLI downloaded with failure."
        exit 1
    fi
    echo "Github CLI downloaded with success."
fi

echo "=== Step 3 : Donwload latest release ============"
gh release download --repo $REPO --pattern $TARGET_PATTERN

if [ $? -ne 0 ]; then
    echo "Download failure."
    exit 1
fi

echo "=== Step 4 : Extraction ========================="
unzip "$TARGET_PATTERN" -d "$DEST_DIR"
if [ $? -ne 0 ]; then
    echo "Extraction failure."
    exit 1
fi

echo "=== Step 5 : Cleanup ============================"
rm -f "$ZIP_FILE"

echo "=== Finished ===================================="
echo "File extracted in $DEST_DIR."

exit 0