#-------------Individual windows extraction by file----------------
# Sqr, session 1
sqr_ses1_means_alt <- function(sqr1_file) {
  sqr1_data <- read.delim(sqr1_file, sep = " ", dec = ",",
                          header = TRUE)
  # Remove last two columns
  sqr1_data$Right <- NULL
  sqr1_data$Occ.par.1 <- NULL
  # Rename last column
  names(sqr1_data)[names(sqr1_data) == "Occ.par"] <- "Right"
  # Compute means for each region and append to main data frame
  nd1_window <- sqr1_data[80:90,1]
  nd2_window_left <- sqr1_data[125:150,2]
  nd2_window_right <- sqr1_data[125:150,3]
  mean_occ <- mean(nd1_window)
  mean_left <- mean(nd2_window_left)
  mean_right <- mean(nd2_window_right)
  means_sqr1 <- c(mean_occ, mean_left, mean_right)
}

# Sqr, session 2
sqr_ses2_means_alt <- function(sqr2_file) {
  sqr2_data <- read.delim(sqr2_file, sep = " ", dec = ",",
                          header = TRUE)
  # Remove last two columns
  sqr2_data$Right <- NULL
  sqr2_data$Occ.par.1 <- NULL
  # Rename last column
  names(sqr2_data)[names(sqr2_data) == "Occ.par"] <- "Right"
  # Compute means for each region and append to main data frame
  nd1_window <- sqr2_data[80:90,1]
  nd2_window_left <- sqr2_data[125:150,2]
  nd2_window_right <- sqr2_data[125:150,3]
  mean_occ <- mean(nd1_window)
  mean_left <- mean(nd2_window_left)
  mean_right <- mean(nd2_window_right)
  means_sqr2 <- c(mean_occ, mean_left, mean_right)
}

# Random, session 1
rand_ses1_means_alt <- function(rand1_file) {
  rand1_data <- read.delim(rand1_file, sep = " ", dec = ",",
                           header = TRUE)
  # Remove last two columns
  rand1_data$Right <- NULL
  rand1_data$Occ.par.1 <- NULL
  # Rename last column
  names(rand1_data)[names(rand1_data) == "Occ.par"] <- "Right"
  nd1_window <- rand1_data[80:90,1]
  nd2_window_left <- rand1_data[125:150,2]
  nd2_window_right <- rand1_data[125:150,3]
  mean_occ <- mean(nd1_window)
  mean_left <- mean(nd2_window_left)
  mean_right <- mean(nd2_window_right)
  means_rand1 <- c(mean_occ, mean_left, mean_right)
}

# Random, session 2
rand_ses2_means_alt <- function(rand2_file) {
  rand2_data <- read.delim(rand2_file, sep = " ", dec = ",",
                           header = TRUE)
  # Remove last two columns
  rand2_data$Right <- NULL
  rand2_data$Occ.par.1 <- NULL
  # Rename last column
  names(rand2_data)[names(rand2_data) == "Occ.par"] <- "Right"
  nd1_window <- rand2_data[80:90,1]
  nd2_window_left <- rand2_data[125:150,2]
  nd2_window_right <- rand2_data[125:150,3]
  mean_occ <- mean(nd1_window)
  mean_left <- mean(nd2_window_left)
  mean_right <- mean(nd2_window_right)
  means_rand2 <- c(mean_occ, mean_left, mean_right)
}

# Compute means for each file
sqr1_means <- lapply(sqr1_fnames, sqr_ses1_means_alt)
sqr2_means <- lapply(sqr2_fnames, sqr_ses2_means_alt)
rand1_means <- lapply(rand1_fnames, rand_ses1_means_alt)
rand2_means <- lapply(rand2_fnames, rand_ses2_means_alt)

# Coerce lists to data frames
sqr1_dat <- data.frame(matrix(unlist(sqr1_means), nrow = 34, byrow = T))
sqr2_dat <- data.frame(matrix(unlist(sqr2_means), nrow = 34, byrow = T))
rand1_dat <- data.frame(matrix(unlist(rand1_means), nrow = 34, byrow = T))
rand2_dat <- data.frame(matrix(unlist(rand2_means), nrow = 34, byrow = T))

# Rename columms
colnames(sqr1_dat) <- c("occ_sqr_1", "left_sqr_1", "right_sqr_1")
colnames(sqr2_dat) <- c("occ_sqr_2", "left_sqr_2", "right_sqr_2")
colnames(rand1_dat) <- c("occ_rand_1", "left_rand_1", "right_rand_1")
colnames(rand2_dat) <- c("occ_rand_2", "left_rand_2", "right_rand_2")

# Merge data frames
rep_data3 <- cbind(sqr1_dat, sqr2_dat, rand1_dat, rand2_dat)

# Add group variable
rep_data3$group <- c("unaware", "aware", "unaware", "unaware", "unaware", 
                     "aware", "unaware", "aware", "aware", "aware", "aware", 
                     "unaware", "aware", "unaware", "unaware", "aware", "aware", 
                     "aware", "aware", "unaware", "aware", "unaware", "unaware", 
                     "unaware", "aware", "unaware", "unaware", "unaware", "unaware", 
                     "unaware", "aware", "aware", "unaware", "unaware")

# Add subject number
Subject <- c(1,2,3,4,6:11, 13:30, 32:37)
rep_data3 <- cbind(Subject, rep_data3)

# Remove subjects with too many artifacts
rep_data4 <- rep_data3[-c(21,25),]

# Convert from wide to long
# Rename columns to separate session number using sep = "_"
names(rep_data4)[names(rep_data4) == "occ_sqr_1"] <- "occ.sqr_1"
names(rep_data4)[names(rep_data4) == "occ_sqr_2"] <- "occ.sqr_2"
names(rep_data4)[names(rep_data4) == "occ_rand_1"] <- "occ.rand_1"
names(rep_data4)[names(rep_data4) == "occ_rand_2"] <- "occ.rand_2"
names(rep_data4)[names(rep_data4) == "left_sqr_1"] <- "left.sqr_1"
names(rep_data4)[names(rep_data4) == "left_sqr_2"] <- "left.sqr_2"
names(rep_data4)[names(rep_data4) == "left_rand_1"] <- "left.rand_1"
names(rep_data4)[names(rep_data4) == "left_rand_2"] <- "left.rand_2"
names(rep_data4)[names(rep_data4) == "right_sqr_1"] <- "right.sqr_1"
names(rep_data4)[names(rep_data4) == "right_sqr_2"] <- "right.sqr_2"
names(rep_data4)[names(rep_data4) == "right_rand_1"] <- "right.rand_1"
names(rep_data4)[names(rep_data4) == "right_rand_2"] <- "right.rand_2"
# Extracts session number to column
rep_data_long_alt <- reshape(rep_data4, varying = c("occ.sqr_1", "occ.sqr_2",
                                                    "occ.rand_1", "occ.rand_2",
                                                    "left.sqr_1", "left.sqr_2",
                                                    "left.rand_1", "left.rand_2",
                                                    "right.sqr_1", "right.sqr_2",
                                                    "right.rand_1", "right.rand_2"),  
                             direction = "long", idvar = "Subject", sep = "_")
# Rename session column
names(rep_data_long_alt)[names(rep_data_long_alt) == "time"] <- "session"

# Rename columns to separate configuration number using sep = "_"
names(rep_data_long_alt)[names(rep_data_long_alt) == "occ.sqr"] <- "occ_1"
names(rep_data_long_alt)[names(rep_data_long_alt) == "occ.rand"] <- "occ_2"
names(rep_data_long_alt)[names(rep_data_long_alt) == "left.sqr"] <- "left_1"
names(rep_data_long_alt)[names(rep_data_long_alt) == "left.rand"] <- "left_2"
names(rep_data_long_alt)[names(rep_data_long_alt) == "right.sqr"] <- "right_1"
names(rep_data_long_alt)[names(rep_data_long_alt) == "right.rand"] <- "right_2"
# Extracts configuration number to column
rep_data_long_alt2 <- reshape(rep_data_long_alt, varying = c("occ_1", "occ_2",
                                                             "left_1", "left_2",
                                                             "right_1", "right_2"),  
                              direction = "long", idvar = " Subject", sep = "_")
# Rename configuration column name
names(rep_data_long_alt2)[names(rep_data_long_alt2) == "time"] <- "configuration"
# Rename configuration levels
rep_data_long_alt2$configuration[rep_data_long_alt2$configuration == 1] <- "sqr"
rep_data_long_alt2$configuration[rep_data_long_alt2$configuration == 2] <- "rand"
rep_data_long_alt2[,8]<- NULL
