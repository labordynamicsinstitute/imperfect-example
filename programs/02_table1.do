/* This file creates Table 1 in the paper.  */
/* Author: Lars Vilhuber */

clear
use  "$dtam", clear  /* load merged data */

  /* table with appropriate weights */
  tab specific_ak [fweight=pweight_num]
  /* output the table to latex */
  label define spec 0  "Not identified" 1 "Identified with one of the four tribes"
  label value specific_ak spec
  latab specific_ak [fweight=pweight_num],  tf("$results/freq_specific_ak") replace dec(2)

