
#' Coordinates of boundaries points of storms wind radii
#'
#' Compute boundaries points for multiple singles storms using storm eyes and wind radii
#'
#' @param x0 numeric vector containing longitudes of storm eyes
#' @param y0 numeric vector containing latitudes of storm eyes
#' @param rne numeric vector containing storm radii in North-East quadrant
#' @param rnw numeric vector containing storm radii in North-West quadrant
#' @param rse numeric vector containing storm radii in South-East quadrant
#' @param rsw numeric vector containing storm radii in South-West quadrant
#' @param scaler numeric, a number between 0 and 1 to scale wind radii
#' @param np numeric, number of point in each section: arc or segment
#'
#' @return data frame of two variables lon and lat
#'
#' @export
#'
#' @examples
#' \dontrun{
#' wborders(c(0, 0), c(5, 7), c(400, 100), c(300, 200), c(200, 200), c(50, 50))
#' }
wborders <- function(x0, y0, rne, rnw, rse, rsw, scaler = 1, np = 250) {
  stopifnot(length(x0) > 0, length(x0) == length(y0), length(x0) == length(rne),
            length(x0) == length(rnw), length(x0) == length(rse),
            length(x0) == length(rsw))
  coordinates <- wborder(x0[1], y0[1], rne[1], rnw[1], rse[1], rsw[1], scaler, np)

  if (length(x0) > 1) {
    for (i in 2:length(x0)) {
      coordinates <- rbind(coordinates,
                           wborder(x0[i], y0[i], rne[i], rnw[i], rse[i], rsw[i],
                                   scaler, np))
    }
  }
  return(coordinates)
}
