#!/bin/bash

#SBATCH --account=PAS1117
#SBATCH --job-name=job_filer_lac_operon_tool
#SBATCH --time=20:00:00
#SBATCH --nodes=1 #SBATCH 
#SBATCH --ntasks-per-node=24
#SBATCH --error=/fs/project/PAS1117/ricardo/operon_tool/job/%x_%j.err
#SBATCH --output=/fs/project/PAS1117/ricardo/operon_tool/job/%x_%j.out


echo "start job"

# NCBI
find /fs/scratch/Sullivan_Lab/Ricardo/database/ncbi/lactobacillus -type f -name "*.fna.gz" -print0 | xargs -0 -I {} mv -t /fs/scratch/Sullivan_Lab/Ricardo/database/ncbi/only_fasta_ncbi {}
# GTDB
find /fs/scratch/Sullivan_Lab/Ricardo/database/gtdb/gtdb_genomes_reps_r214/database -type f -name "*.fna.gz" -print0 | xargs -0 -I {} mv -t /fs/scratch/Sullivan_Lab/Ricardo/database/gtdb/gtdb_genomes_reps_r214/only_fasta_gtdb {}


echo "job is done"