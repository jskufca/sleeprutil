% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/template_pal_data.R
\name{template_pal_data}
\alias{template_pal_data}
\title{template_pal_data}
\usage{
template_pal_data(testing = FALSE, pal_format = "new")
}
\arguments{
\item{testing}{logical (FALSE) set to true only for testing}

\item{pal_format}{string ("new") or "old" ActivPal file format for test file.
This parameter has no effect on normal (operational) usage of this command.}
}
\value{
Nothing.  Runs for side effect (creates a file). In test mode,
returns dataframe of output that would written to csv
}
\description{
Allows user to interactively select a .csv file created from PAL device and
outputs a file of similar name, but inserted into the REDCAP template.
}
