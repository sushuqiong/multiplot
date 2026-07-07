# multiplot v0.3.2 release notes

## Suggested GitHub release title

multiplot v0.3.2 -- F1000Research submission and website release

## Suggested GitHub release notes

This release prepares `multiplot` for F1000Research Software Tool Article
submission and public promotion.

### Highlights

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

### Verification

- `R CMD build`
- `R CMD check --no-manual --no-build-vignettes --ignore-vignettes`
- Demo run in a clean temporary directory generated 20 files:
  `Figure1`-`Figure10` as both PNG and PDF.
- Namespace export count: 29 functions.

## Suggested Zenodo metadata

Title:

`sushuqiong/multiplot: v0.3.2 -- F1000Research submission and website release`

Description:

`multiplot` is an R/ggplot2 extension for emulating nine statistical graphing
software-derived plot styles plus one academic publication style using a single
`ggchoice()` call. Version 0.3.2 prepares the package, website, reproducible
demo figures, verification notes, and F1000Research manuscript-support files
for public release.

Creators:

- Shuqiong Su
- Aiqun Liu

License:

MIT

Keywords:

R, ggplot2, data visualization, statistical graphics, biomedical figures,
GraphPad Prism, SPSS, OriginPro, Stata, MATLAB, Minitab, MedCalc, SigmaPlot,
JMP, reproducible research

