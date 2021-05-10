#' template_pal_data
#'
#' Allows user to interactively select a .csv file created from PAL device and
#' outputs a file of similar name, but inserted into the REDCAP template.
#'
#' @return Nothing.  Runs for side effect (creates a file)
#' @export
#'
#'
#'
#'
template_pal_data <- function() {
  myfile=file.choose() # PAL file
  df_pal=readr::read_csv2(myfile, col_types = readr::cols(.default = "c"),skip=1) %>%
    dplyr::select(-1) # read PAL
  df_temp=redcap_template
  a=names(df_temp)[458:502] # get proper variable names from the standard REDCAP template
  names(df_pal)=a
  dftry=dplyr::bind_rows(df_temp, df_pal)
  output_file=myfile %>%
    filesstrings::before_last_dot() %>% paste0("_templated.csv")
  readr::write_csv(dftry,output_file,na="")
}
