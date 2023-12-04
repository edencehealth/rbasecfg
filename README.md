# rbasecfg

<!-- badges: start -->
<!-- badges: end -->

[`rbasecfg`](https://github.com/edencehealth/rbasecfg) is an R implementation of the [basecfg](https://github.com/edencehealth/basecfg) Python package. **It is currently under active development.**


## Installation

You can install the development version of rbasecfg like so:

``` r
devtools::install_github("edencehealth/rbasecfg@v0")
```

## Usage

Here's a basic example of how you can define your application's configuration with `rbasecfg`:

``` r
library(rbasecfg)

MyAppCfg <- R6::R6Class("MyAppCfg",
  inherit = BaseCfg,
  public = list(
    width = opt(default = 10, type = "integer", doc = "the width of a widget"),
    height = opt(default = 20, type = "integer", doc = "the height of a widget"),
    depth = opt(defulat = 30, type = "integer", doc = "the depth of a widget")
  )
)
```

In your main program:

```r
cfg <- MyAppCfg$new()
```

At runtime, these variables are automatically populated from the defaults, environment variables, and command-line arguments:

```r
cfg$depth
cfg$height
cfg$width
```
