test_that("basic functions work", {
  # example app
  MyAppCfg <- R6::R6Class("MyAppCfg", # nolint: object_name_linter.
    inherit = BaseCfg,
    public = list(
      width = opt(10, "integer", doc = "the width of a widget"),
      height = opt(20, "integer", "the height of a widget"),
      depth = opt(30, "integer", "the depth of a widget")
    )
  )

  Sys.setenv(WIDTH = 202)

  cfg <- MyAppCfg$new()
  expect_equal(cfg$depth, 30)
  expect_equal(cfg$height, 20)
  expect_equal(cfg$width, 202)
})
