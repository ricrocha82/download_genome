#!/bin/bash


       # make a directory

       # make a directory
        
        NUM_THREADS=12
          
        #samples=/fs/project/PAS1117/ricardo/metaG/project1/samples.txt
        cd /fs/scratch/Sullivan_Lab/Ricardo/gtdb_Lactobacillus

        #mkdir $directory/8.annotation_gene

        #mydir=$directory/8.annotation_gene

        # for loop
        for prefix in *.fna.gz`
        do
        
            echo "On sample: $prefix"
            prefix_prokka=$(basename $prefix)

            #echo $prefix_prokka

        # run PROKKA
                
                prokka --outdir $output --prefix $prefix_prokka --kingdom Bacteria --metagenome --cpus $SLURM_NTASKS $bin

        # output Uniprot IDs of the .gff file
                grep -o 'UniProt.*' $output/${prefix_prokka}.gff | awk -F'[:;=]' '{print $2 "\t" $6}' > $directory/8.annotation_gene/lits_uniprot_IDs/list_uniprotIDs_${prefix_prokka}.tsv

        done

echo "job is done"


