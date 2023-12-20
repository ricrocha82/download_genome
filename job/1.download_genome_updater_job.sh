#!/bin/bash

#SBATCH --account=PAS1117
#SBATCH --job-name=download_genome_updater
#SBATCH --time=30:00:00
#SBATCH --nodes=1 #SBATCH 
#SBATCH --ntasks-per-node=24
#SBATCH --error=/fs/project/PAS1117/ricardo/operon_tool/job/%x_%j.err
#SBATCH --output=/fs/project/PAS1117/ricardo/operon_tool/job/%x_%j.out

source ~/miniconda3/bin/activate
conda activate genome_updater

NUM_THREADS=$SLURM_NTASKS

# https://github.com/pirovc/genome_updater

# run the job in the working directory

##--- Complete Bacterial Genomes ---##
# 01. RefSeq
# Download Bacterial complete genome sequences from the refseq repository (-t number parallel downloads):
# (-m to check integrity of downloaded files, -u extended assembly accession report)
echo "(1) refseq - Bacteria"
genome_updater.sh -d "refseq" -g "bacteria" -l "complete genome" -f "genomic.fna.gz,assembly_report.txt" -o "bac_refseq_cg" -t $NUM_THREADS -rpu

# 02. GTDB
# All genome sequences used in the latests GTDB release
echo "(2) GTDB - Bacteria"
genome_updater.sh -d "refseq" -g "bacteria" -l "complete genome" -f "genomic.fna.gz,assembly_report.txt" -o "bac_gtdb_cg" -M "gtdb" -t $NUM_THREADS -rpu


##--- Lactobacillus ---###
#01. RefSeq
# Download all Lactobacillus complete genomes (NCBI Taxonomy ID 1578)
echo "(3) refseq - Lactobacillus"
genome_updater.sh -d "refseq" -g "bacteria" -M ncbi -T "1578" -l "complete genome" -f "genomic.fna.gz,assembly_report.txt" -o "refseq_Lactobacillus" -t $NUM_THREADS -rpu

# 02. GTDB
# All assemblies from Lactobacillus in GTDB
echo "(4) GTDB - Lactobacillus"
genome_updater.sh -d "refseq" -g "bacteria" -M "gtdb" -T "g__Lactobacillus" -l "complete genome" -f "genomic.fna.gz,assembly_report.txt" -o "gtdb_Lactobacillus"  -t $NUM_THREADS -rpu


##--- UPDATE ---##
# Some days later, update the repository:
#./genome_updater.sh -o "arc_refseq_cg"

echo "job is done"