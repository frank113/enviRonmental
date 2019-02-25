## function to make an environment object that includes everything needed
## wrapper to build upon the ucrrent R way of seeing an envir
envir <- function(e, pkgs = NULL) {
  if ( !is(e, "environment") ) {
    stop("Need to pass a builtin R environment")
  }
  ## we have a structure with 2 fields, vars and pkgs

  ## make the variable list
  vars <- list()
  for ( item in names(e) ) {
    vars[item] <- getElement(e, item)
  }
  
  structure( 
    list(
      "variables" = vars, 
      "packages" = pkgs
      ),
    class = "envir"
  )
  
  
}

x <- envir(e)
