#' sotdfss single observation time dataset for single storm
#'
#' Create a single observation time dataset for a single storm when information
#'   such as storm name, year, month, day, hour are provided
#'
#' @param name character, storm name
#' @param yyyy character, storm year, four digits number as character
#' @param mm character, storm month, two digits number as character
#' @param dd character, storm day, two digits number as character
#' @param hh character, storm hour, two digits number as character
#' @param database tibble or data frame with storms information
#'
#' @return data frame with two variables: lon, lat
#'
#' @export
#'
#' @importFrom dplyr filter mutate select %>%
#'
#' @examples
#' \dontrun{
#' sotdfss("KATRINA", 2005, "08", "29", "12", ext_tracks)
#' }
sotdfss <- function(name = "KATRINA", yyyy = 2005, mm = "08",
                    dd = "29", hh = "12", database = ext_tracks) {
  singl_dat <- database %>%
    dplyr::filter(storm_name == name, year == yyyy,
                  month == mm, day == dd, hour == hh) %>%
    dplyr::mutate(storm_id = paste(storm_name, year),
                  longitude = - longitude,
                  date = paste(paste(year, month, day, sep = "-"),
                               paste0(hour, ":00:00")))
  rbind(singl_dat, singl_dat, singl_dat) %>%
    dplyr::mutate(wind_speed = factor(c(34, 50, 64)),
                  ne = c(max(radius_34_ne), max(radius_50_ne), max(radius_64_ne)),
                  nw = c(max(radius_34_nw), max(radius_50_nw), max(radius_64_nw)),
                  se = c(max(radius_34_se), max(radius_50_se), max(radius_64_se)),
                  sw = c(max(radius_34_sw), max(radius_50_sw), max(radius_64_sw))) %>%
    dplyr::select(storm_id, date, latitude, longitude, wind_speed,
                  ne, nw, se, sw) %>%
    data.frame() %>%
    print()
}
