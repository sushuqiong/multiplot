test_that("ggchoice returns list for all 10 styles", {
  styles <- c("prism","spss","origin","stata","academic",
              "sigmaplot","jmp","matlab","minitab","medcalc")
  for (s in styles) {
    res <- ggchoice(s)
    expect_type(res, "list")
    expect_true(length(res) >= 3)
  }
})

test_that("ggchoice() defaults to theme_bw", {
  res <- ggchoice()
  expect_s3_class(res, "theme")
})

test_that("ggchoice('ggplot2') returns theme_bw", {
  res <- ggchoice("ggplot2")
  expect_s3_class(res, "theme")
})

test_that("ggchoice with axis_offset adds scale expansion", {
  res <- ggchoice("prism", axis_offset = TRUE)
  expect_true(length(res) > 3)
})

test_that("ggchoice respects base_size", {
  res <- ggchoice("prism", base_size = 16)
  expect_type(res, "list")
})

test_that("ggchoice rejects invalid style", {
  expect_error(ggchoice("nonexistent"))
})
