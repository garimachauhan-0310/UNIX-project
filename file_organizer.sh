#!/bin/bash
# ==============================================================
# 🧩 File Organizer - Menu Driven Shell Script
# Author : Garima Chauhan
# Description : A UNIX shell script that organizes files into
#               folders based on file type.
# ==============================================================

# ---------- Function 1 : Organize Files ------------------------
organize_files() {
    echo
    read -p "Enter directory path to organize (or press Enter for current): " DIR
    DIR=${DIR:-.}

    # Check if directory exists
    if [ ! -d "$DIR" ]; then
        echo "❌ Directory does not exist!"
        return
    fi

    echo "Organizing files in directory: $DIR"
    sleep 1

    # Create category folders if they don’t exist
    mkdir -p "$DIR/Documents" "$DIR/Images" "$DIR/TextFiles" "$DIR/Videos" "$DIR/Music" "$DIR/Others"

    # Loop through all files in the directory
    for file in "$DIR"/*; do
        [ -d "$file" ] && continue  # skip directories
        ext="${file##*.}"
        ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')  # convert to lowercase

        case "$ext" in
            txt)
                mv "$file" "$DIR/TextFiles/"
                echo "📄 Moved $file → TextFiles/"
                ;;
            doc | docx | pdf | ppt | pptx)
                mv "$file" "$DIR/Documents/"
                echo "📚 Moved $file → Documents/"
                ;;
            jpg | jpeg | png | gif | bmp)
                mv "$file" "$DIR/Images/"
                echo "🖼️  Moved $file → Images/"
                ;;
            mp4 | mkv | avi | mov)
                mv "$file" "$DIR/Videos/"
                echo "🎬 Moved $file → Videos/"
                ;;
            mp3 | wav | m4a)
                mv "$file" "$DIR/Music/"
                echo "🎵 Moved $file → Music/"
                ;;
            *)
                mv "$file" "$DIR/Others/"
                echo "📦 Moved $file → Others/"
                ;;
        esac
    done

    echo
    echo "✅ All files have been organized successfully!"
    echo
}

# ---------- Function 2 : Show Subfolders -----------------------
show_folders() {
    echo
    read -p "Enter directory path to display folders (or press Enter for current): " DIR
    DIR=${DIR:-.}

    if [ ! -d "$DIR" ]; then
        echo "❌ Directory not found!"
        return
    fi

    echo "📁 Subfolders inside $DIR:"
    ls -d $DIR/*/ 2>/dev/null || echo "No subfolders found."
    echo
}

# ---------- Function 3 : Count Files ----------------------------
count_files() {
    echo
    read -p "Enter directory path to check file count (or press Enter for current): " DIR
    DIR=${DIR:-.}

    if [ ! -d "$DIR" ]; then
        echo "❌ Directory not found!"
        return
    fi

    echo "📊 File count in each folder:"
    for folder in Documents Images TextFiles Videos Music Others; do
        if [ -d "$DIR/$folder" ]; then
            count=$(ls "$DIR/$folder" | wc -l)
            echo "$folder : $count files"
        fi
    done
    echo
}

# ---------- Function 4 : Reset Organization --------------------
reset_folders() {
    echo
    read -p "Enter directory path to reset (or press Enter for current): " DIR
    DIR=${DIR:-.}

    if [ ! -d "$DIR" ]; then
        echo "❌ Directory not found!"
        return
    fi

    echo "♻️ Moving all files back to main directory..."
    for folder in Documents Images TextFiles Videos Music Others; do
        [ -d "$DIR/$folder" ] || continue
        mv "$DIR/$folder"/* "$DIR"/ 2>/dev/null
    done
    echo "✅ Reset complete!"
    echo
}

# ---------- Main Menu Loop --------------------------------------
while true; do
    echo "=============================="
    echo "     🧩 FILE ORGANIZER MENU    "
    echo "=============================="
    echo "1. Organize Files"
    echo "2. Show Organized Folders"
    echo "3. Count Files in Each Category"
    echo "4. Reset Organization"
    echo "5. Exit"
    echo "------------------------------"
    read -p "Choose an option (1-5): " choice

    case $choice in
        1) organize_files ;;
        2) show_folders ;;
        3) count_files ;;
        4) reset_folders ;;
        5) echo "👋 Exiting File Organizer. Bye, Garima!"; exit 0 ;;
        *) echo "❌ Invalid choice! Please try again." ;;
    esac
done
