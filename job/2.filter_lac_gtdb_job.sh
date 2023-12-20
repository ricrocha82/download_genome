#!/bin/bash

#SBATCH --account=PAS1117
#SBATCH --job-name=job_filer_lac_operon_tool
#SBATCH --time=20:00:00
#SBATCH --nodes=1 #SBATCH 
#SBATCH --ntasks-per-node=24
#SBATCH --error=/fs/project/PAS1117/ricardo/operon_tool/job/%x_%j.err
#SBATCH --output=/fs/project/PAS1117/ricardo/operon_tool/job/%x_%j.out


echo "start job"


# Path to the source directory
source_dir="/fs/scratch/Sullivan_Lab/Ricardo/database/gtdb/gtdb_genomes_reps_r214/only_fasta_gtdb"

# Path to the destination directory
destination_dir="/fs/scratch/Sullivan_Lab/Ricardo/database/gtdb/lactobacillus"

# File containing the list of filenames
# file_list="/fs/scratch/Sullivan_Lab/Ricardo/database/accession_lac.txt"
file_list="/fs/project/PAS1117/ricardo/operon_tool/accession_numb_gtdb_lac.txt"

# Use awk to read the file_list.txt and copy or move files accordingly
awk '{print $0}' "$file_list" | while IFS= read -r filename
do
    full_filename="${filename}_genomic.fna.gz"
    find "$source_dir" -type f -name "$full_filename" -exec cp -t "$destination_dir" {} +
    # Use the following line to move the files instead of copying them
    # find "$source_dir" -type f -name "$full_filename" -exec mv -t "$destination_dir" {} +
done

echo "job is done"