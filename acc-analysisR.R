library(GGIR)
GGIR(datadir   = "G:/Code/accData/",
     outputdir = "G:/Code/saveFiles/",
     overwrite = TRUE,
     mode      = 4,
     f1        = 0,
     f0        = 1,
     idloc     = 6,
     do.enmo   = TRUE,
     
     acc.metric     = "ENMO",
     print.filename = TRUE,
     printsummary   = TRUE,
    
     do.parallel    = TRUE,
     do.report      = c(2,4,5,6),
     #do.en          = TRUE,
     do.cal         = TRUE,
     visualreport   = TRUE,
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
     rmc.format.time   = "%Y-%m-%d  %H:%M:%OS",
     rmc.desiredtz     = "Europe/London",
     desiredtz         = "Europe/London",
     rmc.sf            = 1,
     configtz          = " ",
     rmc.origin        = "1970-01-01",
     rmc.check4timegaps= TRUE,
     rmc.doresample    = TRUE,
     interpolationType = 2,
     frequency_tol   =  0.1,
     hb = 15,
     lb = 0.2,
     #n  = 2,
     
     #=====================
     # Part 2 Physical activity Parameters
     #=====================
     mvpathreshold = c(10,20), ##### care this 
     boutcriter    = 0.8,
     boutcriter.in        = 0.9,
     boutcriter.lig       = 0.8,
     boutcriter.mvpa      = 0.8,
     boutdur.in           = c(1,10,30),
     boutdur.lig          = c(1,10),
     boutdur.mvpa         = c(1, 5, 10),
     threshold.mod        = c(100),
     threshold.vig        = c(400),
     threshold.lig        = c(40),
     
     #=====================
     # Part 3 24/7 Parameters
     #=====================
     
     qwindow            = c(7,11,13,17,19),  
     qlevels            = c(0.1,0.5,0.75),
     IVIS_acc_threshold = 5,##### care this 
     #Guider         = " ",
     #=====================
     # Part  Cleaning Parameters
     #=====================
     includedaycrit        = 16,
     data_masking_strategy = 2,
     #hrs.del.start = 0,           
     #hrs.del.end = 0,
     maxdur                = 0,                
     excludefirstlast      = FALSE,
     includenightcrit      = 16,
     includedaycrit.part5  = 2/3,
    
     #=====================
     # Part 4 Sleep Parameters
     #=====================
     anglethreshold        = c(3,5),##### care this 
     timethreshold         = 5,
     ignorenonwear         = TRUE,
     HASPT.algo            = "HDCZA",
     HASIB.algo            = "vanHees2015",#报错Loading chunk: 1Error in butter.default(n, Wc, type = c("pass")) : 
     #butter: critical frequencies must be in (0 1)
     #Sadeh_axis            = "Y", 
     #longitudinal_axis     = " ",
     HASPT.ignore.invalid  = FALSE,
     relyonguider          = FALSE,
     def.noc.sleep        = c(19,7) ,
     sleepwindowType       = "SPT",
     possible_nap_window  = c(11,14),
     possible_nap_dur     = c(0,60),
     HDCZA_threshold      = 0.2,
     guider=2,
     #Guider = "HDCZA",
     do.visual      = TRUE,
     #=====================
     #  Output Parameters
     #=====================
     outliers.only         = TRUE,
     criterror             = 3, #Numeric (default = 3). In g.part4: Only used if do.visual = TRUE and
     # outliers.only = TRUE. criterror specifies the number of minimum number of hours difference 
     # between sleep log and accelerometer estimate for the night to be included in the visualisation.
     do.sibreport         = FALSE,

     #=====================
     # Part 5
     #=====================
     timewindow     = c("MM")
    )


