#' `Opt` class
#'
#' This is an R6 class used to represent an option.
#'
#' This class is not meant to be used directly by the user. Instead, use the `opt` function
#' to create new instances.
Opt <- R6::R6Class("Opt", # nolint: object_name_linter.
  public = list(
    default = NULL,
    doc = NULL,
    type = NULL,
    choices = NULL,
    sep = NULL,
    redact = NULL,
    initialize = function(
        default,
        type,
        doc = NULL,
        choices = NULL,
        sep = ",",
        redact = NULL) {
      self$default <- default
      self$doc <- doc
      self$type <- type
      self$choices <- choices
      self$sep <- sep
      self$redact <- redact
    }
  )
)

#' Create a new `Opt` instance
#'
#' @description This function creates a new `Opt` instance with the provided parameters.
#' @param ... The parameters to be passed to the `Opt` constructor.
#' @return A new `Opt` instance.
#' @export
opt <- function(...) {
  Opt$new(...)
}
