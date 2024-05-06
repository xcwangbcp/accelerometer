library(GGIR)
GGIR(mode=c(1,5),
     datadir="F:/Code/accData",
     outputdir="F:/Code/saveFiles",
     print.filename = TRUE,
     printsummary   = TRUE,
     do.report      = c(1,2,3,4,5),
     f1=0,f0=1,
     #=====================
     # read.myacc.csv arguments
     #=====================
     rmc.nrow = Inf,      rmc.skip = 0,
     rmc.dec = ".",       rmc.firstrow.acc = 2, 
     rmc.col.acc = 2:4,   #rmc.col.temp = " ", 
     rmc.col.time=1,      rmc.unit.acc = "g", 
     rmc.unit.temp = "C", rmc.unit.time = "POSIX",
     rmc.format.time = "%Y-%m-%d  %H:%M:%OS",
     desiredtz = " ",       rmc.sf = 1,
     configtz = " ",
     rmc.origin="1970-01-01",
     #=====================
     
     #=====================
     frequency_tol = 0.1,
     do.en         = TRUE,
     do.cal        = TRUE,
     acc.metric    = "ENMO",
     idloc         = 6,
     
     HDCZA_threshold = 0.2,
     hb = 15,
     lb = 0.2,
     n  = 2,
      #=====================
     # Part 2 sleep
     #=====================
     data_masking_strategy = 2,
     #hrs.del.start = 0,           hrs.del.end = 0,
     maxdur = 10,                 includedaycrit = 24,
     qwindow=c(0,24),             sleepwindowType = " ",
     Guider = " ",
     mvpathreshold =c(10),
     excludefirstlast = FALSE,
     includenightcrit = 16,
     ## sleep
     anglethreshold   = 5,
     timethreshold    = 5,
     ignorenonwear    = TRUE,
     HASPT.algo    = "HDCZA",
     HASIB.algo    = "Sadeh1994",
     Sadeh_axis    = "Y", 
     #longitudinal_axis=" ",
     HASPT.ignore.invalid=FALSE,
     #=====================
     # Part 3 + 4
     #=====================
    
     def.noc.sleep = c(19,7) ,
     possible_nap_window=c(11,14),
     possible_nap_dur=c(20,60),
     outliers.only = TRUE,
     criterror = 4,
     do.visual = TRUE,
     #=====================
     # Part 5
     #=====================
     threshold.lig = c(30), threshold.mod = c(100),  threshold.vig = c(400),
     boutcriter = 0.8,      boutcriter.in = 0.9,     boutcriter.lig = 0.8,
     boutcriter.mvpa = 0.8, boutdur.in = c(1,10,30), boutdur.lig = c(1,10),
     boutdur.mvpa = c(1, 5, 10),
     includedaycrit.part5 = 2/3,
     #=====================
     # Visual report
     #=====================
     timewindow = c("MM"),
     visualreport=TRUE)
     # sth i added acording to the errors i met
     
    
