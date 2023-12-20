#!/bin/bash

#SBATCH --account=PAS1117
#SBATCH --job-name=gene_annotation_project1
#SBATCH --time=20:00:00
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=24
#SBATCH --error=/fs/project/PAS1117/ricardo/metaG/project1/code/jobs/%x_%j.err
#SBATCH --output=/fs/project/PAS1117/ricardo/metaG/project1/code/jobs/%x_%j.out

source ~/miniconda3/bin/activate

conda activate annotation


       # make a directory
       # make a directory
        
        NUM_THREADS=$SLURM_NTASKS
          
        samples=/fs/scratch/Sullivan_Lab/Ricardo/gtdb_Lactobacillus/2023-07-21_18-32-01/df_names.txt
        directory=/fs/scratch/Sullivan_Lab/Ricardo/gtdb_Lactobacillus/

        #mkdir $directory/8.annotation_gene

        #mydir=$directory/8.annotation_gene

        # for loop
        for prefix in `awk '{print $1}' $samples`
        do
        
            echo "On sample: $prefix"

            # Calculate the number of bins
            num_bins=$(ls -1 "${directory}/6.mag_purify/cleaned_bins/${prefix}"*_cleaned.fasta | wc -l)

            echo "You have $num_bins bins in the sample $prefix"
            
            # Iterate over the bins
            for ((i=1; i<=num_bins; i++))
            do
            
                    # Generate the input and output filenames for each iteration
                    bin="$directory"/6.mag_purify/cleaned_bins/${prefix}.${i}_cleaned.fasta
                    output="$directory"/8.annotation_gene/${prefix}.${i}
                    prefix_prokka=$(basename $output)
                    
                    # run PROKKA
                    prokka --outdir $output --prefix $prefix_prokka --kingdom Bacteria --metagenome --cpus $SLURM_NTASKS $bin

                    # output Uniprot IDs of the .gff file
                    grep -o 'UniProt.*' $output/${prefix_prokka}.gff | awk -F'[:;=]' '{print $2 "\t" $6}' > $directory/8.annotation_gene/lits_uniprot_IDs/list_uniprotIDs_${prefix_prokka}.tsv


            done
        
        done

echo "job is done"


