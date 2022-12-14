# README

## Data

Data is public-use, but requires login at ICPSR. 

Data can be downloaded from https://doi.org/10.3886/ICPSR13568.v1



## Requirements

Runtime: approximatly 1.6s on 2016 vintage Linux workstation.

## Code

There are 5 Stata program files:

- `master.do` : will run all programs in the right sequence
- `00_setup_stata.do`: will set up directory structure, and install any required packages
- `01_dataclean.do`: reads in downloaded data, saves person and household files, and creates a clean merged dataset, for Alaska only
- `02_table1.do`: Creates Table 1

## Running code

Run the `master.do`. Suggested batch command:

```
stata -b do master.do
```
A log file will be created.

## Tables

All table output is in folder `tables`:

| Table | Programs | 
|-------|----------|
| Table 1 | 02_table1.do | 

