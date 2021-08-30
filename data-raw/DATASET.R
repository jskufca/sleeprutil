## code to prepare `DATASET` dataset goes here


# Load template for redcap database -----------------------------------
#templatefile=("E:/Dropbox/Research/Fulk_stroke/FulkStrokeRecovery/SLEEPRDataCollection_ImportTemplate_2021-05-20.csv")
templatefile=("E:/Dropbox/Research/Fulk_stroke/FulkStrokeRecovery/SLEEPRDataCollection_ImportTemplate_2021-08-30.csv")

redcap_template=readr::read_csv(templatefile,n_max = 0) %>%
  dplyr::select(1:549)



usethis::use_data(redcap_template, overwrite = TRUE,internal=TRUE)



