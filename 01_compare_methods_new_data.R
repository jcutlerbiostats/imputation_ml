

# 01_compare_methods_new_data ----

# Comparing methods, just like before (in 01_comparing_methods.R), except this time
# we have new ways (4 ways) of generating data. See 00_new_functions_4_covariates.R
# and 00_new_f_ML.R for the changes (both in 00_try_out_stuff folder).


# Libraries ----
pacman::p_load(
  tidyverse,
  tidyquant,
  # tidymodels,
  plotly,
  gt
)


# Source scripts ----
source("Chen_scripts/01_method_exploration/00_try_out_stuff/00_custom_functions.R")
source("Chen_scripts/01_method_exploration/00_try_out_stuff/00_new_functions_4_covariates.R")
source("Chen_scripts/01_method_exploration/00_try_out_stuff/00_new_f_ML.R")


# 0.0 - Generate/load sim. data ----
## Round 1 - 200s ----
# dat1_200 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 1) # linear
# dat2_200 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 2) # quadratic
# dat3_200 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 3) # interactions
# dat4_200 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -20,id_m = 4) # multi-layer

# I thought 200 was going to be too much for the supercomputer. Turns out it's not.
# dat4_100 <- gedata_modified(B = 100,N = 10000,nA = 500,C = -20,id_m = 4) # 192 MB
# dat4_100 %>% pluck(1) %>% .[,,1] %>% as_tibble() # 10,000 rows, 24 columns
# dat4_100 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_100.rds")
# dat4_100 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_100.rds")

# dat1_200 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200.rds")
# dat2_200 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200.rds")
# dat3_200 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200.rds")
# dat4_200 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200.rds")
dat1_200 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200.rds")
dat2_200 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200.rds")
dat3_200 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200.rds")
dat4_200 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200.rds") # 384 MB

# Looks good so far 
# dat1_200 %>% pluck(1) %>% .[,,1] %>% as_tibble()
# dat2_200 %>% pluck(1) %>% .[,,1] %>% as_tibble()
# dat3_200 %>% pluck(1) %>% .[,,1] %>% as_tibble()
# dat4_200 %>% pluck(1) %>% .[,,1] %>% as_tibble() %>% glimpse()


## Round 2 - 200s ----
# dat1_200_r2 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 1) # linear
# dat2_200_r2 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 2) # quadratic
# dat3_200_r2 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 3) # interactions
# dat4_200_r2 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -20,id_m = 4) # multi-layer - takes just a hair longer to run
# dat1_200_r2 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r2.rds")
# dat2_200_r2 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r2.rds")
# dat3_200_r2 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200_r2.rds")
# dat4_200_r2 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200_r2.rds")
dat1_200_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r2.rds")
dat2_200_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r2.rds")
dat3_200_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200_r2.rds")
dat4_200_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200_r2.rds")

# Troubleshoot OSCER with 2 datasets
# dat1_2_r2 <- gedata_modified(B = 2,N = 10000,nA = 500,C = -4.4,id_m = 1)
# dat1_2_r2 %>% pluck(1) %>% .[,,1] %>% as_tibble()
# dat1_2_r2 %>% pluck(1) %>% .[,,2] %>% as_tibble()
# dat1_2_r2 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_2_r2.rds")
# dat1_2_r2[,,]


## Round 3 - 200s ----
# dat1_200_r3 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 1) # linear
# dat2_200_r3 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 2) # quadratic
# dat3_200_r3 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 3) # interactions
# dat4_200_r3 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -20,id_m = 4) # multi-layer - takes just a hair longer to run
# dat1_200_r3 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r3.rds")
# dat2_200_r3 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r3.rds")
# dat3_200_r3 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200_r3.rds")
# dat4_200_r3 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200_r3.rds")
dat1_200_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r3.rds")
dat2_200_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r3.rds")
dat3_200_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200_r3.rds")
dat4_200_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200_r3.rds")


## Round 4 - 200s ----
# dat1_200_r4 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 1) # linear
# dat2_200_r4 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 2) # quadratic
# dat3_200_r4 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 3) # interactions
# dat4_200_r4 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -20,id_m = 4) # multi-layer - takes just a hair longer to run
# dat1_200_r4 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r4.rds")
# dat2_200_r4 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r4.rds")
# dat3_200_r4 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200_r4.rds")
# dat4_200_r4 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200_r4.rds")
dat1_200_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r4.rds")
dat2_200_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r4.rds")
dat3_200_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200_r4.rds")
dat4_200_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200_r4.rds")


## Round 5 - 200s ----
# dat1_200_r5 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 1) # linear
# dat2_200_r5 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 2) # quadratic
# dat3_200_r5 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -4.4,id_m = 3) # interactions
# dat4_200_r5 <- gedata_modified(B = 200,N = 10000,nA = 500,C = -20,id_m = 4) # multi-layer - takes just a hair longer to run
# dat1_200_r5 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r5.rds")
# dat2_200_r5 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r5.rds")
# dat3_200_r5 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200_r5.rds")
# dat4_200_r5 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200_r5.rds")
dat1_200_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r5.rds")
dat2_200_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r5.rds")
dat3_200_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat3_200_r5.rds")
dat4_200_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat4_200_r5.rds")


### Confirm they're unique ----
dat1_200 %>% pluck(1) %>% .[,,1] %>% as_tibble()
dat1_200_r2 %>% pluck(1) %>% .[,,1] %>% as_tibble()
dat1_200_r3 %>% pluck(1) %>% .[,,1] %>% as_tibble()
dat1_200_r4 %>% pluck(1) %>% .[,,1] %>% as_tibble()
dat1_200_r5 %>% pluck(1) %>% .[,,1] %>% as_tibble()



# FRES for GAM - id_m=all, 200s ----
## res1 ----
Sys.time()
res1_gam <- FRES(
  indat = list(dat1_200[[1]][,,], 
               dat1_200[[2]],
               dat1_200[[3]]),
  modeling_method = "GAM",
  id_m            = 1
); Sys.time()
res1_gam %>% my_get_metrics("GAM") %>% plot_metrics()

## res2 ----
Sys.time()
res2_gam <- FRES(
  indat = list(dat2_200[[1]][,,], 
               dat2_200[[2]],
               dat2_200[[3]]),
  modeling_method = "GAM",
  id_m            = 2
); Sys.time()

## res3 ----
Sys.time()
res3_gam <- FRES(
  indat = list(dat3_200[[1]][,,], 
               dat3_200[[2]],
               dat3_200[[3]]),
  modeling_method = "GAM",
  id_m            = 3
); Sys.time()

## res4 ----
Sys.time()
res4_gam <- FRES(
  indat = list(dat4_200[[1]][,,], 
               dat4_200[[2]],
               dat4_200[[3]]),
  modeling_method = "GAM",
  id_m            = 4
); Sys.time()

### res4_10 ----
res4_10_gam <- FRES(
  indat = list(dat4_10[[1]][,,], 
               dat4_10[[2]],
               dat4_10[[3]]),
  modeling_method = "GAM",
  id_m            = 4
)

## Aggregate ----
# res1_gam %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res1_gam.rds")
# res2_gam %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res2_gam.rds")
# res3_gam %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res3_gam.rds")
# res4_gam %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res4_gam.rds")
res1_gam <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res1_gam.rds")
res2_gam <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res2_gam.rds")
res3_gam <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res3_gam.rds")
res4_gam <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res4_gam.rds")

# See which equations GAM is worst/best at estimating
res1_gam %>% my_get_metrics("GAM",1) %>% 
  bind_rows(
    res2_gam %>% my_get_metrics("GAM",2),
    res3_gam %>% my_get_metrics("GAM",3),
    res4_gam %>% my_get_metrics("GAM",4)
  ) -> res_all_gam

res_all_gam %>% plot_metrics(ml_fill = F)
res_all_gam %>% plot_metrics(ml_fill = F,mean_or_med = "median")



# . ----
# id_m=3, 200s - FRES ----
## GAM is worst ----
res3_rpart <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res3_200_rpart.rds")
res3_randforest <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res3_200_randforest.rds")
res3_svm <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res3_200_svm.rds")
res3_xgboost <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res3_200_xgboost.rds")

res3_gam %>% my_get_metrics("GAM",3) %>% 
  bind_rows(
    res3_rpart %>% my_get_metrics("simple_tree",3),
    res3_randforest %>% my_get_metrics("random_forest",3),
    res3_svm %>% my_get_metrics("SVM",3),
    res3_xgboost %>% my_get_metrics("xgboost",3)
  ) -> all_res3

all_res3

all_res3 %>% plot_metrics(mean_or_med = "mean")
all_res3 %>% plot_metrics(mean_or_med = "median")



# id_m=2, 200s - FRES ----
## GAM is best ----
res2_rpart <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res2_200_rpart.rds")
res2_randforest <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res2_200_randforest.rds")
res2_svm <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res2_200_svm.rds")
res2_xgboost <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res2_200_xgboost.rds")

res2_gam %>% my_get_metrics("GAM",2) %>% 
  bind_rows(
    res2_rpart %>% my_get_metrics("simple_tree",2),
    res2_randforest %>% my_get_metrics("random_forest",2),
    res2_svm %>% my_get_metrics("SVM",2),
    res2_xgboost %>% my_get_metrics("xgboost",2)
  ) -> all_res2

all_res2

all_res2 %>% plot_metrics(mean_or_med = "mean")
all_res2 %>% plot_metrics(mean_or_med = "median")



# id_m=1, 200s - FRES ----
res1_rpart <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res1_200_rpart.rds")
res1_randforest <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res1_200_randforest.rds")
res1_svm <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res1_200_svm.rds")
res1_xgboost <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res1_200_xgboost.rds")

res1_gam %>% my_get_metrics("GAM",1) %>% 
  bind_rows(
    res1_rpart %>% my_get_metrics("simple_tree",1),
    res1_randforest %>% my_get_metrics("random_forest",1),
    res1_svm %>% my_get_metrics("SVM",1),
    res1_xgboost %>% my_get_metrics("xgboost",1)
  ) -> all_res1

all_res1

all_res1 %>% plot_metrics(mean_or_med = "mean")
all_res1 %>% plot_metrics(mean_or_med = "median")



# id_m=4, 10s - FRES ----
res4_10_rpart <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res4_10_rpart.rds")
res4_10_randforest <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res4_10_randforest.rds")
res4_10_svm <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res4_10_svm.rds")
res4_10_xgboost <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/00_results/res4_10_xgboost.rds")

res4_10_gam %>% my_get_metrics("GAM",4) %>% 
  bind_rows(
    res4_10_rpart %>% my_get_metrics("simple_tree",4),
    res4_10_randforest %>% my_get_metrics("random_forest",4),
    res4_10_svm %>% my_get_metrics("SVM",4),
    res4_10_xgboost %>% my_get_metrics("xgboost",4)
  ) -> all_res4_10

all_res4_10

all_res4_10 %>% plot_metrics(mean_or_med = "mean")
all_res4_10 %>% plot_metrics(mean_or_med = "median")



# . ----
# . ----
# idm=1 all 5 rounds ----
## Round 1 FRES results ----
### GAM results ----
# dat1_200 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200.rds")
# dat1_200[[1]][,,1] %>% as_tibble()
# res1_200_gam <- FRES(
#   indat = list(dat1_200[[1]][,,], 
#                dat1_200[[2]],
#                dat1_200[[3]]),
#   modeling_method = "GAM",
#   id_m            = 1
# )
# res1_200_gam %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r1.rds")
res1_200_gam <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r1.rds")

### The other results ----
res1_200_randforest <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_randforest_r1.rds")
res1_200_rpart <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_rpart_r1.rds")
res1_200_svm <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_svm_r1.rds")
res1_200_xgboost <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_xgboost_r1.rds")

### Plot ----
res1_200_gam %>% my_get_metrics(method = "GAM",id_m = 1) %>% 
  bind_rows(
    res1_200_randforest %>% my_get_metrics(method = "Random Forest",id_m = 1),
    res1_200_rpart %>% my_get_metrics(method = "Simple Tree",id_m = 1),
    res1_200_svm %>% my_get_metrics(method = "SVM",id_m = 1),
    res1_200_xgboost %>% my_get_metrics(method = "XGBoost",id_m = 1)
  ) -> res1_r1_tbl

res1_r1_tbl %>% plot_metrics()
res1_r1_tbl %>% plot_metrics(mean_or_med = "median")

## Round 2 FRES results ----
### GAM results ----
# dat1_200_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r2.rds")
# dat1_200_r2[[1]][,,1] %>% as_tibble()
# res1_200_gam_r2 <- FRES(
#   indat = list(dat1_200_r2[[1]][,,],
#                dat1_200_r2[[2]],
#                dat1_200_r2[[3]]),
#   modeling_method = "GAM",
#   id_m            = 1
# )
# res1_200_gam_r2 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r2.rds")
res1_200_gam_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r2.rds")

### The other results ----
res1_200_randforest_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_randforest_r2.rds")
res1_200_rpart_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_rpart_r2.rds")
res1_200_svm_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_svm_r2.rds")
res1_200_xgboost_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_xgboost_r2.rds")

### Plot ----
res1_200_gam_r2 %>% my_get_metrics(method = "GAM",id_m = 1) %>% 
  bind_rows(
    res1_200_randforest_r2 %>% my_get_metrics(method = "Random Forest",id_m = 1),
    res1_200_rpart_r2 %>% my_get_metrics(method = "Simple Tree",id_m = 1),
    res1_200_svm_r2 %>% my_get_metrics(method = "SVM",id_m = 1),
    res1_200_xgboost_r2 %>% my_get_metrics(method = "XGBoost",id_m = 1)
  ) -> res1_r2_tbl

res1_r2_tbl %>% plot_metrics()
res1_r2_tbl %>% plot_metrics(mean_or_med = "median")


## Round 3 FRES results ----
### GAM results ----
# dat1_200_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r3.rds")
# dat1_200_r3[[1]][,,1] %>% as_tibble()
# res1_200_gam_r3 <- FRES(
#   indat = list(dat1_200_r3[[1]][,,],
#                dat1_200_r3[[2]],
#                dat1_200_r3[[3]]),
#   modeling_method = "GAM",
#   id_m            = 1
# )
# res1_200_gam_r3 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r3.rds")
res1_200_gam_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r3.rds")

### The other results ----
res1_200_randforest_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_randforest_r3.rds")
res1_200_rpart_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_rpart_r3.rds")
res1_200_svm_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_svm_r3.rds")
res1_200_xgboost_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_xgboost_r3.rds")

### Plot ----
res1_200_gam_r3 %>% my_get_metrics(method = "GAM",id_m = 1) %>% 
  bind_rows(
    res1_200_randforest_r3 %>% my_get_metrics(method = "Random Forest",id_m = 1),
    res1_200_rpart_r3 %>% my_get_metrics(method = "Simple Tree",id_m = 1),
    res1_200_svm_r3 %>% my_get_metrics(method = "SVM",id_m = 1),
    res1_200_xgboost_r3 %>% my_get_metrics(method = "XGBoost",id_m = 1)
  ) -> res1_r3_tbl

res1_r3_tbl %>% plot_metrics()
res1_r3_tbl %>% plot_metrics(mean_or_med = "median")


## Round 4 FRES results ----
### GAM results ----
# dat1_200_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r4.rds")
# dat1_200_r4[[1]][,,1] %>% as_tibble()
# res1_200_gam_r4 <- FRES(
#   indat = list(dat1_200_r4[[1]][,,],
#                dat1_200_r4[[2]],
#                dat1_200_r4[[3]]),
#   modeling_method = "GAM",
#   id_m            = 1
# )
# res1_200_gam_r4 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r4.rds")
res1_200_gam_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r4.rds")

### The other results ----
res1_200_randforest_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_randforest_r4.rds")
res1_200_rpart_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_rpart_r4.rds")
res1_200_svm_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_svm_r4.rds")
res1_200_xgboost_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_xgboost_r4.rds")

### Plot ----
res1_200_gam_r4 %>% my_get_metrics(method = "GAM",id_m = 1) %>% 
  bind_rows(
    res1_200_randforest_r4 %>% my_get_metrics(method = "Random Forest",id_m = 1),
    res1_200_rpart_r4 %>% my_get_metrics(method = "Simple Tree",id_m = 1),
    res1_200_svm_r4 %>% my_get_metrics(method = "SVM",id_m = 1),
    res1_200_xgboost_r4 %>% my_get_metrics(method = "XGBoost",id_m = 1)
  ) -> res1_r4_tbl

res1_r4_tbl %>% plot_metrics()
res1_r4_tbl %>% plot_metrics(mean_or_med = "median")


## Round 5 FRES results ----
### GAM results ----
# dat1_200_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat1_200_r5.rds")
# dat1_200_r5[[1]][,,1] %>% as_tibble()
# res1_200_gam_r5 <- FRES(
#   indat = list(dat1_200_r5[[1]][,,],
#                dat1_200_r5[[2]],
#                dat1_200_r5[[3]]),
#   modeling_method = "GAM",
#   id_m            = 1
# )
# res1_200_gam_r5 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r5.rds")
res1_200_gam_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_gam_r5.rds")

### The other results ----
res1_200_randforest_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_randforest_r5.rds")
res1_200_rpart_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_rpart_r5.rds")
res1_200_svm_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_svm_r5.rds")
res1_200_xgboost_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_1_results/res1_200_xgboost_r5.rds")

### Plot ----
res1_200_gam_r5 %>% my_get_metrics(method = "GAM",id_m = 1) %>% 
  bind_rows(
    res1_200_randforest_r5 %>% my_get_metrics(method = "Random Forest",id_m = 1),
    res1_200_rpart_r5 %>% my_get_metrics(method = "Simple Tree",id_m = 1),
    res1_200_svm_r5 %>% my_get_metrics(method = "SVM",id_m = 1),
    res1_200_xgboost_r5 %>% my_get_metrics(method = "XGBoost",id_m = 1)
  ) -> res1_r5_tbl

res1_r5_tbl %>% plot_metrics()
res1_r5_tbl %>% plot_metrics(mean_or_med = "median")


## SAVE all 5 idm=1 rounds ----
res1_r1_tbl %>% mutate(round = 1) %>% 
  bind_rows(
    res1_r2_tbl %>% mutate(round = 2),
    res1_r3_tbl %>% mutate(round = 3),
    res1_r4_tbl %>% mutate(round = 4),
    res1_r5_tbl %>% mutate(round = 5)
  ) -> idm1_res_tbl
# idm1_res_tbl %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/idm1_res_all_rounds.rds")


# . ----
# idm=2 all 5 rounds ----
## Round 1 FRES results ----
### GAM results ----
# dat2_200 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200.rds")
# dat2_200[[1]][,,1] %>% as_tibble()
# res2_gam <- FRES(
#   indat = list(dat2_200[[1]][,,], 
#                dat2_200[[2]],
#                dat2_200[[3]]),
#   modeling_method = "GAM",
#   id_m            = 2
# )
# res2_gam %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r1.rds")
res2_gam <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r1.rds")

### The other results ----
res2_randforest <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_randforest_r1.rds")
res2_rpart <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_rpart_r1.rds")
res2_svm <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_svm_r1.rds")
res2_xgboost <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_xgboost_r1.rds")

### Plot ----
res2_gam %>% my_get_metrics(method = "GAM",id_m = 2) %>% 
  bind_rows(
    res2_randforest %>% my_get_metrics(method = "Random Forest",id_m = 2),
    res2_rpart %>% my_get_metrics(method = "Simple Tree",id_m = 2),
    res2_svm %>% my_get_metrics(method = "SVM",id_m = 2),
    res2_xgboost %>% my_get_metrics(method = "XGBoost",id_m = 2)
  ) %>% plot_metrics()


## Round 2 FRES results ----
### GAM results ----
# dat2_200_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r2.rds")
# dat2_200_r2[[1]][,,1] %>% as_tibble()
# res2_gam_r2 <- FRES(
#   indat = list(dat2_200_r2[[1]][,,],
#                dat2_200_r2[[2]],
#                dat2_200_r2[[3]]),
#   modeling_method = "GAM",
#   id_m            = 2
# )
# res2_gam_r2 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r2.rds")
res2_gam_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r2.rds")

### The other results ----
res2_randforest_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_randforest_r2.rds")
res2_rpart_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_rpart_r2.rds")
res2_svm_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_svm_r2.rds")
res2_xgboost_r2 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_xgboost_r2.rds")

### Plot ----
res2_gam_r2 %>% my_get_metrics(method = "GAM",id_m = 2) %>% 
  bind_rows(
    res2_randforest_r2 %>% my_get_metrics(method = "Random Forest",id_m = 2),
    res2_rpart_r2 %>% my_get_metrics(method = "Simple Tree",id_m = 2),
    res2_svm_r2 %>% my_get_metrics(method = "SVM",id_m = 2),
    res2_xgboost_r2 %>% my_get_metrics(method = "XGBoost",id_m = 2)
  ) %>% plot_metrics()



## Round 3 FRES results ----
### GAM results ----
# dat2_200_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r3.rds")
# dat2_200_r3[[1]][,,1] %>% as_tibble()
# res2_gam_r3 <- FRES(
#   indat = list(dat2_200_r3[[1]][,,],
#                dat2_200_r3[[2]],
#                dat2_200_r3[[3]]),
#   modeling_method = "GAM",
#   id_m            = 2
# )
# res2_gam_r3 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r3.rds")
res2_gam_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r3.rds")

### The other results ----
res2_randforest_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_randforest_r3.rds")
res2_rpart_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_rpart_r3.rds")
res2_svm_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_svm_r3.rds")
res2_xgboost_r3 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_xgboost_r3.rds")

### Plot ----
res2_gam_r3 %>% my_get_metrics(method = "GAM",id_m = 2) %>% 
  bind_rows(
    res2_randforest_r3 %>% my_get_metrics(method = "Random Forest",id_m = 2),
    res2_rpart_r3 %>% my_get_metrics(method = "Simple Tree",id_m = 2),
    res2_svm_r3 %>% my_get_metrics(method = "SVM",id_m = 2),
    res2_xgboost_r3 %>% my_get_metrics(method = "XGBoost",id_m = 2)
  ) %>% plot_metrics()



## Round 4 FRES results ----
### GAM results ----
# dat2_200_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r4.rds")
# dat2_200_r4[[1]][,,1] %>% as_tibble()
# res2_gam_r4 <- FRES(
#   indat = list(dat2_200_r4[[1]][,,],
#                dat2_200_r4[[2]],
#                dat2_200_r4[[3]]),
#   modeling_method = "GAM",
#   id_m            = 2
# )
# res2_gam_r4 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r4.rds")
res2_gam_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r4.rds")

### The other results ----
res2_randforest_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_randforest_r4.rds")
res2_rpart_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_rpart_r4.rds")
res2_svm_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_svm_r4.rds")
res2_xgboost_r4 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_xgboost_r4.rds")

### Plot ----
res2_gam_r4 %>% my_get_metrics(method = "GAM",id_m = 2) %>% 
  bind_rows(
    res2_randforest_r4 %>% my_get_metrics(method = "Random Forest",id_m = 2),
    res2_rpart_r4 %>% my_get_metrics(method = "Simple Tree",id_m = 2),
    res2_svm_r4 %>% my_get_metrics(method = "SVM",id_m = 2),
    res2_xgboost_r4 %>% my_get_metrics(method = "XGBoost",id_m = 2)
  ) %>% plot_metrics()



## Round 5 FRES results ----
### GAM results ----
# dat2_200_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/dat2_200_r5.rds")
# dat2_200_r5[[1]][,,1] %>% as_tibble()
# res2_gam_r5 <- FRES(
#   indat = list(dat2_200_r5[[1]][,,],
#                dat2_200_r5[[2]],
#                dat2_200_r5[[3]]),
#   modeling_method = "GAM",
#   id_m            = 2
# )
# res2_gam_r5 %>% write_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r5.rds")
res2_gam_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_gam_r5.rds")

### The other results ----
res2_randforest_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_randforest_r5.rds")
res2_rpart_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_rpart_r5.rds")
res2_svm_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_svm_r5.rds")
res2_xgboost_r5 <- read_rds("Chen_scripts/01_method_exploration/00_try_out_stuff/00_data/equation_2_results/res2_200_xgboost_r5.rds")

### Plot ----
res2_gam_r5 %>% my_get_metrics(method = "GAM",id_m = 2) %>% 
  bind_rows(
    res2_randforest_r5 %>% my_get_metrics(method = "Random Forest",id_m = 2),
    res2_rpart_r5 %>% my_get_metrics(method = "Simple Tree",id_m = 2),
    res2_svm_r5 %>% my_get_metrics(method = "SVM",id_m = 2),
    res2_xgboost_r5 %>% my_get_metrics(method = "XGBoost",id_m = 2)
  ) %>% plot_metrics()



# . ----
# SETWD ----
setwd("Chen_scripts/01_method_exploration/00_try_out_stuff/")
# idm=3 all 5 rounds ----

## All GAMs ----
# dat3_200_r1 <- read_rds("00_data/dat3_200.rds")
# dat3_200_r1[[1]][,,1] %>% as_tibble()
# res3_gam_r1 <- FRES(
#   indat = list(dat3_200_r1[[1]][,,],
#                dat3_200_r1[[2]],
#                dat3_200_r1[[3]]),
#   modeling_method = "GAM",
#   id_m            = 3
# )
# res3_gam_r1 %>% write_rds("00_data/equation_1_results/res3_200_gam_r1.rds")


# dat3_200_r2 <- read_rds("00_data/dat3_200_r2.rds")
# dat3_200_r2[[1]][,,1] %>% as_tibble()
# res3_gam_r2 <- FRES(
#   indat = list(dat3_200_r2[[1]][,,],
#                dat3_200_r2[[2]],
#                dat3_200_r2[[3]]),
#   modeling_method = "GAM",
#   id_m            = 3
# )
# res3_gam_r2 %>% write_rds("00_data/equation_1_results/res3_200_gam_r2.rds")


# dat3_200_r3 <- read_rds("00_data/dat3_200_r3.rds")
# dat3_200_r3[[1]][,,1] %>% as_tibble()
# res3_gam_r3 <- FRES(
#   indat = list(dat3_200_r3[[1]][,,],
#                dat3_200_r3[[2]],
#                dat3_200_r3[[3]]),
#   modeling_method = "GAM",
#   id_m            = 3
# )
# res3_gam_r3 %>% write_rds("00_data/equation_1_results/res3_200_gam_r3.rds")


# dat3_200_r4 <- read_rds("00_data/dat3_200_r4.rds")
# dat3_200_r4[[1]][,,1] %>% as_tibble()
# res3_gam_r4 <- FRES(
#   indat = list(dat3_200_r4[[1]][,,],
#                dat3_200_r4[[2]],
#                dat3_200_r4[[3]]),
#   modeling_method = "GAM",
#   id_m            = 3
# )
# res3_gam_r4 %>% write_rds("00_data/equation_1_results/res3_200_gam_r4.rds")


# dat3_200_r5 <- read_rds("00_data/dat3_200_r5.rds")
# dat3_200_r5[[1]][,,1] %>% as_tibble()
# res3_gam_r5 <- FRES(
#   indat = list(dat3_200_r5[[1]][,,],
#                dat3_200_r5[[2]],
#                dat3_200_r5[[3]]),
#   modeling_method = "GAM",
#   id_m            = 3
# )
# res3_gam_r5 %>% write_rds("00_data/equation_1_results/res3_200_gam_r5.rds")


res3_gam_r1 <- read_rds("00_data/equation_1_results/res3_200_gam_r1.rds")
res3_gam_r2 <- read_rds("00_data/equation_1_results/res3_200_gam_r2.rds")
res3_gam_r3 <- read_rds("00_data/equation_1_results/res3_200_gam_r3.rds")
res3_gam_r4 <- read_rds("00_data/equation_1_results/res3_200_gam_r4.rds")
res3_gam_r5 <- read_rds("00_data/equation_1_results/res3_200_gam_r5.rds")


## The rest ----
res3_randforest_r1 <- read_rds("00_data/equation_3_results/res3_200_randforest_r1.rds")

res3_rpart_r1 <- read_rds("00_data/equation_3_results/res3_200_rpart_r1.rds")

res3_svm_r1 <- read_rds("00_data/equation_3_results/res3_200_svm_r1.rds")

res3_xgboost_r1 <- read_rds("00_data/equation_3_results/res3_200_xgboost_r1.rds")


### Plot ----
res2_gam_r5 %>% my_get_metrics(method = "GAM",id_m = 2) %>% 
  bind_rows(
    res2_randforest_r5 %>% my_get_metrics(method = "Random Forest",id_m = 2),
    res2_rpart_r5 %>% my_get_metrics(method = "Simple Tree",id_m = 2),
    res2_svm_r5 %>% my_get_metrics(method = "SVM",id_m = 2),
    res2_xgboost_r5 %>% my_get_metrics(method = "XGBoost",id_m = 2)
  ) %>% plot_metrics()



# . ----
# idm=4 all 5 rounds ----
## All GAMs ----
dat4_200_r1 <- read_rds("00_data/dat4_200.rds")
dat4_200_r1[[1]][,,1] %>% as_tibble()
res4_gam_r1 <- FRES(
  indat = list(dat4_200_r1[[1]][,,],
               dat4_200_r1[[2]],
               dat4_200_r1[[3]]),
  modeling_method = "GAM",
  id_m            = 4
)
res4_gam_r1 %>% write_rds("00_data/equation_4_results/res4_200_gam_r1.rds")


dat4_200_r2 <- read_rds("00_data/dat4_200_r2.rds")
dat4_200_r2[[1]][,,1] %>% as_tibble()
res4_gam_r2 <- FRES(
  indat = list(dat4_200_r2[[1]][,,],
               dat4_200_r2[[2]],
               dat4_200_r2[[3]]),
  modeling_method = "GAM",
  id_m            = 4
)
res4_gam_r2 %>% write_rds("00_data/equation_4_results/res4_200_gam_r2.rds")


# dat3_200_r3 <- read_rds("00_data/dat3_200_r3.rds")
# dat3_200_r3[[1]][,,1] %>% as_tibble()
# res3_gam_r3 <- FRES(
#   indat = list(dat3_200_r3[[1]][,,],
#                dat3_200_r3[[2]],
#                dat3_200_r3[[3]]),
#   modeling_method = "GAM",
#   id_m            = 3
# )
# res3_gam_r3 %>% write_rds("00_data/equation_1_results/res3_200_gam_r3.rds")


# dat3_200_r4 <- read_rds("00_data/dat3_200_r4.rds")
# dat3_200_r4[[1]][,,1] %>% as_tibble()
# res3_gam_r4 <- FRES(
#   indat = list(dat3_200_r4[[1]][,,],
#                dat3_200_r4[[2]],
#                dat3_200_r4[[3]]),
#   modeling_method = "GAM",
#   id_m            = 3
# )
# res3_gam_r4 %>% write_rds("00_data/equation_1_results/res3_200_gam_r4.rds")


# dat3_200_r5 <- read_rds("00_data/dat3_200_r5.rds")
# dat3_200_r5[[1]][,,1] %>% as_tibble()
# res3_gam_r5 <- FRES(
#   indat = list(dat3_200_r5[[1]][,,],
#                dat3_200_r5[[2]],
#                dat3_200_r5[[3]]),
#   modeling_method = "GAM",
#   id_m            = 3
# )
# res3_gam_r5 %>% write_rds("00_data/equation_1_results/res3_200_gam_r5.rds")


fs::dir_tree("00_data")

## Equation 4 ----
fs::dir_info("00_data/equation_4_results/") %>% 
  select(path) %>% 
  mutate(data = path %>% map(read_rds)) %>% 
  mutate(
    data = data %>% map(.f = function(X){X %>% as_tibble(rownames = "estimator") %>% filter(str_detect(estimator,"ML"))})
  ) %>% unnest(data) %>% 
  mutate(path = basename(path)) %>% 
  mutate(
    equation = str_extract(path,"res\\d") %>% str_extract("\\d"),
    ml_method = str_extract(path,"[a-z]+(?=\\_r)")
  ) %>% 
  group_by(estimator,ml_method) %>% 
  summarise_at(
    c("RB","RSE","RRMSE"),
    .funs = list("mean" = mean,"median" = median)
  ) -> eq_4_results_tbl

eq_4_results_tbl %>% write_rds("00_data/ongoing_eq4_results.rds")
eq_4_results_tbl %>% write_csv("00_data/ongoing_eq4_results.csv")

eq4_tbl <- read_rds("00_data/ongoing_eq4_results.rds")

eq4_tbl

1:3 %>% 
  map(.f = function(X){
    fs::dir_info(str_glue("00_data/equation_{X}_results/")) %>% 
      select(path) %>% 
      mutate(data = path %>% map(read_rds))
  }) %>% bind_rows() %>% 
  mutate(path = basename(path)) %>% 
  mutate(
    data = data %>% map(.f = function(X){X %>% as_tibble(rownames = "estimator") %>% filter(str_detect(estimator,"ML"))})
  ) %>% 
  unnest(data) -> results_tbl

results_tbl %>% write_rds("00_data/ongoing_all_results_for_export.rds")

results_tbl <- read_rds("00_data/ongoing_all_results_for_export.rds")



results_tbl %>% 
  mutate(
    equation = str_extract(path,"res\\d") %>% str_extract("\\d"),
    ml_method = str_extract(path,"[a-z]+(?=\\_r)")
  ) %>% 
  group_by(estimator,ml_method,equation) %>% 
  summarise_at(
    c("RB","RSE","RRMSE"),
    .funs = list("mean" = mean,"median" = median)
  ) %>% 
  ungroup() -> grouped_results_tbl

grouped_results_tbl %>% write_rds("00_data/ongoing_all_results_grouped.rds")
grouped_results_tbl %>% write_csv("00_data/ongoing_all_results_grouped.csv")










