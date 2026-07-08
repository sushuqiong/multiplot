test_that("all discrete colour scales return ScaleDiscrete", {
  scales_c <- list(
    scale_color_prism(), scale_color_spss(), scale_color_origin(),
    scale_color_stata(), scale_color_academic(), scale_color_sigmaplot(),
    scale_color_jmp(), scale_color_matlab(), scale_color_minitab(),
    scale_color_medcalc()
  )
  for (s in scales_c) {
    expect_s3_class(s, "ScaleDiscrete")
  }
})

test_that("all discrete fill scales return ScaleDiscrete", {
  scales_f <- list(
    scale_fill_prism(), scale_fill_spss(), scale_fill_origin(),
    scale_fill_stata(), scale_fill_academic(), scale_fill_sigmaplot(),
    scale_fill_jmp(), scale_fill_matlab(), scale_fill_minitab(),
    scale_fill_medcalc()
  )
  for (s in scales_f) {
    expect_s3_class(s, "ScaleDiscrete")
  }
})

test_that("all continuous colour scales return ScaleContinuous", {
  scales_cc <- list(
    scale_color_prism_c(), scale_color_origin_c(), scale_color_matlab_c(),
    scale_color_stata_c(), scale_color_academic_c(), scale_color_minitab_c(),
    scale_color_medcalc_c()
  )
  for (s in scales_cc) {
    expect_s3_class(s, "ScaleContinuous")
  }
})

test_that("all continuous fill scales return ScaleContinuous", {
  scales_cf <- list(
    scale_fill_prism_c(), scale_fill_origin_c(), scale_fill_matlab_c(),
    scale_fill_stata_c(), scale_fill_academic_c(), scale_fill_minitab_c(),
    scale_fill_medcalc_c()
  )
  for (s in scales_cf) {
    expect_s3_class(s, "ScaleContinuous")
  }
})

test_that("discrete palettes interpolate when groups exceed source palette length", {
  pal <- scale_color_matlab()$palette
  cols <- pal(12)
  expect_length(cols, 12)
  expect_true(all(grepl("^#", cols)))
})
