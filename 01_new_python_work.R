

# new python work ----

# This is where I convert the 5 rounds of arrays of 200 matrices into 5 rounds of 200 CSVs.

# I would think the 00_python_work.R stuff I did previously doesn't make sense. I should just need 
# to extract each matrix, one at a time, 1 thru 200, from an array, and write it to a freaking CSV
# file. Right???

# WRONG! You forgot that you need to filter out the "B" data from these 10,000-row matrices! That's
# all you feed python! Just like last time, this whole python business is going to be really 
# unnecessarily yet inescapably convoluted. 


# Libraries ----
pacman::p_load(
  tidyverse,
  abind
)


# Custom functions ----
source("Chen_scripts/01_method_exploration/00_try_out_stuff/00_custom_functions.R")


# . ----
# Review files ----
# There are going to be 32,000 files when completed.
## 1,600 files in EQ1/R1; 1,600 in EQ1/R2, R3, R4, & R5. That's 8,000 files just for EQ1. 
up_path <- "Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/"

review_files <- function(eq_num,r_num){
  fs::dir_info(str_c(up_path,str_glue("equation_{eq_num}/round_{r_num}"))) %>% 
    select(path) %>% 
    mutate(
      path = basename(path),
      path = str_remove(path,"(?<=\\_)\\d+")
    ) %>% count(path)
}

## EQ1 ----
review_files(1,1) 
review_files(1,2)
review_files(1,3)
review_files(1,4)
review_files(1,5)

## EQ2 ----
review_files(2,1) 
review_files(2,2)
review_files(2,3)
review_files(2,4)
review_files(2,5)

## EQ3 ----
review_files(3,1) 
review_files(3,2)
review_files(3,3)
review_files(3,4)
review_files(3,5)

## EQ4 ----
review_files(4,1) 
review_files(4,2)
review_files(4,3)
review_files(4,4)
review_files(4,5)




# . ----
# My computer sucks so I do datB and datXA separate.
# EQ1: Write 200 CSVs ----
fs::dir_tree("Chen_scripts/01_method_exploration/00_try_out_stuff/")


## Round 1 - WRITTEN ----
dat1_200_r1 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200.rds")
dat1_200_r1[[1]][,,1] %>% as_tibble()

write_datBs_from_array(1:200,dat1_200_r1,1,1)

write_datXAs_from_array(1:200,dat1_200_r1,1,1)

## Round 2 - WRITTEN ----
dat1_200_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200.rds")

write_datBs_from_array(1:200,dat1_200_r2,1,2)

write_datXAs_from_array(1:200,dat1_200_r2,1,2)


## Round 3 - WRITTEN ----
dat1_200_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r3.rds")

write_datBs_from_array(1:200,dat1_200_r3,1,3)

write_datXAs_from_array(1:200,dat1_200_r3,1,3)


## Round 4 ----
dat1_200_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r4.rds")

write_datBs_from_array(1:200,dat1_200_r4,1,4)

write_datXAs_from_array(1:200,dat1_200_r4,1,4)


## Round 5 ----
dat1_200_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r5.rds")

write_datBs_from_array(1:200,dat1_200_r5,1,5)

write_datXAs_from_array(1:200,dat1_200_r5,1,5)



# . ----
# EQ2: Write 200 CSVs ----

## Round 1 - WRITTEN ----
dat2_200_r1 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200.rds")

# This writes the datB csv files to folder "equation_2", subfolder "round_1" (check the last two arguments duh)
write_datBs_from_array(81:200,dat2_200_r1,2,1)

dat2_200_r1[[1]][,,165] %>% as_tibble()

# Even though RStudio weirdly says datB_165.csv has 0 B of size, it's actually a full dataset just like everything else.
read_csv("Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/equation_2/round_1/datB_165.csv")

write_datXAs_from_array(81:200,dat2_200_r1,2,1)


## Round 2 - WRITTEN ----
dat2_200_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r2.rds")

write_datBs_from_array(81:200,dat2_200_r2,2,2)

write_datXAs_from_array(120:200,dat2_200_r2,2,2)


## Round 3 ----


## Round 4 ----


## Round 5 ----



# . ----
# EQ3: Write 200 CSVs ----




