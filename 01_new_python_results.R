

# 01 new python results ----


# Libraries ----
pacman::p_load(
  tidyverse,
  abind
)


# Import pred CSVs ----
fs::dir_info(path = "Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/equation_1/round_1") %>% 
  select(path) %>% 
  mutate(
    path = basename(path),
    path = str_remove(path,"\\_\\d+")
  ) %>% 
  distinct(path)

read_csv("Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/equation_1/round_1/3_selu_pred_1.csv")
read_csv("Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/equation_1/round_1/3_pred_1.csv")

read_csv("Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/equation_1/round_1/4_selu_pred_1.csv")


