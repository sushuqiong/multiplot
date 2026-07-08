# Internal theme functions for each software style.
# Called by ggchoice(), not exported.
#
# Design principles (informed by ggprism):
#   - Colour tokens per theme (axis, axisTitle, axisLabel, title, tick)
#   - Tick length proportional to base_size (unit(base_size/2.5, "pt"))
#   - Axis text margins scaled from base_size
#   - Legend key sizing in relative units

# ---- GraphPad Prism ----
theme_prism <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "black", axisTitle = "black", axisLabel = "black",
              title = "black", tick = "black")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major    = ggplot2::element_blank(),
      panel.grid.minor    = ggplot2::element_blank(),
      panel.border        = ggplot2::element_rect(fill = NA, color = clr$axis, linewidth = 0.5),
      axis.line           = ggplot2::element_line(color = clr$axis, linewidth = 0.5),
      axis.ticks          = ggplot2::element_line(color = clr$tick, linewidth = 0.5),
      axis.ticks.length   = ggplot2::unit(-ts, "pt"),
      axis.text           = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x         = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y         = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title          = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.key          = ggplot2::element_blank(),
      legend.key.size     = ggplot2::unit(1.2, "lines"),
      legend.title        = ggplot2::element_text(size = base_size - 1, face = "bold"),
      strip.background    = ggplot2::element_rect(fill = "grey90", color = NA),
      strip.text          = ggplot2::element_text(face = "bold", size = base_size - 1),
      plot.title          = ggplot2::element_text(face = "bold", size = base_size + 2, color = clr$title),
      plot.subtitle       = ggplot2::element_text(size = base_size)
    )
  )
}

# ---- SPSS (v12-24 classic) ----
theme_spss <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "black", axisTitle = "black", axisLabel = "black",
              title = "black", tick = "black")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_classic(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major    = ggplot2::element_line(color = "grey90", linewidth = 0.3),
      panel.grid.minor    = ggplot2::element_blank(),
      panel.border        = ggplot2::element_rect(fill = NA, color = clr$axis, linewidth = 0.6),
      axis.line           = ggplot2::element_line(color = clr$axis, linewidth = 0.6),
      axis.ticks          = ggplot2::element_line(color = clr$tick, linewidth = 0.5),
      axis.ticks.length   = ggplot2::unit(ts, "pt"),
      axis.text           = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x         = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y         = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title          = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.position     = "right",
      legend.key          = ggplot2::element_blank(),
      legend.key.size     = ggplot2::unit(1.2, "lines"),
      legend.title        = ggplot2::element_text(face = "bold", size = base_size),
      strip.background    = ggplot2::element_rect(fill = "grey85", color = "black", linewidth = 0.3),
      strip.text          = ggplot2::element_text(size = base_size - 1),
      plot.title          = ggplot2::element_text(face = "bold", size = base_size + 2, hjust = 0.5, color = clr$title),
      plot.subtitle       = ggplot2::element_text(size = base_size, hjust = 0.5)
    )
  )
}

# ---- OriginPro (classic) ----
theme_origin <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "black", axisTitle = "black", axisLabel = "black",
              title = "black", tick = "black")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major    = ggplot2::element_blank(),
      panel.grid.minor    = ggplot2::element_blank(),
      panel.border        = ggplot2::element_rect(fill = NA, color = clr$axis, linewidth = 0.5),
      axis.line           = ggplot2::element_blank(),
      axis.ticks          = ggplot2::element_line(color = clr$tick, linewidth = 0.5),
      axis.ticks.length   = ggplot2::unit(-ts, "pt"),
      axis.text           = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x         = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y         = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title          = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.background   = ggplot2::element_rect(fill = "white", color = "black", linewidth = 0.3),
      legend.key          = ggplot2::element_blank(),
      legend.key.size     = ggplot2::unit(1.2, "lines"),
      legend.title        = ggplot2::element_text(face = "bold", size = base_size),
      strip.background    = ggplot2::element_rect(fill = "grey95", color = "grey70", linewidth = 0.3),
      strip.text          = ggplot2::element_text(size = base_size - 1),
      plot.title          = ggplot2::element_text(face = "bold", size = base_size + 2, color = clr$title),
      plot.subtitle       = ggplot2::element_text(size = base_size)
    )
  )
}

# ---- Stata s2color ----
theme_stata <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "grey50", axisTitle = "black", axisLabel = "grey40",
              title = "black", tick = "grey40")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.background   = ggplot2::element_rect(fill = "#F4F7FA"),
      panel.grid.major.y = ggplot2::element_line(color = "#D5E3F0", linewidth = 0.25),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = clr$axis, linewidth = 0.3),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = clr$tick, linewidth = 0.3),
      axis.ticks.length  = ggplot2::unit(ts, "pt"),
      axis.text          = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title         = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x       = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y       = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.position    = "bottom",
      legend.key         = ggplot2::element_rect(fill = "#F4F7FA", color = NA),
      legend.key.size    = ggplot2::unit(1.2, "lines"),
      legend.title       = ggplot2::element_text(size = base_size - 1),
      legend.background  = ggplot2::element_rect(fill = "white", color = NA),
      strip.background   = ggplot2::element_rect(fill = "white", color = "grey80", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 1, face = "plain", color = clr$title),
      plot.subtitle      = ggplot2::element_text(size = base_size - 1)
    )
  )
}

# ---- Academic (AMS / Science) ----
theme_academic <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "black", axisTitle = "black", axisLabel = "black",
              title = "black", tick = "black")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_classic(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_blank(),
      axis.line          = ggplot2::element_line(color = clr$axis, linewidth = 0.4),
      axis.ticks         = ggplot2::element_line(color = clr$tick, linewidth = 0.4),
      axis.ticks.length  = ggplot2::unit(ts, "pt"),
      axis.text          = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title         = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x       = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y       = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.key         = ggplot2::element_blank(),
      legend.key.size    = ggplot2::unit(1.2, "lines"),
      legend.position    = "bottom",
      legend.title       = ggplot2::element_text(size = base_size),
      strip.background   = ggplot2::element_blank(),
      strip.text         = ggplot2::element_text(face = "bold", size = base_size),
      plot.title         = ggplot2::element_text(size = base_size + 2, face = "plain", color = clr$title),
      plot.subtitle      = ggplot2::element_text(size = base_size)
    )
  )
}

# ---- SigmaPlot ----
theme_sigmaplot <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "black", axisTitle = "black", axisLabel = "black",
              title = "black", tick = "black")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = clr$axis, linewidth = 0.5),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = clr$tick, linewidth = 0.4),
      axis.ticks.length  = ggplot2::unit(ts, "pt"),
      axis.text          = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title         = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x       = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y       = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.key         = ggplot2::element_blank(),
      legend.key.size    = ggplot2::unit(1.2, "lines"),
      legend.background  = ggplot2::element_rect(fill = "white", color = "black", linewidth = 0.3),
      legend.title       = ggplot2::element_text(face = "bold", size = base_size),
      strip.background   = ggplot2::element_rect(fill = "grey95", color = "grey60", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(face = "plain", size = base_size + 1, color = clr$title),
      plot.subtitle      = ggplot2::element_text(size = base_size - 1)
    )
  )
}

# ---- JMP ----
theme_jmp <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "grey55", axisTitle = "black", axisLabel = "grey45",
              title = "black", tick = "grey55")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_classic(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_blank(),
      axis.line          = ggplot2::element_line(color = clr$axis, linewidth = 0.3),
      axis.ticks         = ggplot2::element_line(color = clr$tick, linewidth = 0.25),
      axis.ticks.length  = ggplot2::unit(-ts, "pt"),
      axis.text          = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title         = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x       = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y       = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.key         = ggplot2::element_rect(fill = "white", color = NA),
      legend.key.size    = ggplot2::unit(1.2, "lines"),
      legend.background  = ggplot2::element_rect(fill = "white", color = "grey80", linewidth = 0.3),
      legend.position    = "bottom",
      legend.title       = ggplot2::element_text(size = base_size - 1),
      legend.text        = ggplot2::element_text(size = base_size - 2),
      strip.background   = ggplot2::element_rect(fill = "grey95", color = "grey75", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 2, face = "bold", hjust = 0.5, color = clr$title),
      plot.subtitle      = ggplot2::element_text(size = base_size, hjust = 0.5)
    )
  )
}

# ---- MATLAB R2014b+ ----
theme_matlab <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "black", axisTitle = "black", axisLabel = "black",
              title = "black", tick = "black")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = clr$axis, linewidth = 0.5),
      axis.line          = ggplot2::element_line(color = clr$axis, linewidth = 0.5),
      axis.ticks         = ggplot2::element_line(color = clr$tick, linewidth = 0.5),
      axis.ticks.length  = ggplot2::unit(ts, "pt"),
      axis.text          = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title         = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x       = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y       = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.key         = ggplot2::element_blank(),
      legend.key.size    = ggplot2::unit(1.2, "lines"),
      legend.background  = ggplot2::element_rect(fill = "white", color = NA),
      legend.position    = "right",
      legend.title       = ggplot2::element_text(size = base_size),
      strip.background   = ggplot2::element_rect(fill = "grey90", color = NA),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 1, face = "plain", color = clr$title),
      plot.subtitle      = ggplot2::element_text(size = base_size - 1)
    )
  )
}

# ---- Minitab ----
theme_minitab <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "#1F497D", axisTitle = "#1F497D", axisLabel = "#1F497D",
              title = "black", tick = "#1F497D")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.background   = ggplot2::element_rect(fill = "#F5F5F5"),
      panel.grid.major   = ggplot2::element_blank(),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = clr$axis, linewidth = 0.4),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = clr$tick, linewidth = 0.3),
      axis.ticks.length  = ggplot2::unit(ts, "pt"),
      axis.text          = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title         = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x       = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y       = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.key         = ggplot2::element_rect(fill = "#F5F5F5", color = NA),
      legend.key.size    = ggplot2::unit(1.2, "lines"),
      legend.background  = ggplot2::element_rect(fill = "white", color = clr$axis, linewidth = 0.3),
      legend.title       = ggplot2::element_text(size = base_size, face = "bold"),
      strip.background   = ggplot2::element_rect(fill = clr$axis, color = NA),
      strip.text         = ggplot2::element_text(color = "white", face = "bold", size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 2, face = "bold", color = clr$title),
      plot.subtitle      = ggplot2::element_text(size = base_size)
    )
  )
}

# ---- MedCalc ----
theme_medcalc <- function(base_size = 12, base_family = "sans") {
  clr <- list(axis = "black", axisTitle = "black", axisLabel = "black",
              title = "black", tick = "black")
  ts  <- base_size / 2.5
  mgn <- base_size * 0.35
  ggplot2::`%+replace%`(
    ggplot2::theme_bw(base_size = base_size, base_family = base_family),
    ggplot2::theme(
      panel.grid.major   = ggplot2::element_line(color = "grey93", linewidth = 0.2),
      panel.grid.minor   = ggplot2::element_blank(),
      panel.border       = ggplot2::element_rect(fill = NA, color = clr$axis, linewidth = 0.5),
      axis.line          = ggplot2::element_blank(),
      axis.ticks         = ggplot2::element_line(color = clr$tick, linewidth = 0.4),
      axis.ticks.length  = ggplot2::unit(ts, "pt"),
      axis.text          = ggplot2::element_text(color = clr$axisLabel, size = base_size * 0.95),
      axis.text.x        = ggplot2::element_text(margin = ggplot2::margin(t = mgn)),
      axis.text.y        = ggplot2::element_text(margin = ggplot2::margin(r = mgn)),
      axis.title         = ggplot2::element_text(color = clr$axisTitle),
      axis.title.x       = ggplot2::element_text(margin = ggplot2::margin(t = mgn * 1.5)),
      axis.title.y       = ggplot2::element_text(margin = ggplot2::margin(r = mgn * 1.5)),
      legend.key         = ggplot2::element_blank(),
      legend.key.size    = ggplot2::unit(1.2, "lines"),
      legend.position    = c(0.78, 0.22),
      legend.background  = ggplot2::element_rect(fill = "white", color = "black", linewidth = 0.3),
      legend.title       = ggplot2::element_text(size = base_size - 1),
      strip.background   = ggplot2::element_rect(fill = "grey90", color = "grey50", linewidth = 0.3),
      strip.text         = ggplot2::element_text(size = base_size - 1),
      plot.title         = ggplot2::element_text(size = base_size + 1, face = "plain", color = clr$title),
      plot.subtitle      = ggplot2::element_text(size = base_size - 1)
    )
  )
}
