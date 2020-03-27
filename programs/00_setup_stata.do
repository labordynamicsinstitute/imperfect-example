clear all
include "config.do"



program main
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	* Add required packages from SSC to this list
	* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	local ssc_packages ///
	    
    if !missing("`ssc_packages'") {
        foreach pkg in `ssc_packages' {
			capture which `pkg'
			if _rc == 111 {			
				dis "Installing `pkg'"
                ssc install `pkg', replace
			}
        }
    }

end

main
