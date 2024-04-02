# Solution

This is not an exercise, so here's the solution to making this a well-documented exercise in verification.


## Problem 1

When you first run this, you MAY be getting an error due to where you ran this. In particular,

```
. do programs/master.do
```

should elicit something similar to this

```
. do "$programs/00_setup_stata.do"
file /project/../programs/00_setup_stata.do not found
r(601);

end of do-file

r(601);
```

This happens because you ran the program from wherever Stata opened, without changing working directory. 

**Solution 1**: Run using the right-click method should work.

**Solution 2**: (sub-optimal) Changing what is written in 

```
// master.do:
global basepath "`pwd'/.."      // change this for your specific system
```
to the specific path on your system will work, but will force every subsequent replicator to *also* change their paths.

**Wrong solution**: changing every path in `master.do` to have a full path on your computer is wrong. Do not do this.

**Report**: Your report should make a note that the author did not mention how to run the Stata code, and that it assumes that Stata has already changed working directory to that of the `master.do` file.

## Note on debugging after Problem 1

How do you document the problem? In particular, since by fixing it, you solve it, and so it no longer shows for future replicators?

### Step 1

Include the template config file from the replication template.

- Copy [`template-config.do`](https://github.com/AEADataEditor/replication-template/blob/master/template-config.do) to the `nnnnn/programs/` directory as `config.do`.
- Include it in the `master.do`:
```
include "config.do"
```
This will generate a log file every time you run the `master.do` now.

> Please note: You should exit Stata after EVERY error, and start again (within reason). This will ensure that the logfile gets closed, is associated with one and only one problem, and that the state of Stata is "clean" everytime you run again.

### Step 2

Now that you can document the error:

- `git add` the log file after every error. Then `git commit`, specifying the problem in the commit message.
- Solve the problem. In this case, if you chose the optimal solution, you will not have changed the code, but you will have made a note of this in the `REPLICATION.md`, so `git add REPLICATION.md` followed by `git commit`, specifying that you added a note about the run method.
- If instead you had edited the `master.do`, you would ALSO have `git add programs/master.do` before `git commit`, so that the two files are documented together.

You will do the same after each error: 

- commit the logfile
- solve the problem
- commit the logbook (`REPLICATION.md`) and the code with the solution embedded.
- then run again.

## Problem 2

You have solved the above, and now run into the following problem:

```
.   save `dtahu', replace  /* save housing unit data */
(file /project/programs/../data/outputdata/housing.dta not found)
file /project/programs/../data/outputdata/housing.dta could not be opened
r(603);

end of do-file
r(603);

```

This is tricky, but frequently recurring. As it turns out, it is **not** that the file `data/outputdata/housing.dta` cannot be opened - it is that the directory `data/outputdata` does not exist (as you will find if you check in the `data` directory).

**Solution 1**: Add code to the `master.do` to create the directory. Inspection shows that the `master.do` defines the output directory:

```
8: global outputdata "$basepath/data/outputdata" // this is where you would write the data you create in this project
```

so you would add after line 12:
```
cap mkdir "$outputdata"
```

See above how to log this.

**Solution 2**: (sub-optimal) You manually create the directory.

In both cases, you make a note in the `REPLICATION.md`.

## Problem 3

``` 
.   latab specific_ak [fweight=pweight_num],  tf("$results/freq_specific_ak") 
> replace dec(2)
command latab is unrecognized
r(199);

end of do-file
r(199);

end of do-file

r(199);

```

Inspection will show that the Stata package `latab` is not available. This will need to be installed. It is not listed in the README.

**Solution 1**: In the `config.do` [is a spot](https://github.com/AEADataEditor/replication-template/blob/master/template-config.do#L37) to add to-be-installed Stata packages:

```
local ssc_packages ""
```

Add it there:

```
local ssc_packages "latab"
```

**Solution 2**: Inspection will show that the author has something similar in `00_setup_stata.do`:

```
9: 	local ssc_packages ///
```

Add it there:

```
local ssc_packages "latab"  ///
```


Save, commit, run again.

## Problem 4

```
(file /project/programs/../results/freq_specific_ak.tex not found)
file /project/programs/../results/freq_specific_ak.tex could not be opened
r(603);

end of do-file
r(603);

end of do-file

r(603);
```

You should be able to figure this one out by now!

## Problem 5

Once you have solved all these problems, you should compare the output table (here in the form of a Tex file - not the nicest to compare, but we only care about the numbers!) and appendix figure with the manuscript (`PDF_Proof.pdf`). That comparison should go into the report as well. In this case you will notice that the figure in the paper has a data point missing compared to the one created by the code. This is documented using an annotated screenshot in the solution report for this case.

## Final

The file `code-check.xlsx` can help you keep track of many tables and figures, and you can copy-paste the results into the REPLICATION.md. You should note any minor discrepancy.

- Listing discrepancies out, or screenshotting and including in the report are both acceptable methods.
- Annotating PNG versions of figures to highlight where they differ from the report is encouraged. 
- Ensure that all screenshots are included in the git repository! (no remote references)
- Ensure that you include them in the `REPLICATION.md` with the correct file extension (Windows might hide them, but the Linux systems care about them, including about the case of the extension - `PNG` is not the same as `png` for case-sensitive filesystems.)

Then you are done. Ensure that all log files and any changed code is committed, and pushed. A `git status` should show no pending updates, and no untracked files that you are unaware of.


