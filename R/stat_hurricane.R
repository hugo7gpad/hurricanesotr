
#' Layer function for StatHurricane
#'
#' Compute layers to be added when mapping variables in data transformed by
#'   StatHurricane to aesthetics to create plots
#'
#' @param scale_radii parameter used to scale wind radii
#' @param np number of points for each section: arc or segment
#' @param mapping, how variables in the data is mapped to visual properties
#' @param data, data used to create the graphical element
#' @param geom geom layer function to call
#' @param position where to plot each group of graphical element
#' @param na.rm parameter for na's
#' @param show.legend description to be displayed
#' @param inherit.aes logical aes parameter
#' @param ... other arguments to be passed
#'
#' @return graphical element
#'
#' @export
#'
#' @importFrom ggplot2 layer
#'
#' @examples
#' \dontrun{
#' stat_hurricane()
#' }
stat_hurricane <- function(mapping = NULL, data = NULL, geom = "hurricane",
                           position = "identity", na.rm = FALSE, show.legend = NA,
                           inherit.aes = TRUE, scale_radii = 1, np = 250, ...) {
  ggplot2::layer(
    stat = StatHurricane, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(scale_radii = scale_radii, np = np, na.rm = na.rm, ...)
  )
}

#' StatHurricane
#' @rdname hurricanesotr
#' @format NULL
#' @usage NULL
#' @keywords internal
#' @export
StatHurricane <- ggplot2::ggproto("StatHurricane", ggplot2::Stat,
                         required_aes = c("x", "y", "r_ne", "r_nw", "r_se", "r_sw"),
                         compute_group = function(data, scales, params,
                                                  scale_radii = 1, np = 250) {
                           wbpts <- wborders(data$x, data$y, data$r_ne, data$r_nw,
                                             data$r_se, data$r_sw, scale_radii,np)
                           wbpts_df <- dplyr::bind_rows(replicate(8 * np, data[1, ],
                                                                  simplify = FALSE))
                           if (nrow(data) > 1) {
                             for (i in 2:nrow(data)) {
                               wbpts_df <- rbind(wbpts_df,
                                                 dplyr::bind_rows(replicate(8 * np, data[i, ],
                                                                     simplify = FALSE)))
                             }
                           }
                           wbpts_df$x <- wbpts$lon
                           wbpts_df$y <- wbpts$lat
                           wbpts_df
                         })
