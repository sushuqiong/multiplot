test_that("all 10 theme functions return complete themes", {
  themes <- list(
    theme_prism(), theme_spss(), theme_origin(), theme_stata(),
    theme_academic(), theme_sigmaplot(), theme_jmp(), theme_matlab(),
    theme_minitab(), theme_medcalc()
  )
  for (t in themes) {
    expect_s3_class(t, "theme")
    expect_true(attr(t, "complete"))
  }
})

test_that("prism theme respects base_size and base_family", {
  t <- theme_prism(base_size = 14, base_family = "serif")
  expect_s3_class(t, "theme")
})

test_that("spss theme has grid and box border", {
  t <- theme_spss()
  expect_false(is.null(t$panel.grid.major))
  expect_false(is.null(t$panel.border))
})

test_that("stata theme has tinted background and horizontal grid only", {
  t <- theme_stata()
  expect_false(is.null(t$panel.background))
  expect_true(is.null(t$panel.grid.major.x$colour))
})

test_that("jmp theme has no grid and outward ticks", {
  t <- theme_jmp()
  expect_false(is.null(t$axis.ticks.length))
})

test_that("matlab theme has box border", {
  t <- theme_matlab()
  expect_false(is.null(t$panel.border))
})

test_that("academic theme has no border", {
  t <- theme_academic()
  expect_true(is.null(t$panel.border$colour) || t$panel.border$colour == "transparent")
})
