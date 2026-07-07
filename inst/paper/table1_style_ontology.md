# Table 1 — Plot Style Ontology: Formalised Mapping of 10 Supported Plot Styles

## Ontology Definition

A supported statistical plot style can be decomposed into a
5-tuple formalisation:

$$
\text{Style}_X = \{\text{Theme}_X,\ \text{Palette}_X,\ \text{Geom}_X,\ \text{Annotation}_X,\ \text{Convention}_X\}
$$

where:

| Component | Description | Dimensions |
|---|---|---|
| **Theme** | Canvas-level visual parameters | Background, grid, frame, axis, font, legend, strip |
| **Palette** | Default colour-mapping strategy | Type, colour count, hex values, CVD profile |
| **Geom** | Default geometric object rendering | Fill, line width, point shape/size, error bar style |
| **Annotation** | Default statistical annotation style | Significance notation, reference lines, label position |
| **Convention** | Software-specific layout conventions | Aspect ratio, legend placement, axis scaling defaults |

---

## Table 1a — Theme Ontology

| Style | Background | Grid Major | Grid Minor | Frame/Border | Axis Line | Tick Direction | Font Family | Title Style | Legend Position | Legend Border | Strip/Facet |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **Prism** | White `#FFFFFF` | Off | Off | Black box (0.5 pt) | On, black (0.5 pt) | **Outward** (2.5 mm) | Sans (Arial) | Bold, +2 pt | Right, no border | None | Grey90 fill, no border |
| **SPSS (12–24)** | White `#FFFFFF` | **On, grey90 (0.3 pt)** | Off | Black box (0.6 pt) | On, black (0.6 pt) | Inward (2.5 mm) | Sans (Arial) | Bold centred, +2 pt | Right, clean | None | Grey85 fill, black border |
| **OriginPro** | White `#FFFFFF` | Off | Off | Black box (0.5 pt) | Off (frame only) | Inward (3.0 mm) | Sans (Arial) | Bold, +2 pt | Right, boxed | Black (0.3 pt) | Grey95 fill, grey70 border |
| **Stata s2color** | Light blue tint `#F4F7FA` | Horizontal only, bluish `#D5E3F0` (0.25 pt) | Off | Thin grey (0.3 pt) | Off (frame only) | Inward (2.5 mm) | Sans | Plain, +1 pt | Bottom, no border | None | White fill, grey80 border |
| **Academic** | White `#FFFFFF` | Off | Off | Off (axes only) | On, black (0.4 pt) | Inward (2.0 mm) | Sans | Plain, +2 pt | Bottom, clean | None | Blank, bold text |
| **SigmaPlot** | White `#FFFFFF` | Off | Off | Black box (0.5 pt) | Off (frame only) | Inward (2.5 mm) | Sans (Arial) | Plain, +1 pt | Right, boxed | Black (0.3 pt) | Grey95 fill, grey60 border |
| **JMP** | White `#FFFFFF` | Off | Off | Off (axes only) | On, grey50 (0.4 pt) | Outward (2.5 mm) | Sans (Arial) | Bold centred, +2 pt | Bottom, thin border | Grey80 (0.3 pt) | Grey95 fill, grey75 border |
| **MATLAB (R2014b+)** | White `#FFFFFF` | Off | Off | **Black box (0.5 pt)** | On, black (0.5 pt) | Inward (3.0 mm) | Sans (Helvetica) | Plain, +1 pt | Right, no border | None | Grey90 fill, no border |
| **Minitab** | Light grey `#F5F5F5` | Off | Off | Dark blue box (0.4 pt) | Off (frame only) | Inward (2.5 mm) | Sans (Arial) | Bold, +2 pt, black | Right, boxed | Dark blue (0.3 pt) | Dark blue fill, white text |
| **MedCalc** | White `#FFFFFF` | Off | Off | Black box (0.5 pt) | Off (frame only) | Inward (2.0 mm) | Sans (Arial) | Plain, +1 pt | Inside plot (0.78, 0.22) | Black (0.3 pt) | Grey90 fill, grey50 border |

## Table 1b — Palette Ontology

| Style | Type | N Colours | Colour Strategy | Colour 1 | Colour 2 | Colour 3 | Colour 4 | Colour 5 | Source |
|---|---|---|---|---|---|---|---|---|---|
| **Prism** | Qualitative | 10 | Pastel-to-bold | `#5B9BD5` (blue) | `#ED7D31` (orange) | `#A5A5A5` (grey) | `#FFC000` (yellow) | `#4472C4` (dk blue) | Prism v8+ non-B&W schemes |
| **SPSS (12–24)** | Qualitative | 10 | Blue-dominant, low-saturation corporate | `#3E58AC` (SPSS blue) | `#6B6B7B` | `#4A7A6A` | `#8B7B5A` | `#5A5A7A` | SPSS legacy: all desaturated, L* 30-55, no rainbow |
| **OriginPro** | Qualitative | 10 | Black→Red→Green→Blue increment | `#000000` (black) | `#FF0000` (red) | `#008000` (green) | `#0000FF` (blue) | `#00FFFF` (cyan) | Origin classic default colour list |
| **Stata s2color** | Qualitative | 15 | Named colour cycle (navy, maroon, forest_green, …) | `#000080` (navy) | `#800000` (maroon) | `#228B22` (forest_green) | `#FF8C00` (dkorange) | `#008080` (teal) | scheme-s2color.scheme (Stata pre-18) |
| **Academic** | Qualitative | 10 | Grayscale | `#000000` (black) | `#525252` (dk grey) | `#969696` (mid grey) | `#BDBDBD` (lt grey) | `#D9D9D9` (v lt grey) | Academic publication convention |
| **SigmaPlot** | Qualitative | 10 | B&W to Grayscale | `#000000` (black) | `#595959` | `#8C8C8C` | `#BFBFBF` | `#D9D9D9` | SigmaPlot 8.0+ single-series default |
| **JMP** | Qualitative | 10 | Tableau-inspired categorical | `#1F77B4` (JMP blue) | `#FF7F0E` (orange) | `#2CA02C` (green) | `#D62728` (red) | `#9467BD` (purple) | JMP default categorical theme |
| **MATLAB (R2014b+)** | Qualitative | 7 | Parula-like muted spectrum | `#0072BD` (blue) | `#D95319` (orange) | `#EDB120` (yellow) | `#7E2F8E` (purple) | `#77AC30` (green) | R2014b new colour order (exact RGB from MathWorks) |
| **Minitab** | Qualitative | 10 | Dark blue primary + accent | `#1F497D` (dk blue) | `#C0504D` (red) | `#9BBB59` (olive) | `#8064A2` (purple) | `#4BACC6` (teal) | Minitab default bar/line palette |
| **MedCalc** | Qualitative | 10 | Clinical high-contrast | `#000000` (black) | `#E41A1C` (red) | `#377EB8` (blue) | `#4DAF4A` (green) | `#984EA3` (purple) | MedCalc ROC plot default palette |

## Table 1c — Geom & Annotation Defaults

| Style | Default Bar Fill | Default Line Colour | Default Point Shape | Error Bar Style | Sig. Notation | Reference Lines |
|---|---|---|---|---|---|---|
| **Prism** | Solid colour (palette[1]) | Black (axis), palette (data) | Square/scatter (auto) | T-bar, cap extends | P values + stars (****P<0.0001) | None by default |
| **SPSS** | Blue `#3E58AC`, solid, thin black border | Black (axis), palette (data) | Circle | Symmetric, cap lines | P values (numeric) | None by default |
| **OriginPro** | Black (series 1), solid | Black→Red→Green→Blue | Circle→Square→Diamond→Triangle | Cap lines, symmetric | P values in legend/annotation box | None by default |
| **Stata s2color** | Navy, solid | Navy→Maroon→Forest→… | Circle→Diamond→Square→Triangle | Cap lines, thin | P values (CI in text) | Grid lines as reference |
| **Academic** | Grey70, solid, no border | Black | Circle (open) | Thin cap lines | P values minimal | None |
| **SigmaPlot** | Light grey / black, solid | Black (single), greyscale (multi) | Circle (black fill) | Cap lines, symmetric, thin | SD/SEM default | None by default |
| **JMP** | JMP blue `#1F77B4`, solid | Palette cycle | Small dot | Cap lines | P values in hover/annotation | None by default |
| **MATLAB (R2014b+)** | Blue `#0072BD` (series 1) | Colour order cycle | None (line default), circle (scatter) | None by default (manual) | None by default | None (axes only, no box) |
| **Minitab** | Dark blue `#1F497D`, solid | Dark blue→Red→Olive→… | Round dot | Cap lines, symmetric | P values in session window | Pareto reference line |
| **MedCalc** | Black, solid | Black→Red→Blue→Green | Circle/dot | Cap lines | AUC + 95% CI annotation | 50%-grey diagonal (ROC) |

## Table 1d — Convention Dimensions

| Style | Default Aspect Ratio | Y-Axis Range Start | Axis Label Orientation | Multi-Panel Default | Key Design Principle |
|---|---|---|---|---|---|
| **Prism** | Auto (data-driven) | Auto (0 or data min) | Horizontal (Y), Horizontal (X) | Independent | Publication-ready out-of-box |
| **SPSS** | Auto, ~4:3 | Auto (0) | Vertical (Y), Horizontal (X) | Single | SPSS legacy consistency |
| **OriginPro** | Auto, ~4:3 | Auto (0 or data min) | Horizontal (Y), Horizontal (X) | Independent (multi-layer) | Layer-based scientific graphing |
| **Stata s2color** | Auto, ~4:3 | Auto (0) | Horizontal (Y), Horizontal (X) | Single or by() faceted | Econometric reproducibility |
| **Academic** | Auto | Auto | Horizontal (Y), Horizontal (X) | Single | Minimal decoration, data-forward |
| **SigmaPlot** | Auto, ~4:3 | Auto (0) | Horizontal (Y), Horizontal (X) | Single/overlay | Publication-quality export |
| **JMP** | Auto, ~3:2 | Auto (data min) | Horizontal (Y), Horizontal (X) | Single | Interactive exploration first |
| **MATLAB (R2014b+)** | Auto, ~4:3 | Auto (tight) | Horizontal (Y), Horizontal (X) | Subplot grid | Modern anti-aliased engineering |
| **Minitab** | Auto, ~4:3 | Auto (0) | Horizontal (Y), Horizontal (X) | Single | Quality-control oriented |
| **MedCalc** | **1:1 (square)** | 0 to 1 (ROC) | Horizontal (Y), Horizontal (X) | Single | Diagnostic test accuracy |

---

## Summary of Inter-Style Variation

- **Grid usage**: 7/10 supported styles do not show major grids (Prism, Origin, JMP, MATLAB, SigmaPlot, Minitab, Academic); 3/10 use light grids (SPSS, Stata, MedCalc)
- **Frame/border**: 8/10 use a full box border; 2/10 use axes-only (Academic, JMP)
- **Font**: 10/10 use sans-serif chart text in the implemented default style.
- **Legend position**: 5/10 place right; 2/10 place bottom; MedCalc places inside the plot area
- **Palette strategy**: 5/10 use qualitative colour cycles; 1/10 uses grayscale; 1/10 uses B&W-then-grayscale

_Data compiled from official software documentation, default scheme files, direct software output inspection, and the academic publication-style benchmark (see References)._
