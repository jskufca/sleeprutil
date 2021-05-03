## code to prepare `DATASET` dataset goes here


# Load template for redcap database -----------------------------------
templatefile=("D:/Dropbox/Research/Fulk_stroke/FulkStrokeRecovery/SLEEPRDataCollection_ImportTemplate_2021-04-21.csv")
df_temp=readr::read_csv(templatefile,n_max = 0) %>%
  dplyr::select(1:519)



usethis::use_data(df_temp, overwrite = TRUE)



