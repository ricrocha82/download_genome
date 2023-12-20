# Load the required libraries
library(pacman)
p_load(fs)

# Function to move files with .fna.gz extension
move_files <- function(source_dir, destination_dir) {
  # Get a list of all files with .fna.gz extension in the source directory and its subdirectories
  file_list <- dir_ls(source_dir, recurse = TRUE, regexp = "*fna.gz$")

  # Move each file to the destination directory
  for (file in file_list) {
    file.copy(file, destination_dir, overwrite = FALSE)
  }
}

# Path to the source directory
source_dir <- "/path/to/source/directory"

# Path to the destination directory (the single folder to move all files)
destination_dir <- "/path/to/destination/directory"

# Call the move_files function
move_files(source_dir, destination_dir)


dir_ls("/fs/scratch/Sullivan_Lab/Ricardo/database/gtdb/gtdb_genomes_reps_r214/database", recurse = TRUE, regexp = "*.fna.gz")
