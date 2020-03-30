/* $Id: 01_stata.do 1259 2014-12-10 14:37:31Z lv39 $ */
/* This file reads in Alaska PUMS data */
/* SRC: http://doi.org/10.3886/ICPSR13568.v1 */
/* Source program:  "ICPSR_13568/13568-Setup.do" was used
   as a template, but that program cannot
   be run as-is */
/* Download data files to ICPSR_13568 */
/* Author: Lars Vilhuber */


  /* Define local macros, filenames and locations */
  local datpums "$icpsrpath/13568-0002-Data.txt"   /* PUMS Data */
  local dtahu "$outputdata/housing.dta"  /* Stata Housing Unit data */
  local dcthu "$programs/housing.dct"  /* Stata Housing Unit dictionary */
  local dtap  "$outputdata/person.dta"   /* Stata Person data */
  local dctp  "$programs/person.dct"   /* Stata Person dictionary */
  
  /* global macros are defined in config.do */


  clear
  infile using `dcthu' if rectype=="H", using ("`datpums'")
  sort serialno   /* sort data by Serial Number */
  save `dtahu', replace  /* save housing unit data */

  clear
  infile using `dctp' if rectype=="P", using ("`datpums'")
  sort serialno   /* sort data by Serial Number */
  save `dtap', replace /* save person data */

  merge serialno using `dtahu' /* merge person and housing unit data */
  drop _merge
  /* keep only relevant information */
  keep pweight race2 race1 numrace
  /* code a dummy to the four tribes */
  gen specific_ak=(race2 == "31" | race2 == "32" | race2 == "33" | race2 == "34")
  /* convert weights */
  destring pweight, gen(pweight_num)
  /* label variables */
  label variable specific_ak "Identifying with one of the four tribes"
  label variable pweight_num "Person weight"
  saveold "$dtam", replace  /* save merged data */
  
  