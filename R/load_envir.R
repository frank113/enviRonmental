## function to load an environment
## overwrite means we replace .Global with it
load.envir <- function(path, overwrite = TRUE) {
  if ( overwrite ) {
    ## clear the global
    rm(list = ls(.GlobalEnv))
    
    ## clear the packages
    pkg.names <- names( getElement( sessionInfo(), 
                                    "otherPkgs" ) )
    i <- 1
    while ( length( pkg.names ) != 0 ) {
      condition <- tryCatch({
        expr = suppressWarnings(
          detach( paste("package:", pkg.names[[i]], 
                        sep = ""),
                  unload = TRUE)
        )
      }, 
      error = {
        ## function to increment and handle if 
        i <- i + 1
      },
      finally = {
        
      }
        
      )
    }
    
    
  }
}

pkgs <- names( getElement( sessionInfo(),"otherPkgs"))

library(ggplot2)
library(forecast)

a <- 1
talia <- 15
olivia <- 21
library(rmarkdown)

e <- new.env()