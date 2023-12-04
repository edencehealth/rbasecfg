# rbasecfg

<!-- badges: start -->
<!-- badges: end -->

`rbasecfg` is an R implementation of the [basecfg](https://github.com/edencehealth/basecfg) Python package. **It is currently a work in progress**.


## Installation

You can install the development version of rbasecfg like so:

``` r
devtools::install_github("edencehealth/rbasecfg@v0")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(rbasecfg)

MyAppCfg <- R6::R6Class("MyAppCfg",
  inherit = BaseCfg,
  public = list(
    width = opt(10, "integer", doc = "the width of a widget"),
    height = opt(20, "integer", "the height of a widget"),
    depth = opt(30, "integer", "the depth of a widget")
  )
)
```

in the main program:
```r
cfg <- MyAppCfg$new()
```

at runtime the following variables are automaticall populated from the defaults, from envvars, and from command-line arguments:

```r
cfg$depth
cfg$height
cfg$width
```
