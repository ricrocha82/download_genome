#!/bin/bash

# 1.
# entrez package ##
conda activate entrez-direct
# download Escherichia coli str. K-12 substr. MG1655, complete genome
# download on 1st of August 2023
# https://www.ncbi.nlm.nih.gov/nuccore/U00096
esearch -db nucleotide -query "U00096.3" | efetch -format fasta > U00096.3.fasta

# 2.
## seqkit package ##
conda activate seqkit
# https://bioinf.shenwei.me/seqkit/

# stas in tabular format
seqkit stats /fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli/U00096.3.fasta -T 

# split the fasta file into overlapping windows of 99,000 bps window of 50,000
seqkit sliding -s 50000 -W 99999 U00096.3.fasta -o U00096.3.split.fasta

seqkit stats U00096.3.split.fasta -T 


# 3.
## make fasta file for each splited sequence ##
# Path to the big FASTA file
# input_fasta_file="U00096.3.split.fasta"

# # Temporary directory to store the individual sequences
# temp_dir="/fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli/temporary_sequences"

# # Create the temporary directory if it doesn't exist
# mkdir -p "$temp_dir"

# # Use awk to split the FASTA file into individual files
# awk '/^>/{filename=substr($0, 2) ".fasta"; next} {print >> filename}' "$input_fasta_file"

# # Move the individual sequence files to the destination directory (optional)
# destination_dir="/fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli/splitted_fasta"
# mkdir -p "$temp_dir"
# mv "$temp_dir"/*.fasta "$destination_dir"

# # Remove the temporary directory
# rm -r "$temp_dir"