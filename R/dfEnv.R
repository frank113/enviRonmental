#' Create R Environment from data frame
#'
#' @name dfEnv
#'
#' @description This function allows one to scrape rows and columns from an already
#'     existing \code{dataframe} to create an environment in R containing vectors
#'     corresponding to the rows or columns of the data frame or add such variables
#'     to an already-existing environment. 
#'
#' @param df A \code{data frame}. 
#'
#' @param orientation One of \code{"rows"} or \code{"cols"} to specify whether arrays 
#'     are to be created from the rows or columns of the data frame. Defaults to
#'     \code{"cols"}. If set to \code{"rows"}, the \code{df} must have row names. 
#'
#' @param global. A \code{boolean} indicating whether the variables
#'     are to be loaded into the existing environment or returned as an object. 
#'     Defaults to TRUE.
#'
#' @keywords environment, df
#'
#' @return NULL. Creates an R environment.
#'
#' @examples
#' \dontrun{
#' df <- data.frame(x = 1:3, y = 4:6)
#' 
#' dfEnv(df)
#' }
#'
#' @export
"dfEnv"

dfEnv <- function(df, orientation = "cols", global = TRUE) {
  # Preconditions
  # it must be a df
  if ( !is.data.frame(df) || dim(df)[[0]] == 0 || dim(df)[[1]] == 0 ) {
    stop("ERROR. First argument must be a non-empty data frame.")
  }
  
  # check that orientation must be valid
  if ( !(orientation %in% c("rows", "cols")) ) {
    stop("ERROR. Invalid orientation call")
  }
  
  # Get the environment right
  tmp.envr <- new.env()
  
  envir.attach <- tmp.envr
  if ( global ) {
    envir.attach <- .GlobalEnv
  }
  
  if (orientation == "cols") {
    var.names <- names(df)
    
    for (var in var.names) {
      col.vect <- getElement(df, var)
      assign(var, col.vect, envir = envir.attach)
    }
  } else {
    ## check to see if we need new names
    var.names <- row.names(df)
    
    ## chcek if it has row names
    if (all(row.names(df) == 1:nrow(df))) {
      ## we need to generate it
      
      for (i in 1:nrow(df)) {
        
        ## now we make the var name
        assign(paste("row", i, sep = ""), df[i, ], envir = envir.attach)
      }
    } else {
      for (i in 1:nrow(df)) {
        row.vect <- df[i, ]
        assign(var.names[[i]], row.vect, envir = envir.attach)
      }
    }
  }
  
  if ( global ) {
    return(NULL)
  }
  
  return(envir.attach)
}