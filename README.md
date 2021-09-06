
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sleeprutil

<!-- badges: start -->
<!-- badges: end -->

The goal of *sleeprutil* is to facilitate data aggregation into the
redcap database used for the NIH funded *SLEEPR* grant.

Changes to these files are required when updates are made to the underlying Redcap database where the SLEEPR data is stored.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jskufca/sleeprutil")
```

## Example Usage

### Processing of PAL data

The PAL device will record activity information, which can then be
output as a .csv file. That file will need to be processed so that it is
in the proper templated format for the Redcap database.

Suppose the data is stored in file `this_pal.csv`. Then executing the
following code:

``` r
library(sleeprutil)
template_pal_data()
```

Will open a dialogue box that allows the user to select the PAL file.
The function will then create an associated csv file, stored as

{this\_pal\_templated.csv}

### Processing oximetry data file

The oximetry data is typically provided as a pdf file. Suppose this file
is named `this_oxi.pdf`. Then executeing the following code:

``` r
template_oxi_data()
```

Will open a dialogue box that allows the user to select the oxi pdf
file. The function will then create an associated csv file, stored as

{this\_oxi\_templated.csv}
