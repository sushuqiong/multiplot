# multiplot v0.3.4 -- pre-submission manuscript and demo consistency revision

This release makes a focused pre-submission revision after independent AI
reviews of the v0.3.3 manuscript and demo materials.

## Highlights

- Updates the manuscript title and wording from stronger "emulation" language
  toward software-derived approximation language.
- Adds Shiyao Yang and Guozhen Chen to the manuscript/package author list using
  conservative validation, visualization, and review/editing contributions.
- Aligns Figure 7-10 captions with the actual demo code.
- Adds `cowplot` to `Suggests` because the demo uses `plot_grid()`.
- Updates the demo to save `figures/session_info.txt` and to use clearer
  survival coding with `Surv(time, status == 2)`.
- Generates both the F1000Research-friendly manuscript draft and an additional
  Word preview with embedded Figure1-Figure10 images.

## Verification

- `R CMD build`
- `R CMD check --no-manual --no-build-vignettes --ignore-vignettes`
- `testthat` package tests
- Confirmed `length(getNamespaceExports("multiplot")) == 29`
- Demo run in a clean temporary directory generated 20 figure files plus
  `figures/session_info.txt`.

## Archive

- GitHub release: https://github.com/sushuqiong/multiplot/releases/tag/v0.3.4
- Zenodo version DOI: to be added after Zenodo archives this release
- Zenodo concept DOI: https://doi.org/10.5281/zenodo.21137144
