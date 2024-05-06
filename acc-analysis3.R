library(GGIR)
GGIR(mode=c(1),
     datadir="G:/Code/accData",
     outputdir="G:/Code/saveFiles",
     do.report=c(2,4,5),
     #=====================
     # read.myacc.csv arguments
     #=====================
     rmc.nrow = Inf,      rmc.skip = 0,
     rmc.dec = ".",       rmc.firstrow.acc = 2, 
     rmc.col.acc = 2:4,   #rmc.col.temp = " ", 
     rmc.col.time=1,      rmc.unit.acc = "g", 
     rmc.unit.temp = "C", rmc.unit.time = "POSIX",
     rmc.format.time = "%Y-%m-%d  %H:%M:%OS",
     desiredtz = "",       rmc.sf = 1,
     #=====================
     # Part 2
     #=====================
     data_masking_strategy = 1,
     hrs.del.start = 0,           hrs.del.end = 0,
     maxdur = 9,                 includedaycrit = 16,
     qwindow=c(0,24),            sleepwindowType = "TimeInBed",
     HASIB.algo = "Sadeh1994",   Sadeh_axis = "Y",     Guider = "sleep log",
     mvpathreshold =c(100),
     excludefirstlast = FALSE,
     includenightcrit = 16,
     #=====================
     # Part 3 + 4
     #=====================
     def.noc.sleep = 1, 
     outliers.only = TRUE,
     criterror = 4,
     do.visual = TRUE,
     #=====================
     # Part 5
     #=====================
     threshold.lig = c(30), threshold.mod = c(100),  threshold.vig = c(400),
     boutcriter = 0.8,      boutcriter.in = 0.9,     boutcriter.lig = 0.8,
     boutcriter.mvpa = 0.8, boutdur.in = c(1,10,30), boutdur.lig = c(1,10),
     boutdur.mvpa = c(1),
     includedaycrit.part5 = 2/3,
     #=====================
     # Visual report
     #=====================
     timewindow = c("MM"),
     visualreport=TRUE)

