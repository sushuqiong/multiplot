# Internal theme functions for each software style.
# Called by ggchoice(), not exported to the user.

# ---- GraphPad Prism ----
# White background, no grid, black box border + axis lines, sans-serif (Arial) font,
# bold title. Bars: solid colour with thin black border. Ticks: outward.
# Ref: Prism 8+ default; cross-referenced with ggprism and real screenshot.
theme_prism <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = "black", linewidth = 0.5),
      axis.line          = ggplot2::element_line(color = "black", linewidth = 0.5),
      axis.ticks         = ggplot2::element_line(color = "black", linewidth = 0.5),
      axis.ticks.length  = ggplot2::unit(-2.5, "mm"),
      legend.key         = ggplot2::element_blank(),
      legend.title       = ggplot2::element_text(size = base_size - 1, face = "bold"),
      strip.background   = ggplot2::element_rect(fill = "grey90", color = NA),
      strip.text         = ggplot2::element_text(face = "bold", size = base_size - 1),
      plot.title         = ggplot2::element_text(face = "bold", size = base_size + 2),
      plot.subtitle      = ggplot2::element_text(size = base_size)
    )
  )
}

# ---- SPSS (default output, v12-24 classic) ----
# White bg, light grey grid, box border, sans-serif (Arial) font, blue-dominant
# bars with black outline. Ref: SPSS 12–24 default chart; IBM documentation
# and real screenshot verification.
theme_spss <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_classic(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_line(color = "grey90", linewidth = 0.3),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = "black", linewidth = 0.6),
      axis.line          = ggplot2::element_line(color = "black", linewidth = 0.6),
      axis.ticks         = ggplot2::element_line(color = "black", linewidth = 0.5),
      axis.ticks.length  = ggplot2::unit(2.5, "mm"),
      legend.position    = "right",
      legend.key         = ggplot2::element_blank(),
      legend.title       = ggplot2::element_text(face = "bold", size = base_size),
      strip.background   = ggplot2::element_rect(fill = "grey85", color = "black", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(face = "bold", size = base_size + 2, hjust = 0.5),
      plot.subtitle      = ggplot2::element_text(size = base_size, hjust = 0.5)
    )
  )
}

# ---- OriginPro (classic default) ----
# Classic palette: Black→Red→Green→Blue increment.
# White background, grid OFF, black axes with OUTWARD ticks, visible layer frame.
theme_origin <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = "black", linewidth = 0.5),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = "black", linewidth = 0.5),
      axis.ticks.length  = ggplot2::unit(-3, "mm"),
      legend.background  = ggplot2::element_rect(fill = "white", color = "black", linewidth = 0.3),
      legend.key         = ggplot2::element_blank(),
      legend.title       = ggplot2::element_text(face = "bold", size = base_size),
      strip.background   = ggplot2::element_rect(fill = "grey95", color = "grey70", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(face = "bold", size = base_size + 2),
      plot.subtitle      = ggplot2::element_text(size = base_size)
    )
  )
}

# ---- Stata s2color (factory default prior to Stata 18) ----
# Light bluish-tinted background (not pure white), 15-colour palette,
# bluish grid lines slightly thicker than axis lines.
# Ref: scheme-s2color.scheme; background tint ≈ #EAF2F8.
theme_stata <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.background  = ggplot2::element_rect(fill = "#F4F7FA"),
      panel.grid.major   = ggplot2::element_line(color = "#D5E3F0", linewidth = 0.25),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = "grey50", linewidth = 0.3),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = "grey40", linewidth = 0.3),
      axis.ticks.length  = ggplot2::unit(2.5, "mm"),
      legend.key         = ggplot2::element_rect(fill = "#F4F7FA", color = NA),
      legend.title       = ggplot2::element_text(size = base_size - 1),
      legend.background  = ggplot2::element_rect(fill = "white", color = NA),
      strip.background   = ggplot2::element_rect(fill = "white", color = "grey80", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 1, face = "plain"),
      plot.subtitle      = ggplot2::element_text(size = base_size - 1)
    )
  )
}

# ---- Academic (AMS / Science) ----
# Minimal B&W, no grid, thin axis lines, bottom legend, clean typography.
theme_academic <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_classic(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_blank(),
      axis.line          = ggplot2::element_line(color = "black", linewidth = 0.4),
      axis.ticks         = ggplot2::element_line(color = "black", linewidth = 0.4),
      axis.ticks.length  = ggplot2::unit(2, "mm"),
      legend.key         = ggplot2::element_blank(),
      legend.position    = "bottom",
      legend.title       = ggplot2::element_text(size = base_size),
      strip.background   = ggplot2::element_blank(),
      strip.text         = ggplot2::element_text(face = "bold", size = base_size),
      plot.title         = ggplot2::element_text(size = base_size + 2, face = "plain"),
      plot.subtitle      = ggplot2::element_text(size = base_size)
    )
  )
}

# ---- SigmaPlot ----
# Single series: black fill/line. Multi-series: grayscale.
# White background, NO grid, black box frame, circle markers.
theme_sigmaplot <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = "black", linewidth = 0.5),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = "black", linewidth = 0.4),
      axis.ticks.length  = ggplot2::unit(2.5, "mm"),
      legend.key         = ggplot2::element_blank(),
      legend.background  = ggplot2::element_rect(fill = "white", color = "black", linewidth = 0.3),
      legend.title       = ggplot2::element_text(face = "bold", size = base_size),
      strip.background   = ggplot2::element_rect(fill = "grey95", color = "grey60", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(face = "plain", size = base_size + 1),
      plot.subtitle      = ggplot2::element_text(size = base_size - 1)
    )
  )
}

# ---- JMP ----
# No grid lines (default off), no outer frame border, tick marks outside.
# Frame borders shown on axes only. Solid fills, clean interactive feel.
# Ref: JMP Preferences → Graphs → major/minor grid deselected by default.
theme_jmp <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_classic(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_blank(),
      axis.line          = ggplot2::element_line(color = "grey50", linewidth = 0.4),
      axis.ticks         = ggplot2::element_line(color = "grey50", linewidth = 0.3),
      axis.ticks.length  = ggplot2::unit(2.5, "mm"),
      legend.key         = ggplot2::element_rect(fill = "white", color = NA),
      legend.background  = ggplot2::element_rect(fill = "white", color = "grey80", linewidth = 0.3),
      legend.position    = "bottom",
      legend.title       = ggplot2::element_text(size = base_size),
      strip.background   = ggplot2::element_rect(fill = "grey95", color = "grey75", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 2, face = "bold", hjust = 0.5),
      plot.subtitle      = ggplot2::element_text(size = base_size, hjust = 0.5)
    )
  )
}

# ---- MATLAB R2014b+ ----
# Outer box frame present, internal axes. 7-colour order (parula-like).
# Ref: MATLAB R2014b+ default bar/plot output; real screenshot verified.
theme_matlab <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = "black", linewidth = 0.5),
      axis.line          = ggplot2::element_line(color = "black", linewidth = 0.5),
      axis.ticks         = ggplot2::element_line(color = "black", linewidth = 0.5),
      axis.ticks.length  = ggplot2::unit(3, "mm"),
      legend.key         = ggplot2::element_blank(),
      legend.background  = ggplot2::element_rect(fill = "white", color = NA),
      legend.position    = "right",
      legend.title       = ggplot2::element_text(size = base_size),
      strip.background   = ggplot2::element_rect(fill = "grey90", color = NA),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 1, face = "plain"),
      plot.subtitle      = ggplot2::element_text(size = base_size - 1)
    )
  )
}

# ---- Minitab ----
# Light grey background (#F5F5F5), dark blue frame lines (#1F497D),
# NO grid, title black, solid fill.
theme_minitab <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.background  = ggplot2::element_rect(fill = "#F5F5F5"),
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = "#1F497D", linewidth = 0.4),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = "#1F497D", linewidth = 0.3),
      axis.ticks.length  = ggplot2::unit(2.5, "mm"),
      legend.key         = ggplot2::element_rect(fill = "#F5F5F5", color = NA),
      legend.background  = ggplot2::element_rect(fill = "white", color = "#1F497D", linewidth = 0.3),
      legend.title       = ggplot2::element_text(size = base_size, face = "bold"),
      strip.background   = ggplot2::element_rect(fill = "#1F497D", color = NA),
      strip.text         = ggplot2::element_text(color = "white", face = "bold", size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 2, face = "bold", color = "black"),
      plot.subtitle      = ggplot2::element_text(size = base_size)
    )
  )
}

# ---- MedCalc (ROC-optimised) ----
# Square plot area, 50%-grey diagonal reference line, clean clinical aesthetic,
# AUC annotation position in lower-right legend.
theme_medcalc <- function(base_size = 12, base_family = "sans") {
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_line(color = "grey85", linewidth = 0.25),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = "black", linewidth = 0.5),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = "black", linewidth = 0.4),
      axis.ticks.length  = ggplot2::unit(2, "mm"),
      legend.key         = ggplot2::element_blank(),
      legend.position    = c(0.78, 0.22),
      legend.background  = ggplot2::element_rect(fill = "white", color = "black", linewidth = 0.3),
      legend.title       = ggplot2::element_text(size = base_size - 1),
      strip.background   = ggplot2::element_rect(fill = "grey90", color = "grey50", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 1, face = "plain"),
      plot.subtitle      = ggplot2::element_text(size = base_size - 1),
      aspect.ratio       = 1
    )
  )
}
