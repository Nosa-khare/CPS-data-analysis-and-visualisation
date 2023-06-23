# clear environment variables
rm(list = ls())

# Get the current working directory
getwd()

# Create a path to subdirectory 'datasets' within the current working directory
csv_dir <- paste0(getwd(), "/datasets")
csv_dir

# Create an empty data frame to store the combined data from all CSV files
combined_data <- data.frame()

# List all files in the subdirectory that have a '.csv' extension
csv_files <- list.files(csv_dir, pattern = "*.csv")

# Initialize a count variable to keep track of the number of processed files
count = 0


# Iterate over each CSV file in the list
for (csv_file in csv_files) {

  # Read CSV file and store the data in a data frame
  df <- read.csv(paste0(csv_dir, "/", csv_file))
  
  # Combine data in the current file with data in 'combined_data' data frame
  combined_data <- rbind(combined_data, df)
  
  # Increment the count variable
  count = count + 1
  
  # Check if this is the last file in the list
  if (count == length(csv_files)) {
    rm(df)
  }
  
}


View(combined_data)








ref_df <- read.csv(csv_files[1])

ref_colname <- colnames(ref_df)

not_compatible <- c()


for (i in 2:length(csv_files)) {
  
  csv <- csv_files[i]
  
  current_df <- read.csv(csv)
  current_colnames <- colnames(current_df)
  
  
  if (identical(ref_colname, current_colnames)) {
    
    ref_df <- rbind(ref_df, current_df)
    
  } else {
    
    not_compatible <- c(not_compatible, csv)
  }
  
  
  if (i == length(csv_files) && is.null(not_compatible)) {
    
    print("All csv files are compatible, and have been merged!")
    rm(i, current_df, current_colnames, not_compatible)
  }
  
}









crime_group <- subset(df_drop, select = 2:26)

df_arranged <- cbind(df_drop[1], df_drop[27:29], crime_group)








