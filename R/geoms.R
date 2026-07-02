#' Prism-style T-bar error bars
#'
#' A wrapper around \code{\link[ggplot2]{geom_errorbar}} with defaults
#' tuned to match GraphPad Prism's T-bar error bar appearance
#' (wider cap width and consistent line weight).
#'
#' @param mapping Set of aesthetic mappings created by \code{ggplot2::aes()}.
#' @param data The data to be displayed in this layer.
#' @param width Width of the error bar cap in native data units (default 0.3).
#' @param linewidth Line width in mm (default 0.5).
#' @param ... Other arguments passed to \code{\link[ggplot2]{geom_errorbar}}.
#' @export
#' @examples
#' library(ggplot2)
#' df <- data.frame(x = c("A", "B"), y = c(10, 15), sd = c(2, 3))
#' ggplot(df, aes(x, y)) +
#'   geom_col_prism(fill = "#5B9BD5", width = 0.6) +
#'   geom_errorbar_prism(aes(ymin = y - sd, ymax = y + sd))
geom_errorbar_prism <- function(mapping = NULL, data = NULL,
                                width = 0.3, linewidth = 0.5, ...) {
  ggplot2::geom_errorbar(mapping = mapping, data = data,
                         width = width, linewidth = linewidth, ...)
}

#' Prism-style column bars
#'
#' A wrapper around \code{\link[ggplot2]{geom_col}} with Prism defaults:
#' solid fill, thin black border, and compact bar width.
#'
#' @param mapping Set of aesthetic mappings created by \code{ggplot2::aes()}.
#' @param data The data to be displayed in this layer.
#' @param width Bar width (default 0.7).
#' @param color Border colour (default "black").
#' @param linewidth Border line width in mm (default 0.3).
#' @param ... Other arguments passed to \code{\link[ggplot2]{geom_col}}.
#' @export
#' @examples
#' library(ggplot2)
#' df <- data.frame(x = c("A", "B"), y = c(10, 15))
#' ggplot(df, aes(x, y)) +
#'   geom_col_prism(fill = "#5B9BD5") +
#'   ggchoice("prism")
geom_col_prism <- function(mapping = NULL, data = NULL, width = 0.7,
                           color = "black", linewidth = 0.3, ...) {
  ggplot2::geom_col(mapping = mapping, data = data,
                    width = width, color = color, linewidth = linewidth, ...)
}
