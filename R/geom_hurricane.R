#' geom_hurricane
#'
#' This layer function for geom_hurricane is simply geom_polygon using stat hurricane.
#'   It is calling geom_polygon to draw wind boundaries as polygons with arcs and segments.
#'
#' @inheritParams ggplot2::geom_polygon
#'
#' @return graphical element
#'
#' @export
#'
#' @importFrom ggplot2 layer GeomPolygon
#'
#' @examples
#' \dontrun{
#' geom_hurricane()
#' }
geom_hurricane <- function(mapping = NULL, data = NULL, stat = "hurricane",
                           position = "identity", na.rm = FALSE, show.legend = NA,
                           inherit.aes = TRUE, ...) {
  ggplot2::layer(
    geom = ggplot2::GeomPolygon, mapping = mapping, data = data, stat = stat,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
