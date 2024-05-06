library(GGIR)
GGIR(mode=1:5,
     datadir   = "F:/Code/accData/",
     outputdir = "F:/Code/saveFiles/",
     overwrite = TRUE,
     do.report = c(1,2,3,4,5),
     f1        = 0,
     f0        = 1,
     idloc     = 6,
     do.enmo  = TRUE,
    # do.enmo   = FALSE,
     acc.metric= "ENMOa",
     print.filename = TRUE,
     printsummary   = TRUE,
     do.parallel    = TRUE,
     #do.en          = TRUE,
     do.cal         = TRUE,

     #=====================
     # read.myacc.csv arguments
     #=====================
     rmc.nrow          = Inf,      
     rmc.skip          = 0,
     rmc.dec           = ".",
     rmc.firstrow.acc  = 2, 
     rmc.col.acc       = 2:4, 
     #rmc.col.temp     = " ", 
     rmc.col.time      = 1,
     rmc.unit.acc      = "g", 
     rmc.unit.temp     = "C",
     rmc.unit.time     = "POSIX",
     rmc.format.time   = "%Y-%m-%d  %H:%M:%S",
     rmc.desiredtz     = " ",#"Asia/Shanghai",
     desiredtz         = " ",#Asia/Shanghai",
     rmc.sf            = 1,
     configtz          = " ",
     rmc.origin        = "1970-01-01",
     rmc.check4timegaps= TRUE,
     rmc.doresample    = TRUE,
     interpolationType = 2,
     frequency_tol   =  0.1,
     hb = 15,
     lb = 0.2,
     #=====================
     # Part 2
     #=====================
     data_masking_strategy = 1,
     hrs.del.start         = 0,
     hrs.del.end           = 0,
     maxdur                = 15, 
     includedaycrit        = 16,
     includenightcrit   = 16,
     qwindow            = c(7,11,13,17,19),  
     #qlevels            = "",#c(0.1,0.5,0.75),
     IVIS_acc_threshold = 20,##### Numeric (default = 20). 
     #Acceleration threshold to distinguish inactive from active. 
     mvpathreshold      =100,#umeric (default = 100). 
     #Acceleration threshold for MVPA estimation in GGIR g.part2.
     #This can be a single number or an array of numbers,
     #e.g., mvpathreshold = c(100, 120).
     #In the latter case the code will estimate MVPA separately
     #for each threshold. If this variable is left blank, 
     #e.g., mvpathreshold = c(), then MVPA is not estimated
     excludefirstlast   = FALSE,
     
     #=====================
     # Part 3 + 4
     #=====================

     relyonsleeplog   = FALSE,
     #sleeplogidnum    = TRUE,
     def.noc.sleep    = c(7,19),
     #outliers.only    = TRUE,
     #criterror        = 4,
     do.visual        = TRUE,
     #HASPT.algo       = "HorAngle",
     possible_nap_window=c(12,14),
     
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