#!/bin/bash

#SBATCH --account=PAS1117
#SBATCH --job-name=job_NNPP_promoter
#SBATCH --time=20:00:00
#SBATCH --nodes=1 #SBATCH 
#SBATCH --ntasks-per-node=24
#SBATCH --error=/fs/project/PAS1117/ricardo/operon_tool/job/%x_%j.err
#SBATCH --output=/fs/project/PAS1117/ricardo/operon_tool/job/%x_%j.out

cd /fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli


# fasta file
file_dir=/fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli/splitted_fasta
dir_out=/fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli/NNPP_output

mkdir -p $dir_out

 ls ${file_dir}/*.fasta  |  awk '{print "basename "$0}' | sh > samples

        # for loop - cutadapt
        for file in $(cat samples)
        do

            echo "On file: $file"

            fasta_in="$file_dir"/${file}

            #echo $fasta_in
            # Run TDNNN
            /fs/project/PAS1117/CONGO_PROJECT/Vaginal_Swabs/TOOL_DEV/metaron_files/NNPP2.2/bin/fa2TDNNpred-PRO.linux -t 0.8  $fasta_in > $dir_out/${file}_NNPP.txt

        done