save.envir <- function(envir = .GlobalEnv, 
                       pkgs = names( getElement( sessionInfo(), 
                                                      "otherPkgs" ) ), 
                       file.path = getwd(), remove.envirs = TRUE) {
  ## to get the environment, we need to do names( sessionInfo$otherPkgs )

  ## bad.inds <- union( which(envir == "save.envir") )
  assignToE <- function(envir.to, envir.from) {
    return( function( name ) {
      ## get the element
      val <- getElement(envir.from, name)
      assign(name, val, envir = envir.to)
    } )
  }
  e <- new.env()
  ap.fun <- assignToE(e, .GlobalEnv)
  lapply( X = ls(.GlobalEnv)[-which(ls(.GlobalEnv) == "save.envir")], 
          FUN = ap.fun)
  
  ## add to the object a library list
  envir.obj <- list(environ = e, 
                    lib = pkgs)
  return(envir.obj)
}

x <- 1
y <- 2
frank <- 14
talia  <- 11
olivia <- 1540

env <- save.envir()

save(env, file = "envir.Renv")


