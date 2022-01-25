

my_get_metrics <- function(res,method,id_m) {
  res %>% 
    as_tibble(rownames = "estimator") %>% 
    filter(str_detect(estimator,"ML")) %>% 
    pivot_longer(cols = RB:RRMSE) %>% 
    mutate(ml_method = method,
           id_m      = id_m)
}


plot_metrics <- function(my_get_metrics_tbl,ml_fill=T,mean_or_med="mean"){
  if(ml_fill){
    my_get_metrics_tbl %>% 
      filter(str_detect(tolower(estimator),mean_or_med)) %>% 
      
      ggplot(aes(value,ml_method,fill=ml_method)) +
      facet_wrap(~name,scales = "free_x") + 
      geom_col() + 
      labs(title = str_c(toupper(mean_or_med),"- Equation",my_get_metrics_tbl$id_m,sep = " "),
           y = "") + 
      theme_tq() + scale_fill_tq() -> g
    
    plotly::ggplotly(g)
  } else{
    my_get_metrics_tbl %>% 
      mutate(id_m = factor(id_m)) %>% 
      filter(str_detect(tolower(estimator),mean_or_med)) %>% 
      
      ggplot(aes(value,id_m,fill=id_m)) +
      facet_wrap(~name,scales = "free_x") + 
      geom_col() + 
      labs(title = toupper(mean_or_med),
           y = "") + 
      theme_tq() + scale_fill_tq() -> g
    
    plotly::ggplotly(g)
  }
}



# . ----
write_datBs_from_array <- function(array_index,dat_array,eq_123,r_num){
  array_index %>% 
    map(.f = function(X){
      dat_array[[1]][,,X] -> dat          
      
      y      <- dat[,1]
      x1     <- dat[,2]
      x2     <- dat[,3]
      x3     <- dat[,4]
      x4     <- dat[,5]
      
      # Sample Indicators for A and B
      sIA    <- dat[,6]
      sIB    <- dat[,7]
      
      # Covariates for A and B
      sx1A   <- x1[sIA == 1]
      sx1B   <- x1[sIB == 1]
      sx2A   <- x2[sIA == 1]
      sx2B   <- x2[sIB == 1]
      sx3A   <- x3[sIA == 1]
      sx3B   <- x3[sIB == 1]
      sx4A   <- x4[sIA == 1]
      sx4B   <- x4[sIB == 1]
      
      # Response for B
      syB    <- y[sIB == 1]
      
      # datB
      bind_cols(syB,sx1B,sx2B,sx3B,sx4B) %>% set_names("syB","sx1B","sx2B","sx3B","sx4B") -> datB
      
      # Write sample B to CSV file
      datB %>% write_csv(str_glue(
        "Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/equation_{eq_123}/round_{r_num}/datB_{X}.csv"
      ))
      
      rm(datB)
    })
}


write_datXAs_from_array <- function(array_index,dat_array,eq_123,r_num){
  array_index %>% 
    map(.f = function(X){
      dat_array[[1]][,,X] -> dat          
      
      y      <- dat[,1]
      x1     <- dat[,2]
      x2     <- dat[,3]
      x3     <- dat[,4]
      x4     <- dat[,5]
      
      # Sample Indicators for A and B
      sIA    <- dat[,6]
      sIB    <- dat[,7]
      
      # Covariates for A and B
      sx1A   <- x1[sIA == 1]
      sx1B   <- x1[sIB == 1]
      sx2A   <- x2[sIA == 1]
      sx2B   <- x2[sIB == 1]
      sx3A   <- x3[sIA == 1]
      sx3B   <- x3[sIB == 1]
      sx4A   <- x4[sIA == 1]
      sx4B   <- x4[sIB == 1]
      
      # Response for B
      syB    <- y[sIB == 1]
      
      # datXA
      # The colnames for A are labelled with B's because we're gonna predict using A as new data 
      # (has to have same column names)
      bind_cols(sx1A,sx2A,sx3A,sx4A) %>% set_names("sx1B","sx2B","sx3B","sx4B") -> datXA
      
      datXA %>% write_csv(str_glue(
        "Chen_scripts/01_method_exploration/00_try_out_stuff/00_python_data/equation_{eq_123}/round_{r_num}/datXA_{X}.csv"
      )) 
      
      rm(datXA)
    })
}