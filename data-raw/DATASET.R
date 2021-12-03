## code to prepare `DATASET` dataset goes here

library(dplyr,include.only = "%>%")

# Load template for redcap database -----------------------------------
#templatefile=("E:/Dropbox/Research/Fulk_stroke/FulkStrokeRecovery/SLEEPRDataCollection_ImportTemplate_2021-05-20.csv")
#templatefile=("E:/Dropbox/Research/Fulk_stroke/FulkStrokeRecovery/SLEEPRDataCollection_ImportTemplate_2021-08-30.csv")
templatefile=here::here("data-raw","SLEEPRDataCollection_ImportTemplate_2021-12-03.csv")

redcap_template=readr::read_csv(templatefile,n_max = 0)




usethis::use_data(redcap_template, overwrite = TRUE,internal=TRUE)



