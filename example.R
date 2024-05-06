### ** Examples


# create test files: No header, with temperature, with time
N = 30
sf = 30
x = Sys.time()+((0:(N-1))/sf)
timestamps = as.POSIXlt(x, origin="1970-1-1", tz = "")
mydata = data.frame(x = rnorm(N), time = timestamps, y = rnorm(N), z = rnorm(N),
                    temp = rnorm(N) + 20)
testfile = "testcsv1.csv"
write.csv(mydata, file= testfile, row.names = FALSE)
loadedData = read.myacc.csv(rmc.file=testfile, rmc.nrow=20, rmc.dec=".",
                            rmc.firstrow.acc = 1, rmc.firstrow.header=c(),
                            desiredtz = "",
                            rmc.col.acc = c(1,3,4), rmc.col.temp = 5, rmc.col.time=2,
                            rmc.unit.acc = "g", rmc.unit.temp = "C", rmc.origin = "1970-01-01")
if (file.exists(testfile)) file.remove(testfile)

