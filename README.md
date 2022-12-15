
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nottshcFFT

<!-- badges: start -->
<!-- badges: end -->

The aim of this package is to collect together the functions used in the
Friends and Family (FFT) monthly return which requires a data download
from a clinical system which is then uploaded to the MySQL Patient
Feedback database.

The upload from a clinical system includes Comments which can be
cleaned, to some extent, before loading. Once in the MySQL database they
are further checked for identifiable information and safeguarding by
staff in the Patient Involvement team.

This package also serves as a public example of packages created and
used by the CDU Data Science Team.

## Installation

You can install nottshcFFT from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("CDU-data-science-team/nottshcFFT")
```

**You might get an error/warning/not load if you are on the VPN!**

It is preferable to build from the repository rather than locally as
this should be what everyone in the team has access to. To build and
test any new functions use `Ctrl+Shift+L` to load locally for the
session.

However, the person who is maintaining the package may want to install
the development branch:

``` r
# install.packages("remotes")
remotes::install_github("CDU-data-science-team/nottshcFFT@development")
```

## Loading the package

``` r
library(nottshcFFT)
#> 
#> ── Lori, you are smashing! ─────────────────────────────────────────────────────
#> This is nottshcFFT 0.0.0.9000
#> nottshcFFT is currently in development - please report any bugs or ideas at:
#> https://github.com/CDU-data-science-team/nottshcFFT/issues
#> 
#> ── Connection required to NOTTSHC servers: ─────────────────────────────────────
#> ℹ Microsoft SQL server to download - contact AI
#> ℹ MySQL server to upload - contact CDU
```
