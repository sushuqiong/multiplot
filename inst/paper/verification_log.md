# Style Verification Log

This log records the evidence used to tune the `multiplot` visual styles.
The package is intended to provide practical ggplot2 style emulation rather
than pixel-perfect reproduction of proprietary software outputs.

Status levels:

- **Screenshot verified**: checked against real software screenshots supplied for this project.
- **Template screenshot checked**: checked against project screenshots for selected biomedical-style templates or a single plot type.
- **Documentation inferred**: implemented from public documentation, scheme files, user guides, or widely documented defaults.
- **Internal benchmark**: intentionally defined by this package, not a real software default.

## Evidence Sources Used

| Source archive | Contents used | Coverage |
|---|---|---|
| `软件真实截图.zip` | Prism, SPSS, and MATLAB bar and boxplot screenshots | Direct screenshot verification for core bar/box behaviour |
| `其它软件的截图验证.zip` | JMP, MedCalc, Minitab, OriginPro, SigmaPlot, and Stata boxplot screenshots | Direct or partial screenshot verification for selected boxplot behaviour |
| `新建文件夹.zip` | KM survival, enrichment, and heatmap template screenshots for JMP, MATLAB, MedCalc, Minitab, OriginPro, SigmaPlot, and Stata | Template-level comparison for biomedical figure styles |
| Public documentation and scheme defaults | Stata s2color, MATLAB R2014b+ colour order/parula, software manuals, and reference package behaviour | Palette, grid, tick, font, and legend defaults where screenshots were incomplete |

## Per-Style Verification Summary

| Style | Evidence status | Key confirmed elements | Main remaining limitation |
|---|---|---|---|
| Prism | Screenshot verified | White background, black frame, outward ticks, Prism-like bar and boxplot layout | Does not claim pixel-perfect Prism project export |
| SPSS | Screenshot verified | Light grey grid, black frame, blue-dominant palette, bar/boxplot defaults | SPSS versions differ; implementation targets classic output rather than every modern chart theme |
| MATLAB | Screenshot verified | R2014b+ colour order, full outer box, inward ticks, bar/boxplot behaviour | Continuous parula scale is keypoint interpolation rather than MathWorks' internal algorithm |
| Stata s2color | Template screenshot checked + documentation inferred | Light bluish background, horizontal grid emphasis, s2color-style palette | Stata 18+ defaults changed from s2color to stcolor |
| OriginPro | Template screenshot checked + documentation inferred | Classic black-red-green-blue palette, white background, boxed graph region | Origin themes vary substantially by version and template |
| SigmaPlot | Template screenshot checked + documentation inferred | Conservative grayscale/B&W appearance and boxed scientific graph layout | Screenshot coverage is limited to selected examples |
| JMP | Template screenshot checked + documentation inferred | Clean axes, minimal frame, JMP-like palette and marker defaults | JMP Graph Builder settings are user-configurable and version-dependent |
| Minitab | Template screenshot checked + documentation inferred | Light grey background, dark-blue accent styling, quality-control style cues | Minitab graph preferences can be changed globally |
| MedCalc | Template screenshot checked + documentation inferred | Clinical plot orientation, inside-plot legend style, high-contrast palette | MedCalc is strongest for ROC/diagnostic plots; general ggplot geoms are approximations |
| Academic | Internal benchmark | Minimal grayscale, publication-safe axes, print-friendly palette | Not a software default; included as a publication-oriented fallback |

## Critical Corrections Incorporated

1. Prism ticks are outward in the inspected screenshots; the Prism theme uses negative tick length to reflect this.
2. SPSS includes a light grey grid in the inspected output; the SPSS theme now includes subtle major grid lines.
3. MATLAB default plots include a full outer box in the inspected output; the MATLAB theme now uses a black outer frame.
4. The manuscript describes the package as covering nine software-derived styles plus one academic publication style, avoiding the claim that Academic is commercial software.

## Recommended Future Validation

1. Archive side-by-side comparison panels for every style and plot type used in the paper.
2. Add visual regression tests for representative bar, boxplot, scatter, density, heatmap, and survival plots.
3. Report quantitative visual fidelity only after a formal perceptual or image-similarity study; until then, use "emulate" rather than "reproduce exactly".
