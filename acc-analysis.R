library(GGIR)
GGIR(datadir   = "G:/Code/accData/",
     outputdir = "G:/Code/saveFiles/",
     do.report = c(1,2,3,4,5),
     mode      = 1:5,
     overwrite = TRUE,
     print.filename = TRUE,
     printsummary   = TRUE,
     do.visual      = TRUE,
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
     desiredtz         = "Europe/London ",
     rmc.sf            = 1,
     configtz          = " ",
     rmc.origin        = "1970-01-01",
     rmc.check4timegaps= TRUE,
     rmc.doresample    = TRUE,
     interpolationType = 2,
     #=====================
     # Part 2
     #=====================
     
     #hrs.del.start = 0,           
     #hrs.del.end = 0,
                  
     includedaycrit        = 24,
     mvpathreshold         = c(10),
     excludefirstlast      = FALSE,
     includenightcrit      = 16,
     
     #=====================
     # Part 3 + 4
     #=====================
     def.noc.sleep        = c(19,7),
     outliers.only        = TRUE,
     criterror            = 4,
     possible_nap_window  = c(11,14),
     possible_nap_dur     = c(20,60),
     #=====================
     # params_247
     #=====================
     qwindow               = c(7,11,13,17,19),  
     data_masking_strategy = 2,
     maxdur                = 10, 
     
     do.en          = TRUE,
     do.cal         = TRUE,
     acc.metric     = "ENMO",
     idloc          = 6,
       
     timewindow     = c("MM"),
     sleepwindowType= "TimeInBed",
     Guider         = 3,
     relyonguider   = FALSE,
     HASPT.algo     = "HorAngle",
     
     f1 = 0,
     f0 = 1,
     hb = 15,
     lb = 0.2,
     n  = 2,
     frequency_tol   =  0.1,
     HDCZA_threshold = 0.2,
     

     anglethreshold        = 5,
     timethreshold         = 5,
     ignorenonwear         = TRUE,
    
     #HASIB.algo            = "Sadeh1994",报错Loading chunk: 1Error in butter.default(n, Wc, type = c("pass")) : 
     #butter: critical frequencies must be in (0 1)
     Sadeh_axis            = "Y", 
     #longitudinal_axis    = " ",
     HASPT.ignore.invalid  = FALSE
     #=====================
     # Part 5
     #=====================
     #threshold.lig = c(30),
     #threshold.mod        = c(100),
     #threshold.vig        = c(400),
     #boutcriter           = 0.8,
     #boutcriter.in        = 0.9,
     #boutcriter.lig       = 0.8,
     #boutcriter.mvpa      = 0.8,
     #boutdur.in           = c(1,10,30),
     #boutdur.lig          = c(1,10),
     #boutdur.mvpa         = c(1, 5, 10),
     #includedaycrit.part5 = 2/3)
     
     )
     


    

