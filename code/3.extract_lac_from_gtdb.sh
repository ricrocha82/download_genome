#!/bin/bash

# Path to the source directory
source_dir="/fs/scratch/Sullivan_Lab/Ricardo/database/gtdb/"

# Path to the destination directory
destination_dir="/fs/scratch/Sullivan_Lab/Ricardo/database/gtdb/lactobacillus"

# File containing the list of filenames
# file_list="/fs/scratch/Sullivan_Lab/Ricardo/database/accession_lac_refseq.txt"
file_list="/fs/project/PAS1117/ricardo/operon_tool/files/accession_numb_gtdb_lac.txt"

# Use awk to read the file_list.txt and copy or move files accordingly
awk '{print $0}' "$file_list" | while IFS= read -r filename
do
    full_filename="${filename}_genomic.fna.gz"
    find "$source_dir" -type f -name "$full_filename" -exec cp -t "$destination_dir" {} +
    # Use the following line to move the files instead of copying them
    # find "$source_dir" -type f -name "$full_filename" -exec mv -t "$destination_dir" {} +
done

# Use gnu parallel to read the file_list.txt and copy or move files accordingly
# cat "$file_list" | parallel -j0 find "$source_dir" -type f -name {} -print0 | xargs -0 cp -t "$destination_dir"
