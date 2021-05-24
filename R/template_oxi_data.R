#' template_oxi_data
#'
#' @return Nothing.  Runs for side effect (creates a file)
#' @export
#'
#'
template_oxi_data <- function() {
  #myfile="SmithJohnTrial.pdf"
  myfile=file.choose()  #oxi file
  oxi_text=pdftools::pdf_text(myfile)
  dfr=oxi_text %>%
    readr::read_lines() %>%
    # convert to tibble and assign unique column names
    tibble::as_tibble(.name_repair = make.names) %>% dplyr::slice(-1) # first line not needed

  ##### Extract data elements
  #from row 1
  screen_name=dfr$value[1] %>% stringr::str_split_fixed("  ",Inf) %>%
    stringi::stri_remove_empty() %>%
    purrr::pluck(2) %>% stringr::str_split(":") %>% purrr::pluck(1,2) %>% stringr::str_trim()

  #row 3
  screen_id=dfr$value[3] %>% stringr::str_split_fixed("  ",Inf) %>%
    stringi::stri_remove_empty() %>% stringr::str_trim() %>%
    stringr::str_subset("ID:") %>% stringr::str_split(":") %>% purrr::pluck(1,2) %>% stringr::str_trim()
  #I am keeping as string
  # TODO ensure George concurs

  a=dfr$value[6] %>% stringr::str_split_fixed("  ",30) %>%
    stringi::stri_remove_empty()
  date_nocturnal_oxi=a[1] %>% stringr::str_split(":") %>% purrr::pluck(1,2) %>% stringr::str_trim() %>%
    lubridate::as_date(format="%d %B %Y ") %>% format("%m-%d-%Y")


  #oxi_start_time=a[2] %>% str_split("e: ") %>% purrr::pluck(1,2) %>% str_sub(1,5)
  oxi_start_time=a[2] %>% stringr::str_split(": ") %>% purrr::pluck(1,2) %>% stringr::str_sub(1,5)

  oxi_duration=a[3] %>% stringr::str_split("n: ") %>% purrr::pluck(1,2)  %>% lubridate::hms() %>%
    lubridate::as.duration() %>% as.numeric() %>% `/`(60) %>% round()

  oxi_analyzed=a[4] %>% stringr::str_split("d: ") %>% purrr::pluck(1,2) %>% lubridate::hms() %>%
    lubridate::as.duration() %>% as.numeric() %>% `/`(60) %>% round()

  ##### Helper function for single value pulls:
  pluck_value = function (x,item=2) {
    dfr$value[x] %>% stringr::str_split("   ") %>%
      unlist() %>% stringi::stri_remove_empty() %>% purrr::pluck(item) %>% as.numeric()
  }
  oxi_total_events=pluck_value(11)
  oxi_time_events = pluck_value(12)
  oxi_ave_event_duration=pluck_value(13)
  odi= pluck_value(15)
  oxi_artifact = pluck_value(16)
  oxi_index = pluck_value(17)
  oxi_basal= pluck_value(20)
  oxi_time_less_88= pluck_value(21)
  oxi_events_less_88= pluck_value(22)
  oxi_below_90=pluck_value(13,7)


  #### Assemble into dataframe:

  dfout=tibble::tibble(
    screen_id,
    date_nocturnal_oxi,oxi_start_time,oxi_duration,oxi_analyzed,
    oxi_total_events,oxi_time_events,oxi_ave_event_duration,
    odi,oxi_artifact,oxi_index,oxi_basal,
    oxi_time_less_88,oxi_events_less_88,oxi_below_90) %>%
    dplyr::mutate(dplyr::across(tidyselect::everything(),as.character))

  df_temp=redcap_template
  dftry=dplyr::bind_rows(df_temp, dfout)

  ### Write to file

  output_file=myfile %>% stringr::str_replace(".pdf","_templated.csv")
  readr::write_csv(dftry,output_file,na="")

}
