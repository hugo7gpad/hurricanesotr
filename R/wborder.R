#' Coordinates of boundary points of storm
#'
#' Compute boundary points for a single storm using center and radii in each quadrant
#'
#' @param x0 numeric, longitude of the eye of the storm
#' @param y0 numeric, latitude of the eye of the storm
#' @param rne numeric, wind radius in North-East quadrant
#' @param rnw numeric, wind radius in North-West quadrant
#' @param rse numeric, wind radius in South-East quadrant
#' @param rsw numeric, wind radius in South-West quadrant
#' @param scaler numeric, to scale wind radii
#' @param np numeric, number of in each section: segment or arc
#'
#' @return data frame of two variables: lon, lat. Coordinates of wind boundary points
#'
#' @export
#'
#' @importFrom geosphere destPoint
#'
#' @examples
#' \dontrun{
#' wborder(0, 0, 200, 100, 150, 75)
#' }
wborder <- function(x0, y0, rne, rnw, rse, rsw, scaler = 1, np = 250) {
  # scaler : parameter to scale radii
  # np : number of points for each section
  # b : bearing, d : distance from center (x0, y0)

  # Points on North-East arc
  b <- seq(0, 90, length = np)
  d <- 1852 * scaler * rne
  NE_df <- geosphere::destPoint(c(x0, y0), b, d) %>% data.frame()

  # Points on East segment
  b <- 90
  d <- seq(1852 * scaler * rne, 1852 * scaler * rse, length = np)
  East_df <- geosphere::destPoint(c(x0, y0), b, d) %>% data.frame()

  # Points on South-East arc
  b <- seq(90, 180, length = np)
  d <- 1852 * scaler * rse
  SE_df <- geosphere::destPoint(c(x0, y0), b, d) %>% data.frame()

  # Points on South segment
  b <- 180
  d <- seq(1852 * scaler * rse, 1852 * scaler * rsw, length = np)
  South_df <- geosphere::destPoint(c(x0, y0), b, d) %>% data.frame()

  # Points on South-West arc
  b <- seq(180, 270, length = np)
  d <- 1852 * scaler * rsw
  SW_df <- geosphere::destPoint(c(x0, y0), b, d) %>% data.frame()

  # Points on West segment
  b <- 270
  d <- seq(1852 * scaler * rsw, 1852 * scaler * rnw, length = np)
  West_df <- geosphere::destPoint(c(x0, y0), b, d) %>% data.frame()

  # Points on North-West arc
  b <- seq(270, 360, length = np)
  d <- 1852 * scaler * rnw
  NW_df <- geosphere::destPoint(c(x0, y0), b, d) %>% data.frame()

  # Points on North segment
  b <- 0
  d <- seq(1852 * scaler * rnw, 1852 * scaler * rne, length = np)
  North_df <- geosphere::destPoint(c(x0, y0), b, d) %>% data.frame()

  rbind(NE_df, East_df, SE_df, South_df, SW_df, West_df, NW_df, North_df)
}
