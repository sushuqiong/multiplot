# Continuous colour / fill scales for selected software.
# Each mimics the software's native continuous colormap (heatmap, surface,
# or contour default).

# ---- Palette definitions ----
prism_continuous   <- c("#4472C4", "#5B9BD5", "#A5A5A5", "#ED7D31", "#C0392B")
origin_continuous  <- c("#0000FF", "#0080FF", "#00CDCD", "#00FF00", "#80FF00", "#FFFF00")
matlab_continuous  <- c("#352A87", "#0363E1", "#1485D3", "#06A696", "#34B847",
                        "#85D444", "#D9EC3A", "#F4E32E", "#FAD11F")
stata_continuous   <- c("#000080", "#2E86C1", "#F4F7FA", "#E74C3C", "#800000")
academic_continuous <- c("#000000", "#404040", "#808080", "#BFBFBF", "#FFFFFF")
minitab_continuous <- c("#1F497D", "#4BACC6", "#F0F0F0", "#F79646", "#C0504D")
medcalc_continuous <- c("#000000", "#C0392B", "#E74C3C", "#F39C12", "#FFEAA7")

# ---- Prism continuous (blue-to-red sequential) ----

#' Prism-style continuous colour scale
#'
#' Blue-to-red sequential gradient mimicking Prism's default
#' heatmap colormap. Use for continuous colour aesthetics.
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_colour_gradientn}}.
#' @export
scale_color_prism_c <- function(...) ggplot2::scale_color_gradientn(colours = prism_continuous, ...)

#' @rdname scale_color_prism_c
#' @export
scale_fill_prism_c  <- function(...) ggplot2::scale_fill_gradientn(colours = prism_continuous, ...)

# ---- OriginPro continuous (BlueGreenYellow) ----

#' OriginPro-style continuous colour scale
#'
#' Blue-to-Yellow gradient via green, mimicking Origin 2017+
#' "BlueGreenYellow" 2D colormap.
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_colour_gradientn}}.
#' @export
scale_color_origin_c <- function(...) ggplot2::scale_color_gradientn(colours = origin_continuous, ...)

#' @rdname scale_color_origin_c
#' @export
scale_fill_origin_c  <- function(...) ggplot2::scale_fill_gradientn(colours = origin_continuous, ...)

# ---- MATLAB Parula ----

#' MATLAB parula-style continuous colour scale
#'
#' Perceptually uniform blue-green-yellow gradient approximating
#' MATLAB R2014b+ default parula colormap (9 keypoints).
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_colour_gradientn}}.
#' @export
scale_color_matlab_c <- function(...) ggplot2::scale_color_gradientn(colours = matlab_continuous, ...)

#' @rdname scale_color_matlab_c
#' @export
scale_fill_matlab_c  <- function(...) ggplot2::scale_fill_gradientn(colours = matlab_continuous, ...)

# ---- Stata continuous (diverging) ----

#' Stata-style continuous colour scale
#'
#' Navy-to-maroon diverging gradient (navy → blue → white → red →
#' maroon), mimicking Stata's default continuous colour scheme.
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_colour_gradientn}}.
#' @export
scale_color_stata_c <- function(...) ggplot2::scale_color_gradientn(colours = stata_continuous, ...)

#' @rdname scale_color_stata_c
#' @export
scale_fill_stata_c  <- function(...) ggplot2::scale_fill_gradientn(colours = stata_continuous, ...)

# ---- Academic continuous (grayscale) ----

#' Academic grayscale continuous colour scale
#'
#' Pure black-to-white lightness gradient. CVD-safe, grayscale-proof,
#' CMYK-compatible. Ideal for journal submission of heatmaps and
#' continuous surfaces.
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_colour_gradientn}}.
#' @export
scale_color_academic_c <- function(...) ggplot2::scale_color_gradientn(colours = academic_continuous, ...)

#' @rdname scale_color_academic_c
#' @export
scale_fill_academic_c  <- function(...) ggplot2::scale_fill_gradientn(colours = academic_continuous, ...)

# ---- Minitab continuous ----

#' Minitab-style continuous colour scale
#'
#' Dark-blue-to-dark-red diverging gradient (dark blue → teal →
#' white → orange → red), reflecting Minitab's default continuous scale.
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_colour_gradientn}}.
#' @export
scale_color_minitab_c <- function(...) ggplot2::scale_color_gradientn(colours = minitab_continuous, ...)

#' @rdname scale_color_minitab_c
#' @export
scale_fill_minitab_c  <- function(...) ggplot2::scale_fill_gradientn(colours = minitab_continuous, ...)

# ---- MedCalc continuous ----

#' MedCalc-style continuous colour scale
#'
#' Clinical heat gradient (black → red → orange → yellow), suitable
#' for risk-score and AUC heatmaps.
#' @param ... Arguments passed to \code{\link[ggplot2]{scale_colour_gradientn}}.
#' @export
scale_color_medcalc_c <- function(...) ggplot2::scale_color_gradientn(colours = medcalc_continuous, ...)

#' @rdname scale_color_medcalc_c
#' @export
scale_fill_medcalc_c  <- function(...) ggplot2::scale_fill_gradientn(colours = medcalc_continuous, ...)
