#!/bin/bash

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

# 
# awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < /fs/project/PAS1117/ricardo/operon_tool/fasta_ecoli/splitted_fasta/U00096.3_sliding:1-100000.fasta
