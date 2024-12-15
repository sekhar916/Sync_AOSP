#!/bin/bash

MANIFEST_FILE=".repo/manifests/default.xml

# Function to parse the XML and get project names
get_projects() {
    grep -oP '(?<=<project path=\")[^\"]*' $MANIFEST_FILE
}

# Sync each project individually
sync_projects() {
    for project in $(get_projects); {
        echo "Syncing project: $project"
        repo sync $project -j32
    }
}

# Main function
main() {
    if [ ! -f $MANIFEST_FILE ]; then
        echo "Manifest file not found!"
        exit 1
    fi

    sync_projects
    echo "All projects synchronized successfully."
}

main
