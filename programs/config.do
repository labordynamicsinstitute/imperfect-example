/* config.do */
/* Suggested by Lars Vilhuber */
/* Create a reproducible Stata sequence by calling this program from every other program in your sequence */
/* Get it at: https://gist.github.com/larsvilhuber/6bcf4ff820285a1f1b9cfff2c81ca02b */
/* Usage: 
  Adapt to your needs, save as config.do, then add
   include "config.do"
   in the author's main Stata program
   */

/* Create a log file */
local c_date = c(current_date)
local cdate = subinstr("`c_date'", " ", "_", .)
local logprefix "logfile" // could be "myprog" or something else or could come from the main program 
cap log using "`logprefix'_`cdate'.log", replace text

/* define global parameters and paths */
global precision 0.01

/* paths */
local pwd : pwd
global basepath "`pwd'/.."      // change this for your specific system
global icpsrpath "$basepath/data/ICPSR_13568/DS0002"  /* local relative path */
global inputdata "$basepath/data/inputdata"  // this is where you would read data acquired elsewhere
global outputdata "$basepath/data/outputdata" // this is where you would write the data you create in this project
global results "$basepath/tables"       // All tables for inclusion in your paper go here
global programs "$basepath/programs"    // All programs (which you might "include") are to be found here
global adobase  "$basepath/programs/ado" // Ado packages used by the project are to be found here

/* install any packages locally */
capture mkdir "$adobase"
sysdir set PERSONAL "$adobase/ado/personal"
sysdir set PLUS     "$adobase/ado/plus"
sysdir set SITE     "$adobase/ado/site"



/* keep this line in the config file */
/* It will provide some info about how and when the program was run */
/* See https://www.stata.com/manuals13/pcreturn.pdf#pcreturn */
local variant = cond(c(MP),"MP",cond(c(SE),"SE",c(flavor)) )  
// alternatively, you could use 
// local variant = cond(c(stata_version)>13,c(real_flavor),"NA")  

di "=== SYSTEM DIAGNOSTICS ==="
di "Stata version: `c(stata_version)'"
di "Updated as of: `c(born_date)'"
di "Variant:       `variant'"
di "Processors:    `c(processors)'"
di "OS:            `c(os)' `c(osdtl)'"
di "Machine type:  `c(machine_type)'"
di "=========================="

global dtam  "$outputdata/pumsak.dta"  /* Stata PUMS merged data */

set more 1
