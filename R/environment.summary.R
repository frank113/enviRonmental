## summary function for an environment

summary.envir <- function(envir) {
  if ( !is( envir, "environment" ) ) {
    stop("Need to pass environment as argument")
  }
}