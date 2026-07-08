test_that("stat_compare_means_prism reports a clear optional dependency error", {
  skip_if(requireNamespace("ggpubr", quietly = TRUE),
          "ggpubr is installed, so the missing-dependency branch is not active")
  expect_error(
    stat_compare_means_prism(comparisons = list(c("A", "B"))),
    "Package 'ggpubr' is required"
  )
})
