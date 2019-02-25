e <- new.env()


## ATTACH for the functions

e <- new.env(parent=baseenv())
local({
  x <- 1;
  y <- 2
}, e)

## variable code in local, then unload all libraries and re-load them

attach(e, name="frank")

library(forecast, pos = 2)
