# multiplot v0.3.2 -- F1000Research submission and website release

This release prepares `multiplot` for F1000Research Software Tool Article
submission and public promotion.

## Highlights

- Bumps the package version to `0.3.2`.
- Fixes the MIT license stub so `R CMD check` reports 0 ERROR, 0 WARNING, and 0 NOTE.
- Clarifies the scope as nine graphing software-derived styles plus one
  academic publication style.
- Updates the demo script to generate Figure1-Figure10 reproducibly without
  removing user-installed packages.
- Improves the Kaplan-Meier example legend labels from `sex=1` / `sex=2` to
  `Male` / `Female`.
- Regenerates the pkgdown website under `docs/`.
- Updates manuscript-support files, verification notes, and F1000Research
  availability statements for the v0.3.2 release.

## Verification

- `R CMD build`
- `R CMD check --no-manual --no-build-vignettes --ignore-vignettes`
- Demo run in a clean temporary directory generated 20 files:
  `Figure1`-`Figure10` as both PNG and PDF.
- Namespace export count: 29 functions.

## Archive

- GitHub release: https://github.com/sushuqiong/multiplot/releases/tag/v0.3.2
- Zenodo version DOI: https://doi.org/10.5281/zenodo.21239178
- Zenodo concept DOI: https://doi.org/10.5281/zenodo.21137144

## Metadata

- Creators: Shuqiong Su; Aiqun Liu
- License: MIT
- Keywords: R, ggplot2, data visualization, statistical graphics, biomedical
  figures, GraphPad Prism, SPSS, OriginPro, Stata, MATLAB, Minitab, MedCalc,
  SigmaPlot, JMP, reproducible research
