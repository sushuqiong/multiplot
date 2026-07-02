# ggmultiplot

Reproduce the default statistical plot styles of 10 major graphing software
packages in R with **a single function call** — built on top of **ggplot2**.

```r
library(ggplot2)
library(ggmultiplot)

ggplot(mpg, aes(class, hwy)) +
  geom_boxplot(aes(fill = class)) +
  ggchoice("prism")   # one call = theme + colour + fill
```

## Why ggmultiplot?

Every statistical graphing software (GraphPad Prism, SPSS, OriginPro, Stata,
MATLAB, ...) has a distinctive default visual style. When you move between
software, your plots look different. When you publish in R, reviewers often
expect a specific "look."

`ggmultiplot` solves this by bundling each software's complete default style
into one function: **`ggchoice()`**.

## Supported Software Styles

| Software | `ggchoice()` | Key Visuals |
|---|---|---|
| **GraphPad Prism** | `"prism"` | White bg, no grid, black box, sans-serif, pastel colours |
| **SPSS** (v12–24) | `"spss"` | White bg, light grey grid, box border, blue-dominant, sans-serif |
| **OriginPro** (classic) | `"origin"` | White bg, no grid, Black→Red→Green→Blue palette |
| **Stata** (s2color) | `"stata"` | Light bluish tint, 15-colour s2color palette |
| **Academic** (AMS/Science) | `"academic"` | Minimal B&W, no decoration, journal-ready |
| **SigmaPlot** | `"sigmaplot"` | B&W default, light grid, boxed legend |
| **JMP** | `"jmp"` | No grid, no frame, tick marks outside, clean |
| **MATLAB** (R2014b+) | `"matlab"` | Black outer box, 7-colour R2014b order, inward ticks |
| **Minitab** | `"minitab"` | Grey bg, dark blue lines, white grid, blue strips |
| **MedCalc** (ROC) | `"medcalc"` | Square area, fine grey grid, clinical contrast |

## Installation

```r
# From GitHub
remotes::install_github("sushuqiong/multiplot")
```

## Quick Start

```r
library(ggplot2)
library(ggmultiplot)

p <- ggplot(mpg, aes(class, hwy)) + geom_boxplot(aes(fill = class))

# Switch style with one call
p + ggchoice("prism")     # GraphPad Prism look
p + ggchoice("spss")      # SPSS look
p + ggchoice("origin")    # OriginPro look
p + ggchoice("stata")     # Stata s2color look
p + ggchoice("matlab")    # MATLAB R2014b+ look
p + ggchoice()            # default theme_bw()
```

## Overriding scales

Scales are additive — user calls after `ggchoice()` take priority:

```r
ggplot(mpg, aes(class, hwy)) +
  geom_boxplot(aes(fill = class)) +
  ggchoice("prism") +
  scale_fill_brewer(palette = "Set2")   # your colour choice wins
```

## Prism-style features

**T-bar error bars + Prism-style columns:**
```r
df <- data.frame(group = c("A","B"), mean = c(10, 15), sd = c(2, 3))
ggplot(df, aes(group, mean)) +
  geom_col_prism(fill = "#5B9BD5") +
  geom_errorbar_prism(aes(ymin = mean - sd, ymax = mean + sd)) +
  ggchoice("prism")
```

**Statistical comparison annotations** (requires `ggpubr`):
```r
ggplot(ToothGrowth, aes(supp, len)) +
  geom_boxplot(aes(fill = supp)) +
  ggchoice("prism") +
  stat_compare_means_prism(comparisons = list(c("OJ", "VC")))
```

## Exported Functions

| Function | Description |
|---|---|
| `ggchoice(style)` | Apply a software's full visual style (theme + scales) |
| `geom_errorbar_prism()` | Prism-style T-bar error bars |
| `geom_col_prism()` | Prism-style column bars (solid fill, thin black border) |
| `stat_compare_means_prism()` | Prism-style significance annotations (wraps `ggpubr`) |
| `scale_color/fill_xxx()` | Discrete colour/fill scales for each software (overridable by user) |
| `scale_color/fill_xxx_c()` | Continuous colour/fill scales (heatmaps, surfaces, gradients) |

## Continuous Scales

For heatmaps and continuous data, append `_c` to the scale name:

```r
ggplot(volcano_df, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  ggchoice("matlab") +
  scale_fill_matlab_c()      # Parula-style continuous gradient
```

Available: `prism_c`, `origin_c`, `matlab_c`, `stata_c`, `academic_c`,
`minitab_c`, `medcalc_c` (14 functions).

## Design

- **Theme always applies, scales are overridable.** `ggchoice()` returns a
  list of `theme()` + `scale_color()` + `scale_fill()`. Because ggplot2's `+`
  is "later wins," any `scale_*()` you add *after* `ggchoice()` takes priority.
- **No ggplot2 internals modified.** All themes inherit from `theme_bw()` or
  `theme_classic()`. All scales use `discrete_scale()`. Safe to use with any
  ggplot2 extension.
- **Palettes researched from real software defaults** (see Style Reference
  table in the vignette).

## License

MIT — see [LICENSE](LICENSE) for details.
