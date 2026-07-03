#' Apply a software-specific plot style
#'
#' One-stop function that applies the complete visual style of a target
#' graphing software to a ggplot2 plot.  Each style bundles a theme,
#' colour scale, and fill scale.  Scales are additive: user-supplied
#' scales added \emph{after} \code{ggchoice()} take priority.
#'
#' @param style Character string naming the target software.  Supported
#'   values: \code{"prism"}, \code{"spss"}, \code{"origin"}, \code{"stata"},
#'   \code{"academic"}, \code{"sigmaplot"}, \code{"jmp"}, \code{"matlab"},
#'   \code{"minitab"}, \code{"medcalc"}.  If missing or \code{"ggplot2"},
#'   returns \code{theme_bw()} (no scale change).
#' @param base_size Base font size in pts (default 12).
#' @param base_family Base font family.  All styles default to
#'   \code{"sans"} (Arial/Helvetica).
#' @param axis_offset If \code{TRUE}, apply axis offset expansion to create
#'   the characteristic Prism/SPSS axis separation gap.  Only effective for
#'   \code{"prism"} and \code{"spss"} styles; ignored for others.
#'   Default \code{FALSE}.
#' @param ... Ignored (reserved for future use).
#'
#' @return A list of ggplot2 theme + scale objects that can be added to a
#'   ggplot with \code{+}.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' # Prism-style boxplot
#' ggplot(mpg, aes(class, hwy)) +
#'   geom_boxplot(aes(fill = class)) +
#'   ggchoice("prism")
#'
#' # Override fill scale after ggchoice
#' ggplot(mpg, aes(class, hwy)) +
#'   geom_boxplot(aes(fill = class)) +
#'   ggchoice("prism") +
#'   scale_fill_brewer(palette = "Set2")
#'
#' # Default ggplot2
#' ggplot(mpg, aes(class, hwy)) +
#'   geom_boxplot(aes(fill = class)) +
#'   ggchoice()
#'
#' # Prism with axis offset: ggchoice("prism", axis_offset = TRUE)
ggchoice <- function(style = c("ggplot2", "prism", "spss", "origin", "stata",
                                "academic", "sigmaplot", "jmp", "matlab",
                                "minitab", "medcalc"),
                     base_size = 12, base_family = NULL,
                     axis_offset = FALSE, ...) {

  style <- match.arg(style)

  if (style == "ggplot2") {
    return(ggplot2::theme_bw(base_size = base_size))
  }

  if (is.null(base_family)) {
    base_family <- "sans"
  }

  theme_fn <- switch(style,
    prism       = theme_prism,
    spss        = theme_spss,
    origin      = theme_origin,
    stata       = theme_stata,
    academic    = theme_academic,
    sigmaplot   = theme_sigmaplot,
    jmp         = theme_jmp,
    matlab      = theme_matlab,
    minitab     = theme_minitab,
    medcalc     = theme_medcalc
  )

  scale_color_fn <- switch(style,
    prism       = scale_color_prism,
    spss        = scale_color_spss,
    origin      = scale_color_origin,
    stata       = scale_color_stata,
    academic    = scale_color_academic,
    sigmaplot   = scale_color_sigmaplot,
    jmp         = scale_color_jmp,
    matlab      = scale_color_matlab,
    minitab     = scale_color_minitab,
    medcalc     = scale_color_medcalc
  )

  scale_fill_fn <- switch(style,
    prism       = scale_fill_prism,
    spss        = scale_fill_spss,
    origin      = scale_fill_origin,
    stata       = scale_fill_stata,
    academic    = scale_fill_academic,
    sigmaplot   = scale_fill_sigmaplot,
    jmp         = scale_fill_jmp,
    matlab      = scale_fill_matlab,
    minitab     = scale_fill_minitab,
    medcalc     = scale_fill_medcalc
  )

  result <- list(
    theme_fn(base_size = base_size, base_family = base_family),
    scale_color_fn(),
    scale_fill_fn()
  )

  # Axis offset: Prism-style axis gap.  Adds expansion to continuous
  # axes so they don't touch at the origin.
  if (axis_offset && style %in% c("prism", "spss")) {
    result <- c(result, list(
      ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = c(0, 0.05))),
      ggplot2::scale_x_continuous(expand = ggplot2::expansion(mult = c(0, 0.05)))
    ))
  }

  result
}
