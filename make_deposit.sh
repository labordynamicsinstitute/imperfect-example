#!/bin/bash

outputfile="for_deposit.zip"

if [[ -f $outputfile ]]; then
    \rm -i $outputfile
fi

zip -rp $outputfile data/ICPSR_13568/ data/README.md programs/*do programs/*.dct README.md PDF_Proof.pdf
