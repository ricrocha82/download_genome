conda activate genome_updater

# https://github.com/pirovc/genome_updater

##--- Complete Bacterial Genomes ---##
# 01. RefSeq
# Download Bacterial complete genome sequences from the refseq repository (-t number parallel downloads):
# (-m to check integrity of downloaded files, -u extended assembly accession report)
./genome_updater.sh -d "refseq" -g "bacteria" -l "complete genome" -f "genomic.fna.gz,assembly_report.txt" -o "bac_refseq_cg" -t 12 -rpu

# 02. GTDB
# All genome sequences used in the latests GTDB release
./genome_updater.sh -d "refseq" -g "bacteria" -l "complete genome" -f "genomic.fna.gz,assembly_report.txt" -o "bac_gtdb_cg" -M "gtdb" -t 12 -rpu


##--- Lactobacillus ---###
#01. RefSeq
# Download all Lactobacillus complete genomes (NCBI Taxonomy ID 1578)
./genome_updater.sh -d "refseq" -g "bacteria" -M ncbi -T "1578" -l "complete genome" -f "genomic.fna.gz" -o "refseq_Lactobacillus" -t 12 -rpu
# All assemblies from Lactobacillus in GTDB
./genome_updater.sh -d "refseq" -g "bacteria" -M "gtdb" -T "g__Lactobacillus" -l "complete genome" -f "genomic.fna.gz" -o "gtdb_Lactobacillus"  -t 12 -rpu


##--- UPDATE ---##
# Some days later, update the repository:
./genome_updater.sh -o "arc_refseq_cg"