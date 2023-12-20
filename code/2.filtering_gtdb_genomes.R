# load packages
library(pacman)
p_load(tidyverse, here, vroom, janitor)
p_loaded()

here()
path_file <- c(here("ricardo/operon_tool/"))
vroom()

# load the table tsv
df_names <- vroom(paste0(path_file, "hq_mimag_genomes.tsv")) %>% clean_names()
colnames(df_names)
# filter table
# completeness_percent > 98 and gtdb_taxonomy == Lactobacillus and contamination_percent < 0.01
df_lac_98 <- df_names %>%  
                filter(completeness_percent > 98 & 
                        str_detect(gtdb_taxonomy, 'Lactobacillus') & 
                        contamination_percent < 0.01)  %>%
                mutate(representative_genome = str_remove(representative_genome, "^[^_]*_"))
                        

accession_numb_gtdb <- df_lac_98 %>% select(representative_genome)

vroom_write(accession_numb_gtdb, paste0(here(path_file, "/accession_numb_gtdb_lac.txt")), col_names = FALSE)

# accession_numb_gtdb <- vroom(paste0(here(path_file, "/accession_numb_gtdb_lac.txt")), delim = " ")

