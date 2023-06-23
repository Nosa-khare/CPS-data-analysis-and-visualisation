
rm(list = ls())


# write function to locate csv files

get_csv_files <- function(path) {
  
  
  csv_files <- c()
  
  subdirs <- list.dirs(path, full.names = TRUE, recursive = TRUE)
  
  
  for (subdir in subdirs) {
    
    csv_files <- c(
      csv_files, list.files(subdir, pattern = "*.csv", full.names = TRUE)
    )
    
  }
  
  
  for (i in seq_along(csv_files)) {
    
    file <- csv_files[i]
    
    old_name <- basename(file)
    
    
    if (grepl("principal_offence_category_", old_name, ignore.case = TRUE)) {
      
      new_name <- gsub("principal_offence_category_", "", old_name, ignore.case = TRUE)
      
      new_path <- file.path(dirname(file), new_name)
      
      file.rename(file, new_path)
      
      csv_files[i] <- new_path
      
    }
    
  }
  
  return(csv_files)
}


# Set main directory path
main_dir <- file.path(getwd(), "z.datasets")


# fetch all csv files in the main directory and sub directories with function
csv_files <- get_csv_files(main_dir)





##### COMPATIBLITY TEST #####

# compare all csv files for identical columns


# read first file, get column names and use as reference
ref_df <- read.csv(csv_files[1])
ref_colnames <- colnames(ref_df)


# create an empty vector to store non-compatible csv files
not_compatible <- c()


# loop through the rest of the files comparing each with reference data frame
for (i in 2:length(csv_files)) {
  
  csv <- csv_files[i]
  
  current_df <- read.csv(csv)
  current_colnames <- colnames(current_df)
  
  
  if (identical(ref_colnames, current_colnames)) {
    
    # append the current data frame to the reference data row-wise
    ref_df <- rbind(ref_df, current_df)
  
  } else {
    
    # append file to not compatible vector
    not_compatible <- c(not_compatible, csv)
  }
  
  
  # remove redundant variables if combining is complete
  if (i == length(csv_files) && is.null(not_compatible)) {
    
    print("All csv files are compatible, and have been merged!")
    rm(i, current_df, current_colnames, not_compatible)
  }
  
}


View(ref_df)




