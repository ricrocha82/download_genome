conda activate ncbi_download
# https://github.com/kblin/ncbi-genome-download
## RefSeq ##

# To download only completed bacterial RefSeq genomes in GenBank format of the genus Lactobacillus
# a dry rub to show the accessions to be downloaded
ncbi-genome-download --dry-run --assembly-levels complete --formats fasta --genera Lactobacillus bacteria > accesions_lac_refseq.txt
# to download the genomes in fasta format
ncbi-genome-download --assembly-levels complete --formats fasta --genera Lactobacillus bacteria
# move all the files to refseq/lactobacillus
mv /fs/scratch/Sullivan_Lab/Ricardo/database/refseq/lactobacillus/refseq/bacteria/* /fs/scratch/Sullivan_Lab/Ricardo/database/refseq/lactobacillus/
rmdir -r /fs/scratch/Sullivan_Lab/Ricardo/database/refseq/lactobacillus/refseq
# move files to one single folder
find /fs/scratch/Sullivan_Lab/Ricardo/database/ncbi/lactobacillus/ -type f -name "*.fna.gz" -print0 | xargs -0 -I {} mv -t /fs/scratch/Sullivan_Lab/Ricardo/database/refseq/only_fasta_ncbi/lactobacillus {}

## GTDB ##
# Genbank GCA_.... and RefSeq GCF_....

wget https://data.gtdb.ecogenomic.org/releases/latest/genomic_files_reps/gtdb_genomes_reps.tar.gz
# download tax table
wget https://data.ace.uq.edu.au/public/gtdb/data/releases/latest/bac120_taxonomy.tsv.gz
# unzip (-x extract; -v see the files; -z gunzip (gz); -f file)
tar -xvzf gtdb_genomes_reps.tar.gz
# move files to one single folder
find "$source_dir" -type f -print0 | xargs -0 -I {} mv -t "$destination_dir" {}

# get the accesion numbers downloaded by ncbi-genome-download to extract Lactobacillus files from GTDB database
# first move the file then run the code
awk 'FNR > 1 { print $1 }' accessions_lac_refseq.txt > accession_lac_refseq.txt

# filter the hq_mimag_genomes.tsv table
# /fs/project/PAS1117/ricardo/operon_tool/code/filtering_gtdb_genomes.R
awk 'FNR > 1 { print $1 }' accession_numb_gtdb_lac.tsv > accession_gtdb_lac.txt




