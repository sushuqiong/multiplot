# ggmultiplot: A Unified Framework and R Implementation for Reproducing Biomedical Statistical Plot Styles Across Ten Major Graphing Software Packages

## Abstract

**Background**: Biomedical researchers routinely switch between statistical graphing
software (GraphPad Prism, SPSS, OriginPro, Stata, MATLAB, etc.), each with a
distinctive default visual style. When publishing, the absence of a unified method
to replicate these styles programmatically creates friction: plots generated in R
may be rejected by reviewers accustomed to specific software aesthetics, and manual
re-styling per target journal is inefficient.

**Results**: We present (1) a formal Plot Style Ontology that decomposes any
statistical graphing software's default output into a 5-tuple of
{Theme, Palette, Geom, Annotation, Convention} dimensions; (2) a systematic
compliance assessment of ten software default palettes across colour vision
deficiency (CVD) safety, grayscale print fidelity, and CMYK gamut compatibility;
and (3) **ggmultiplot**, an open-source R package implementing the ontology as a
ggplot2 extension. A single `ggchoice("prism")` call applies the complete visual
style of the target software. The package exports 18 functions, requires only
ggplot2 (≥3.4.0), and passes R CMD check with zero errors or warnings.

**Conclusions**: ggmultiplot fills a gap between general-purpose ggplot2 theme
packages and single-software emulators, providing the first unified framework
for cross-software plot style reproduction with built-in publication compliance
guidance. The formal ontology and compliance benchmark are reusable beyond the
R ecosystem.

**Keywords**: data visualization, ggplot2, R package, statistical graphics,
GraphPad Prism, SPSS, colour vision deficiency, reproducible research

---

## 1. Introduction

Biomedical and life-science researchers produce statistical graphs using a
heterogeneous mix of software: GraphPad Prism for dose-response curves, SPSS
for survey-weighted bar charts, OriginPro for multi-panel scientific figures,
Stata for econometric-style regressions, MATLAB for engineering visualizations,
and MedCalc for diagnostic ROC analysis [1-4]. Each software ships with a
distinctive default visual style—a specific combination of background colour,
grid line presence, font family, axis formatting, and colour palette—that becomes
deeply familiar to its user community.

This fragmentation creates two problems. First, **reviewer expectation**:
manuscript reviewers accustomed to one software's visual conventions may perceive
plots generated with a different tool as "unfamiliar" or "unpolished," even when
statistically identical [5]. Second, **reproducibility friction**: a
computationally reproducible analysis pipeline (e.g., in R) produces output that
may not match the visual style expected by a target journal or co-author using a
different primary software [6].

Existing R packages address parts of this problem. **ggprism** [7] provides
GraphPad Prism-inspired themes and palettes for ggplot2 but covers only one
software. **r2spss** [8] replicates SPSS output formatting, including legacy and
modern SPSS graph styles, but is similarly single-software. **ggthemes** [9]
offers themes inspired by publications (The Economist, Wall Street Journal) and
software (Stata, Excel) but prioritises aesthetic variety over fidelity to
software defaults. **cowplot** [10] provides a clean publication-ready default
theme but makes no attempt to emulate specific software. None of these packages
provide (a) multi-software coverage, (b) a formal framework for reasoning about
plot style differences, or (c) systematic guidance on which default styles meet
publication accessibility standards.

Here we introduce **ggmultiplot**, an R package that addresses all three gaps.
Its contributions are:

1. A **Plot Style Ontology** that formalises any graphing software's default
   visual output as a 5-tuple of {Theme, Palette, Geom, Annotation, Convention};
2. A single-function entry point, `ggchoice("style")`, that applies the complete
   style (theme + colour scale + fill scale) of ten major statistical graphing
   software packages;
3. A systematic **compliance assessment** of each software's default palette
   against CVD safety, grayscale print fidelity, and CMYK gamut compatibility,
   providing actionable guidance for journal submission.

---

## 2. Methods

### 2.1 Plot Style Ontology

We formalise a plotting software's default visual style as a 5-tuple:

$$Style_X = \{Theme_X, Palette_X, Geom_X, Annotation_X, Convention_X\}$$

where each component is defined as follows:

| Component | Definition | Dimensions |
|---|---|---|
| **Theme** ($T$) | Canvas-level visual parameters independent of data | Background fill, grid major/minor presence/colour/width, panel border style, axis line style, tick direction/length, font family, title face/size, legend position/border, facet strip style |
| **Palette** ($P$) | Default colour-mapping strategy | Palette type (qualitative/sequential/diverging), number of colours, hex values, CVD safety profile |
| **Geom** ($G$) | Default geometric object rendering | Default bar fill colour, line colour/width, point shape/size, error bar style |
| **Annotation** ($A$) | Default statistical annotation conventions | Significance notation format (P values vs. stars), reference line style, AUC annotation placement |
| **Convention** ($C$) | Software-specific layout conventions | Default aspect ratio, y-axis range start, axis label orientation, multi-panel strategy |

This decomposition is deliberately minimalist: each dimension is directly
observable from the software's default output and independently implementable
in ggplot2 without modifying its internal rendering pipeline.

### 2.2 Software Selection and Style Extraction

We selected ten software packages covering the most commonly used statistical
graphing tools in biomedical research [1,2]:

1. GraphPad Prism (v8+)
2. IBM SPSS Statistics (v12–24 classic default)
3. OriginPro (classic default; OriginLab)
4. Stata (s2color scheme, factory default pre-v18)
5. Academic/AMS (generic journal submission style)
6. SigmaPlot (v8.0+; Systat Software)
7. JMP (v13+; SAS Institute)
8. MATLAB (R2014b+ default; MathWorks)
9. Minitab (v17+; Minitab LLC)
10. MedCalc (v20+; MedCalc Software)

For each software, we extracted the default visual parameters from:
- Official software documentation and user guides;
- Default scheme/theme definition files (e.g., Stata's `scheme-s2color.scheme`,
  MATLAB's `ColorOrder` defaults);
- Direct software output inspection: real screenshots of default bar and box
  plots were obtained from GraphPad Prism 8, IBM SPSS Statistics 24, and
  MATLAB R2014b+, and compared side-by-side with ggmultiplot output. Three
  discrepancies were identified and corrected (Prism tick direction, SPSS grid
  presence, MATLAB outer frame);
- Published descriptions in the methodology literature [3,4,11].

The full ontology mapping is provided in **Table 1** (see Supplementary
Materials).

### 2.3 Implementation in R

The ggmultiplot R package implements the ontology on top of ggplot2 (≥3.4.0).
The architecture follows a layered design:

- **10 internal `theme_xxx()` functions** — each inherits from `theme_bw()` or
  `theme_classic()` and overrides grid, border, font, legend, and strip
  parameters to match the target software's defaults.
- **20 internal discrete `scale_color/fill_xxx()` functions** — each defines a
  qualitative palette of 10 hex colours extracted from the software's default
  colour order.
- **14 exported continuous `scale_color/fill_xxx_c()` functions** — each wraps
  `ggplot2::scale_color_gradientn()` with a software-specific continuous
  gradient (e.g., MATLAB's parula, Origin's BlueGreenYellow).
- **1 exported `ggchoice()` function** — the main entry point. Calling
  `ggchoice("prism")` returns a list of `theme_prism() + scale_color_prism() +
  scale_fill_prism()`. Scales are applied additively: user-supplied
  `scale_*()` calls added *after* `ggchoice()` take priority (ggplot2's
  "later-wins" semantics).
- **1 exported `geom_errorbar_prism()`** — a wrapper around
  `ggplot2::geom_errorbar()` with Prism-style cap width and line weight defaults.
- **1 exported `geom_col_prism()`** — a wrapper around `ggplot2::geom_col()`
  with Prism-style defaults (solid fill, thin black border, compact width).
- **1 exported `stat_compare_means_prism()`** — wraps `ggpubr::stat_compare_means()`
  with Prism-style p-value formatting (P < 0.0001 cutoff, significance stars).

All themes and scales are internal (not exported), keeping the user-facing API
to 17 exported functions. The package has zero compiled code and imports only
ggplot2. The `stat_compare_means_prism()` function soft-depends on ggpubr
(loaded on first use).

### 2.4 Compliance Assessment Methodology

We assessed each software's default discrete palette across three dimensions:

**CVD Safety.** Each palette was simulated under three colour vision deficiency
types using the methodology of [12]: deuteranopia (M-cone loss, ~6% male
prevalence), protanopia (L-cone loss, ~2%), and tritanopia (S-cone loss,
<0.01%). A palette was scored 5 if all colours remain distinguishable across
all three types; 3 if ≥3 colours remain distinguishable; 1 if red-green
confusion renders ≥2 pairs indistinguishable.

**Grayscale Print Fidelity.** CIELAB L* (lightness) values were computed for
each hex colour (D65 illuminant, 2° observer). A palette was scored 5 if ≥5
distinct L* levels span the 0–100 range; 3 if 3–4 levels; 1 if ≤2 levels.

**CMYK Gamut Compatibility.** ΔE (CIEDE2000) between sRGB and ISO Coated v2
(FOGRA39) CMYK profile was computed for each colour. A palette was scored 5
if all colours are within ΔE < 3; 3 if 1–2 colours exceed ΔE > 5; 1 if ≥3
colours are substantially out-of-gamut (ΔE > 8).

All colour computations were performed using the `colorspace` [13] and
`farver` [14] R packages.

### 2.5 Comparison with Existing Packages

| Feature | ggmultiplot | ggprism | r2spss | ggthemes | cowplot |
|---|---|---|---|---|---|
| Multi-software coverage | **10** | 1 (Prism) | 1 (SPSS) | ~8 themes† | 1 (generic) |
| Formal style ontology | **Yes** | No | No | No | No |
| Compliance assessment | **Yes** | No | No | No | No |
| Single-function style switch | **Yes** | Partial‡ | Partial‡ | Partial‡ | N/A |
| Continuous colour scales | **Yes (14)** | No | No | Limited | No |
| Prism-specific geoms | **Yes** | Yes | N/A | No | No |
| Vignette with style comparison | **Yes (10 styles)** | No | No | No | No |

† Includes Stata, Excel, Economist, WSJ, FiveThirtyEight, etc. — not all are
scientific graphing software.
‡ Requires separate `theme_xxx()` + `scale_xxx()` calls.

---

## 3. Results

### 3.1 Ontology Mapping

The complete ontology mapping is presented in Table 1 (Supplementary Materials).
Key findings from the cross-software comparison:

- **Grid usage**: 4/10 software default to grid OFF (Prism, OriginPro, JMP,
  MATLAB); 4/10 use light grids (SPSS, Stata, SigmaPlot, MedCalc); 2/10 use
  distinctive grid patterns (Minitab white-on-grey, Academic none).
- **Frame**: 8/10 use a full box border; 2/10 use axes-only (Academic, JMP).
- **Font**: 10/10 default to sans-serif (Arial/Helvetica variants). No major
  statistical graphing software defaults to a serif font for chart elements.
- **Legend**: 5/10 place right; 2/10 place bottom; MedCalc places inside the
  plot area.
- **Palette strategy**: 5/10 use qualitative colour cycles; 1/10 uses grayscale;
  1/10 uses B&W-then-grayscale.

The formalisation reveals that no two software packages share an identical
5-tuple, confirming that each software's "look" is a genuinely distinctive
combination rather than minor variation around a common template.

### 3.2 Compliance Assessment

The full compliance scores are presented in Table 2 (Supplementary Materials).
Key findings:

| Software | CVD | Grayscale | CMYK | Overall |
|---|---|---|---|---|
| Academic | 5.0 | 5.0 | 5.0 | **5.0** |
| SigmaPlot | 5.0 | 5.0 | 5.0 | **5.0** |
| MATLAB (R2014b+) | 3.0 | 4.0 | 4.0 | **3.7** |
| Prism | 3.0 | 3.0 | 4.0 | **3.3** |
| SPSS, Stata, JMP, Minitab, MedCalc | 2.0 | 3.0 | 4.0 | **3.0** |
| OriginPro | 1.0 | 2.0 | 2.0 | **1.7** |

The most common failure mode is red-green colour pair confusability
(deuteranopia/protanopia), affecting 8/10 software default palettes. Only
grayscale-based defaults (Academic, SigmaPlot) are fully CVD-safe. Notably,
MATLAB R2014b+ deliberately improved CVD accessibility (3.0 vs. the older
jet-based default which would score 1.0), demonstrating that software
vendors are beginning to address this issue.

### 3.3 Use Case: Cross-Style Comparison of the Same Data

As a demonstration, the same boxplot of highway fuel economy by vehicle class
(mpg dataset) was rendered in all 10 styles. The visual differences are
substantial despite identical underlying data:

- **Prism** and **SPSS** produce the most "traditional biomedical" appearance
  (clean white backgrounds, no grid, box borders);
- **Stata** and **Minitab** have the most distinctive backgrounds (light bluish
  tint and grey, respectively), making them immediately recognisable to users
  familiar with those packages;
- **MATLAB** and **JMP** produce the most minimal, modern appearance (no outer
  frame, sparse annotation);
- **Academic** and **SigmaPlot** produce the most conservative output, suitable
  for journals with strict figure guidelines.

This demonstrates the ontology's practical value: a researcher can produce a
Prism-style plot for a pharmacology co-author, an SPSS-style plot for a
psychology reviewer, and an Academic-style plot for final journal submission—
all from the same R script, without manually adjusting individual theme
parameters.

---

## 4. Discussion

### 4.1 Contribution

ggmultiplot is, to our knowledge, the first R package to provide both
multi-software coverage and a formal ontology for reasoning about statistical
plot styles. Its three contributions—ontology, implementation, and compliance
benchmark—are mutually reinforcing: the ontology provides the vocabulary for
describing differences; the implementation demonstrates that these differences
are mechanically reproducible; and the compliance benchmark reveals which
defaults are fit for purpose in accessible, print-ready publication.

### 4.2 Design Rationale

We chose to make theme and scale functions internal (not exported) with
`ggchoice()` as the single user-facing entry point. This design reflects a
philosophical position: the unit of "style" is the *combination* of theme +
palette, not either in isolation. Exporting `theme_prism()` without its
corresponding palette would invite users to produce Prism-themed plots with
ggplot2's default hue wheel—defeating the purpose of style reproduction.

The additive-scale strategy (user scales override ggmultiplot scales) preserves
ggplot2's composability while providing sensible defaults. This differs from
ggprism, which exports separate `theme_prism()` and `scale_fill_prism()`
functions requiring explicit coordination by the user.

### 4.3 Limitations

1. **Fidelity**: Theme parameters were verified against real screenshots for
   Prism, SPSS, and MATLAB (3/10 software), with three discrepancies corrected
   (Prism tick direction outward, SPSS light grey grid present, MATLAB outer
   box present). The remaining 7/10 software rely on documentation and scheme
   file extraction. A formal perceptual fidelity study with human raters and
   quantitative ΔE colour difference metrics is planned.
2. **Software versioning**: Software defaults evolve (e.g., SPSS 25+ modern
   charts, Stata 18's `stcolor` replacing `s2color`). We target the most widely
   recognisable defaults for each software; future work should track version
   changes.
3. **Continuous palettes**: Our continuous colour scales use fixed keypoint
   interpolation rather than the exact algorithmic colormaps used by the
   original software (e.g., MATLAB's parula is a piecewise Bézier curve; we
   approximate with 9 keypoints).
4. **3D and interactive plots**: ggmultiplot covers only 2D static ggplot2
   output. Interactive features (JMP's hover tooltips, Prism's linked analyses)
   are out of scope.

### 4.4 Future Work

- Formal perceptual fidelity study with human raters (N ≥ 20) comparing
  ggmultiplot output to real software screenshots;
- Support for additional software (e.g., SAS, RStudio default, Python
  matplotlib/seaborn);
- Shiny gadget for interactive style preview and on-the-fly switching;
- Journal-specific templates (Nature, Cell, Science, The Lancet) built on the
  Academic base with journal-specific font and dimension requirements;
- Extension to Python (matplotlib-based `ggchoice()` equivalent).

---

## 5. Availability

- **Package**: ggmultiplot v0.1.0
- **Language**: R (≥4.0)
- **License**: MIT
- **Dependencies**: ggplot2 (≥3.4.0); ggpubr (optional, for `stat_compare_means_prism()`)
- **Source code**: https://github.com/sushuqiong/multiplot
- **Documentation**: Vignette included (`vignette("ggmultiplot")`)
- **Supplementary Materials**: Table 1 (Plot Style Ontology), Table 2 (Compliance Assessment) included in `inst/paper/`

---

## References

1. Weissgerber TL, Milic NM, Winham SJ, Garovic VD. Beyond bar and line graphs:
   time for a new data presentation paradigm. *PLoS Biol*. 2015;13(4):e1002128.
2. Rougier NP, Droettboom M, Bourne PE. Ten simple rules for better figures.
   *PLoS Comput Biol*. 2014;10(9):e1003833.
3. Crameri F, Shephard GE, Heron PJ. The misuse of colour in science
   communication. *Nat Commun*. 2020;11(1):5444.
4. Stauffer R, Mayr GJ, Dabernig M, Zeileis A. Somewhere over the rainbow: How
   to make effective use of colors in meteorological visualizations. *Bull Am
   Meteorol Soc*. 2015;96(2):203-216.
5. Weissgerber TL, Winham SJ, Heinzen EP, et al. Reveal, don't conceal:
   transforming data visualization to improve transparency. *Circulation*.
   2019;140(18):1506-1518.
6. Peng RD. Reproducible research in computational science. *Science*.
   2011;334(6060):1226-1227.
7. Dawson C. ggprism: A 'ggplot2' Extension Inspired by 'GraphPad Prism'.
   R package version 1.0.7. 2025. doi:10.32614/CRAN.package.ggprism.
8. Alfons A. r2spss: Format R Output to Look Like SPSS. R package version 0.3.2.
   2022. https://CRAN.R-project.org/package=r2spss.
9. Arnold JB. ggthemes: Extra Themes, Scales and Geoms for 'ggplot2'. R package
   version 5.1.0. 2024. https://CRAN.R-project.org/package=ggthemes.
10. Wilke CO. cowplot: Streamlined Plot Theme and Plot Annotations for 'ggplot2'.
    R package version 1.2.0. 2025. https://wilkelab.org/cowplot/.
11. Schloss KB, Lessard L, Walmsley CS, Foley K. Color inference in visual
    communication: the meaning of colors in recycling. *Cogn Res Princ Implic*.
    2018;3(1):5.
12. Birch J. Worldwide prevalence of red-green color deficiency. *J Opt Soc Am
    A*. 2012;29(3):313-320.
13. Zeileis A, Fisher JC, Hornik K, et al. colorspace: A toolbox for manipulating
    and assessing colors and palettes. *J Stat Softw*. 2020;96(1):1-49.
14. Pedersen TL, Nicolae B, François R. farver: High performance colour space
    manipulation. R package version 2.1.2. 2024. https://CRAN.R-project.org/package=farver.


---

## Supplementary Materials

### Table 1 — Plot Style Ontology
See `inst/paper/table1_style_ontology.md` for the complete 10-software ×
15-attribute mapping across all five ontology dimensions.

### Table 2 — Compliance Assessment
See `inst/paper/table2_compliance_assessment.md` for the full CVD safety,
grayscale fidelity, and CMYK compatibility evaluation with CIELAB L* values
and per-colour gamut analysis.
