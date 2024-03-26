/* This file creates Figure A1 in the appendix.  */
/* Author: Lars Vilhuber */

clear
use  "$dtam", clear  /* load merged data */
destring race1, gen(race1_num)

histogram race1_num, percent ytitle(, orientation(horizontal)) 
graph export "$results/figA1.pdf", replace
graph export "$results/figA1.png", replace
