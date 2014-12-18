#' R version of the stata lookfor function
#'
#' This will try to find a variable when you can't remember its exact name
#' @param string_to_find This is the string you wish to find Defaults to 'id'.
#' @keywords stata
#' @export
#' @examples
#' lookfor_function()

lookfor <- function(string_to_find, data=wdt) names(data)[grep(string_to_find,names(data))]
