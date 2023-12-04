#' @importFrom optparse OptionParser parse_args
NULL

name2arg <- function(name) {
  paste0("--", gsub("_", "-", tolower(name)))
}

name2envvar <- function(name) {
  toupper(name)
}

apply_type <- function(data, type) {
  conversions[[type]](data)
}

#' BaseCfg
#'
#' @description A base R6 class that supports building declarative config
#'   classes which auto-populate from internal defaults, environment variables,
#'   and command line arguments.
#' @importFrom R6 R6Class
#' @importFrom optparse OptionParser parse_args
#' @export
BaseCfg <- R6::R6Class("BaseCfg", # nolint: object_name_linter.
  public = list(
    initialize = function() {
      # Enumerate self
      private$fields <- Filter(function(x) inherits(self[[x]], "Opt"), ls(self))
      for (name in private$fields) {
        private$opt_meta[[name]] <- self[[name]]
      }

      # set from defaults
      private$load_defaults()

      # set from environment variables
      private$load_envvars()

      # set from cli args
      private$load_args()
    }
  ),
  private = list(
    fields = NULL,
    opt_meta = NULL,
    load_defaults = function() {
      for (name in private$fields) {
        print(paste0("setting ", name, " from default"))
        self[[name]] <- private$opt_meta[[name]]$default
      }
    },
    load_envvars = function() {
      env_vars <- Sys.getenv()
      env_var_names <- names(env_vars)
      names <- Filter(
        function(x) name2envvar(x) %in% env_var_names,
        private$fields
      )
      for (name in names) {
        envvar_name <- name2envvar(name)
        opt_meta <- private$opt_meta[[name]]
        print(paste0("setting ", name, " from envvar ", envvar_name))
        self[[name]] <- apply_type(env_vars[[envvar_name]], opt_meta$type)
      }
    },
    load_args = function() {
      argp <- optparse::OptionParser()
      for (name in private$fields) {
        opt_meta <- private$opt_meta[[name]]
        action <- if (opt_meta$type == "logical") "store_true" else "store"

        argp <- optparse::add_option(
          argp,
          c(name2arg(name)),
          dest = name,
          help = paste0(opt_meta$doc, " (default: ", opt_meta$default, ")"),
          action = action
        )
      }
      args <- optparse::parse_args(argp, positional_arguments = TRUE)
      for (name in private$fields) {
        if (!is.null(args[[name]])) {
          print(paste0("setting ", name, " from arg"))
          self[[name]] <- apply_type(args[[envvar_name]], opt_meta$type)
        }
      }
    }
  )
)
