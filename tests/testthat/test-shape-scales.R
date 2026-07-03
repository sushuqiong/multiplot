test_that("all shape scales return ScaleDiscrete", {
  shape_scales <- list(
    scale_shape_prism(), scale_shape_spss(), scale_shape_origin(),
    scale_shape_stata(), scale_shape_academic(), scale_shape_sigmaplot(),
    scale_shape_jmp(), scale_shape_matlab(), scale_shape_minitab(),
    scale_shape_medcalc()
  )
  for (s in shape_scales) {
    expect_s3_class(s, "ScaleDiscrete")
  }
})

test_that("shape scales produce valid shape codes for 5 groups", {
  expect_type(ggmultiplot:::gen_shape(c(16,15,17,18,21))(5), "double")
  expect_equal(length(ggmultiplot:::gen_shape(c(16,15,17,18,21))(7)), 7)
})
