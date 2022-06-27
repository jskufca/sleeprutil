#' template_pal_data
#'
#' Allows user to interactively select a .csv file created from PAL device and
#' outputs a file of similar name, but inserted into the REDCAP template.
#'
#' @param testing   logical (FALSE) set to true only for testing
#' @param pal_format string ("new") or "old" ActivPal file format for test file.
#'   This parameter has no effect on normal (operational) usage of this command.
#'
#' @return Nothing.  Runs for side effect (creates a file). In test mode,
#'   returns dataframe of output that would written to csv
#' @export
#'
#'
#'
#'
template_pal_data <- function(testing=FALSE,pal_format="new") {

  if (testing)  {
    if (pal_format=="old"){
      myfile=test_path("activpaltest.csv")
    } else {
      myfile=test_path("activpaltest_new.csv")
      }
  } else {
    myfile=file.choose() # PAL file
  }


 #determine where data starts
  start_line=vroom::vroom_lines(myfile,25) %>% stringr::str_which("Folder")

  df_pal=readr::read_csv2(myfile, col_types = readr::cols(.default = "c"),
                          skip=start_line -1) %>%
    dplyr::select(-1) # read PAL


  dftemp=redcap_template
  a=names(dftemp)[476:520] # get proper variable names from the standard REDCAP template
  names(df_pal)=a
  dftry=dplyr::bind_rows(dftemp, df_pal)
  output_file=myfile %>%
    filesstrings::before_last_dot() %>% paste0("_templated.csv")

  if (testing)  {
    dftry
  } else {
    readr::write_csv(dftry,output_file,na="")
  }



}
