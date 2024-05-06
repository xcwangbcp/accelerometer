library(GGIR)
loaddata=read.myacc.csv(rmc.file = "G:/Code/accData/1209.csv",
               rmc.nrow = Inf,
               rmc.skip = 0,
               rmc.dec = ".",
               rmc.firstrow.acc = 2,
               rmc.col.acc = 2:4,
               #rmc.col.temp = "",
               rmc.col.time=1,
               rmc.unit.acc = "g",
               rmc.unit.temp = "C",
               rmc.unit.time = "POSIX",
               rmc.format.time = "%Y-%m-%d  %H:%M:%OS",
               desiredtz = "",
               rmc.configtz=NULL,
               rmc.origin="1970-01-01",
               rmc.sf = 1)
testfile = "test_acc_csv2.csv"
write.csv(loaddata['data'], file= testfile, row.names = FALSE)
