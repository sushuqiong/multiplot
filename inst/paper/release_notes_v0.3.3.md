# multiplot v0.3.3 -- reviewer-methodology and F1000Research revision

This release incorporates reviewer-style feedback on the manuscript, package
documentation, reproducibility materials, and GitHub presentation.

## Highlights

- Adds `ggchoice(include_scales = FALSE)` for theme-only use while preserving
  the default single-call theme + colour/fill scale behaviour.
- Adds a reproducible compliance benchmark script:
  `inst/paper/compute_compliance_assessment.R`.
- Clarifies CVD scoring methods, separates Birch prevalence citation from
  Machado/colorspace simulation methods, and records scoring thresholds.
- Adds software evidence levels and stronger wording around documentation-based
  approximations versus screenshot-verified styles.
- Improves README, vignette, manuscript-support files, and pkgdown content with
  API overview, font fallback notes, scale override behaviour, optional
  dependencies, CI/R CMD check notes, and trademark disclaimer.
- Adds an R-CMD-check GitHub Actions workflow.

## Verification

- `R CMD build`
- `R CMD check --no-manual --no-build-vignettes --ignore-vignettes`
- `testthat` package tests
- Demo run in a clean temporary directory generated 20 files:
  `Figure1`-`Figure10` as both PNG and PDF.
- `inst/paper/compute_compliance_assessment.R` generated
  `compliance_assessment_reproducibility.csv` and `.md`.

## Archive

- GitHub release: https://github.com/sushuqiong/multiplot/releases/tag/v0.3.3
- Zenodo version DOI: to be added after Zenodo archives this release
- Zenodo concept DOI: https://doi.org/10.5281/zenodo.21137144
