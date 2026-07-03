test_that("geom_errorbar_prism returns a layer", {
  g <- geom_errorbar_prism()
  expect_s3_class(g, "LayerInstance")
})

test_that("geom_col_prism returns a layer with black colour", {
  g <- geom_col_prism()
  expect_s3_class(g, "LayerInstance")
})

test_that("geom_boxplot_prism returns a layer", {
  g <- geom_boxplot_prism()
  expect_s3_class(g, "LayerInstance")
})

test_that("geom_boxplot_prism returns a boxplot layer with black colour", {
  g <- geom_boxplot_prism()
  expect_s3_class(g, "LayerInstance")
  expect_equal(g$aes_params$colour, "black")
})

test_that("geom_col_prism has black colour and specific width", {
  g <- geom_col_prism()
  expect_equal(g$aes_params$colour, "black")
  expect_equal(g$aes_params$width, 0.7)
})
