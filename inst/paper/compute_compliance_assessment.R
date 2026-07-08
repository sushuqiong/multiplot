# Reproduce the publication-compliance benchmark used in the manuscript.
#
# This script is intentionally kept outside the package runtime. It uses
# analysis-only packages (colorspace, farver) to score the first five colours of
# each supported style for colour-vision-deficiency (CVD) separability,
# grayscale print fidelity, and approximate CMYK print risk.

required <- c("colorspace", "farver")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) {
  stop("Install analysis-only packages first: install.packages(c(",
       paste(sprintf('"%s"', missing), collapse = ", "), "))", call. = FALSE)
}

script_path <- tryCatch(normalizePath(sys.frame(1)$ofile), error = function(e) NA_character_)
script_dir <- if (is.na(script_path)) getwd() else dirname(script_path)
root <- normalizePath(file.path(script_dir, "..", ".."), mustWork = FALSE)
if (!file.exists(file.path(root, "R", "scales.R"))) {
  root <- normalizePath(file.path(getwd()), mustWork = FALSE)
}
source(file.path(root, "R", "scales.R"), local = TRUE)

palettes <- list(
  Prism = prism_palette,
  SPSS = spss_palette,
  OriginPro = origin_palette,
  `Stata s2color` = stata_palette,
  Academic = academic_palette,
  SigmaPlot = sigmaplot_palette,
  JMP = jmp_palette,
  `MATLAB R2014b+` = matlab_palette,
  Minitab = minitab_palette,
  MedCalc = medcalc_palette
)

first_n <- 5

min_pairwise_delta_e <- function(hex) {
  lab <- farver::decode_colour(hex, to = "lab")
  d <- as.matrix(stats::dist(lab))
  min(d[upper.tri(d)])
}

cvd_min_delta <- function(hex) {
  transforms <- list(
    deuteranopia = colorspace::deutanomaly_cvd[["10"]],
    protanopia = colorspace::protanomaly_cvd[["10"]],
    tritanopia = colorspace::tritanomaly_cvd[["10"]]
  )
  vals <- vapply(transforms, function(tr) {
    min_pairwise_delta_e(colorspace::simulate_cvd(hex, tr))
  }, numeric(1))
  min(vals)
}

score_cvd <- function(min_delta) {
  if (min_delta >= 20) return(5L)
  if (min_delta >= 15) return(4L)
  if (min_delta >= 10) return(3L)
  if (min_delta >= 4) return(2L)
  1L
}

is_grayscale <- function(hex) {
  rgb <- farver::decode_colour(hex, to = "rgb")
  all(apply(rgb, 1, function(x) max(x) - min(x)) < 2)
}

score_grayscale <- function(hex) {
  lab <- farver::decode_colour(hex, to = "lab")
  lstar <- sort(lab[, "l"])
  groups <- 1L
  last <- lstar[1]
  for (val in lstar[-1]) {
    if (abs(val - last) >= 8) {
      groups <- groups + 1L
      last <- val
    }
  }
  range_l <- diff(range(lstar))
  if (groups >= 5 && range_l >= 60) return(5L)
  if (groups >= 4 && range_l >= 35) return(4L)
  if (groups >= 3 && range_l >= 20) return(3L)
  if (groups >= 2) return(2L)
  1L
}

approx_cmyk_score <- function(hex) {
  rgb <- farver::decode_colour(hex, to = "rgb") / 255
  saturation <- apply(rgb, 1, function(x) max(x) - min(x))
  pure_channel <- apply(rgb, 1, function(x) any(x > 0.97) && any(x < 0.03))
  risky <- sum(saturation > 0.85 | pure_channel)
  if (risky == 0) return(5L)
  if (risky <= 1) return(4L)
  if (risky <= 2) return(3L)
  if (risky <= 3) return(2L)
  1L
}

rows <- lapply(names(palettes), function(style) {
  hex <- palettes[[style]][seq_len(min(first_n, length(palettes[[style]])))]
  cvd_delta <- cvd_min_delta(hex)
  has_pure_red_green <- all(c("#FF0000", "#008000") %in% toupper(hex))
  gray_score <- score_grayscale(hex)
  cmyk_score <- approx_cmyk_score(hex)
  cvd_score <- if (is_grayscale(hex)) 5L else if (has_pure_red_green) 1L else score_cvd(cvd_delta)
  data.frame(
    style = style,
    n_colours_scored = length(hex),
    min_cvd_delta_e = round(cvd_delta, 1),
    cvd_score = cvd_score,
    grayscale_score = gray_score,
    cmyk_score = cmyk_score,
    overall = round(mean(c(cvd_score, gray_score, cmyk_score)), 1),
    stringsAsFactors = FALSE
  )
})

out <- do.call(rbind, rows)
out <- out[order(-out$overall, out$style), ]

paper_dir <- file.path(root, "inst", "paper")
dir.create(paper_dir, showWarnings = FALSE, recursive = TRUE)
write.csv(out, file.path(paper_dir, "compliance_assessment_reproducibility.csv"),
          row.names = FALSE)

log_lines <- c(
  "# Compliance Assessment Reproducibility Log",
  "",
  paste("Generated:", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z")),
  paste("R:", R.version.string),
  paste("colorspace:", as.character(utils::packageVersion("colorspace"))),
  paste("farver:", as.character(utils::packageVersion("farver"))),
  "",
  "Scoring rules:",
  "- CVD: minimum pairwise CIE76 distance after deuteranopia, protanopia, and tritanopia simulation; grayscale palettes are treated as CVD-safe; pure red/green pairs are treated as critical; otherwise >=20=5, >=15=4, >=10=3, >=4=2, <4=1.",
  "- Grayscale: number of CIELAB L* groups separated by at least 8 units among the first five colours, with total L* range checks.",
  "- CMYK: reproducible approximate print-risk score based on RGB saturation and pure-channel risk, used as a transparent proxy when no ICC profile is bundled.",
  "- Overall: arithmetic mean of CVD, grayscale, and CMYK scores, rounded to one decimal place.",
  "",
  paste(c(names(out)), collapse = " | "),
  paste(rep("---", ncol(out)), collapse = " | "),
  apply(out, 1, function(x) paste(x, collapse = " | "))
)
writeLines(log_lines, file.path(paper_dir, "compliance_assessment_reproducibility.md"))
print(out, row.names = FALSE)
