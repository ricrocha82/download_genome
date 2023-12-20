library(tidyverse)
library(vroom)
library(here)

here()

# get the sample names
dir_path <- here("/fs/scratch/Sullivan_Lab/Ricardo/gtdb_Lactobacillus/2023-07-21_18-32-01/files")
project_name <- list.files(dir_path, pattern = "_genomic.fna.gz") %>% 
                    str_remove("_genomic.fna.gz") %>%
                    tibble(genomes =.) %>%
                    mutate(accession = str_remove(genomes, "_[^_]+$"))


accesion_tax <- vroom(here("/fs/scratch/Sullivan_Lab/Ricardo/gtdb_Lactobacillus/2023-07-21_18-32-01/assembly_summary.txt"),  col_names = F) %>% 
                select(X1, X8) %>%
                rename(accession = X1, taxonomy = X8)

df_to_save <- project_name %>% left_join(accesion_tax)


write.table(df_to_save, file = here("/fs/scratch/Sullivan_Lab/Ricardo/gtdb_Lactobacillus/2023-07-21_18-32-01/df_names.txt"), col.names = F, row.names = F,  quote = FALSE)


