e <- new.env()
assign("frank", 1, envir = e)

x <- 1

writeBin(x, con = file("bin.renv") )


save(x, file = "x.Renv")
