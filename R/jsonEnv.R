#' Create R Environment from JSON File
#'
#' @name jsonEnv
#'
#' @description This function allows one to scrape fields from a \code{.json} 
#'     file to create an environment in R containing the same key value pairs seen
#'     in the file. 
#'
#' @param json A \code{string} to a \code{.json} file containing the environmental variables.
#'
#' @param global. A \code{boolean} indicating whether the variables
#'     are to be loaded into the existing environment or returned as an object. 
#'     Defaults to TRUE. 
#'
#' @keywords environment, json
#'
#' @return NULL. Creates an R environment.
#'
#' @examples
#' \dontrun{
#' jsonEnr("environment.json")
#' }
#'
#' @export
"jsonEnv"

jsonEnv <- function(json, global = TRUE) {
  # Preconditions
  # it must be a file
  if ( !file.exists(json) ) {
    stop("ERROR. File does not exist.")
  }
  
  # it must end in .json
  json.str.len <- stringr::str_length(json)
  if (json.str.len <= 4) {
    stop("Invalid file path.")
  }
  if ( substr(json, json.str.len - 4, json.str.len) != ".json" ) {
    stop("ERROR. Must be a .json file")
  }
  
  # It must be a boolean
  
  tmp.envr <- new.env()
  
  envir.attach <- tmp.envr
  if ( global ) {
    envir.attach <- .GlobalEnv
  }
  ## read the json
  json.file.obj <- jsonlite::fromJSON(json)
  for ( item in names(json.file.obj) ) {
    assign(item, getElement(json.file.obj, item), envir = envir.attach)
  }
  
  if ( global ) {
    message("Placed variables in environment.")
    return()
  }
  return(tmp.envr)
}