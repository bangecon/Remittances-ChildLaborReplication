set more off
cd "D:\Google Drive\Research - Immigration\Remittances&DomesticViolence\PunjabMICS2014"
use "hl.dta", clear
bysort hh1 hh2: egen size = max(ln)
foreach var of varlist hl5m hl6 hl12 ed4b ed6b ed8b {
	replace `var' = . if `var' >= 97
	}
replace hl5y = . if hl5y >= 9997
label define yesnodk 1 "yes" 2 "no" 8 "dk" 9 "missing"
foreach var of varlist hl10c hl11 hl13 hl16a hl16b hl16c ed3 ed5 ed7 {
	recode `var' (. = 9)
	label values `var' yesnodk
	}
label define divisionnew 1 "bahawalpur" 2 "dg khan" 3 "faisalabad" 4 "gujranwala" 5 "lahore" ///
	6 "multan" 7 "rawalpindi" 8 "other1" 9 "other2"
label values division divisionnew
label define privatepublic 1 "government" 2 "private" 6 "others" 8 "dk" 9 "missing"
foreach var of varlist ed6c ed8c {
	recode `var' (. = 9)
	label values `var' privatepublic
	}
label define livesabroad 1 "domestic home" 2 "domestic institution" 3 "abroad" 8 "dk" 9 "missing"
foreach var of varlist hl12a hl14a {
	recode `var' (. = 9)
	label values `var' livesabroad
	}
label define educa 0 "preschool" 1 "primary" 2 "middle" 3 "matric" 4 "higher" 8 "dk" 9 "missing"
foreach var of varlist ed4a ed6a ed8a {
	recode `var' (. = 9)
	label values `var' educa
	}
label define edlevel 1 "none/pre-school" 2 "primary" 3 "middle" 4 "secondary" 5 "higher" ///
	6 "graduate" 9 "missing"
foreach var of varlist helevel melevel felevel {	
	recode `var' (. = 9)
	label values `var' edlevel
	}
label define occupation 1 "government / semi govt. employee" 2 "private employee" 3 "self employed" ///
	4 "employs others" 5 "labourer" 6 "rent of house, shop, agriculture eqipment, tractor, tubewell" ///
	7 "interest or profit from any source" 8 "agriculture/land rent/sharing" ///
	9 "live stock, poultry, fishery, forestry" 10 "retired with pension" 11 "student income (eg tutor)" ///
	12 "child (5-17) works outside hh in workshop or collects garbage" /// 
	13 "child (5-17) works outside hh - any other work" 14 "home base worker" 21 "unemployed - looking" ///
	22 "unemployed - not looking" 23 "unpaid family worker (4+ hours/day)" 24 "housewife" ///
	25 "aged/ very weak" 26 "student" 27 "none" 95 "others - no income" 96 "others - income" 98 "dk" 99 "missing"
foreach var of varlist ie3 ie7 {
	recode `var' (. = 99)
	label values `var' occupation
	}
label define hh7new 1 "bahawalpur" 2 "b. nagar" 3 "ry khan" 4 "dg khan" 5 "layyah" 6 "m. garh" ///
	7 "rajanpur" 8 "faisalabad" 9 "chiniot" 10 "jhang" 11 "tt singh" 12 "gujranwala" 13 "gujrat" ///
	14 "hafizabad" 15 "m. bahaudin" 16 "narowal" 17 "sialkot" 18 "lahore" 19 "kasur" 20 "n. sahib" ///
	21 "sheikhupura" 22 "multan" 23 "khanewal" 24 "lodhran" 25 "vehari" 26 "rawalpindi" 27 "attock" ///
	28 "chakwal" 29 "jhelum" 30 "sahiwal" 31 "okara" 32 "pakpattan" 33 "sargodha" 34 "bhakkar" ///
	35 "other1" 36 "other2" 37 "sahiwal" 38 "pakpattan" 39 "okara" 40 "rawalpindi" 41 "attock" ///
	42 "chakwal" 43 "jhelum" 44 "sargodha" 45 "bhakkar" 46 "other1r" 47 "other2r"
foreach var of varlist hh7 hh7r {
	label values `var' hh7new
	}
label define windex 1 "lowest" 2 "second" 3 "middle" 4 "fourth" 5 "highest" 9 "missing"
foreach var of varlist windex5 windex5r windex5u {
	recode `var' (. = 9)
	label values `var' windex 
	}
save "hlnew.dta", replace 
keep if hl3 == 1
foreach var of varlist hl4 hl5m hl5y hl6 hl6b hl7 hl7b hl10a hl10ba hl10bb hl10bc hl10bd hl10bx hl10bz ///
	hl10c hl10da hl10db hl10dc hl10dd hl10dx hl10dz hl11 hl12 hl12a hl13 hl14 hl14a hl15 hl16a hl16b ///
	hl16c ed1 ed3 ed4a ed4b ed5 ed6a ed6b ed6c ed7 ed8a ed8b ed8c ie1 ie3 ie4n ie4u ie5 ie6 ie7 ie8n ///
	ie8u ie9 ie10 hh5d hh5m hh5y hh6 hh7 mline fline division hh7r hh6r suburban stratum helevel ///
	melevel felevel schage wscore windex5 wscoreu windex5u wscorer windex5r hhweight size {
	ren `var' hh`var'
	}
save "hoh.dta", replace 
use "hh.dta", clear
rename sl9b ln
merge 1:1 hh1 hh2 ln using "hl.dta", keep(master match) generate(_merge_hl)
merge m:1 hh1 hh2 using "hoh.dta", generate(_merge_hoh)
* Keep households that completed the survey
keep if hh9 == 1
* Recode a bunch of missing values for numerical variables
foreach var of varlist cl4 cl9 cl12 hc12 hc14a hc14b hc14c hc14d hc14e hh18h hh18m hh19h hh19m hc2 hc3 ///
	hc4 hc5 hc6 hc12 hc14a hc14b hc14c hc14d hc14e rm2 {
	recode `var' (99 = .)
	recode `var' (98 = .)
	recode `var' (97 = .)
	}
foreach var of varlist hl6 hhhl6 rm1 rm2 sn3 {
	recode `var' (9 = .)
	}
recode rm1 (. = 2)
recode rm5 (9999 = .)
* "Fix" remittances variables
gen rm3 = 0 if rm1 != .
replace rm3 = 1 if rm3a == "A" | rm3b == "B" | rm3c == "C" 
replace rm3 = 2 if rm3 == 0 & rm3d == "D" 
replace rm3 = 3 if rm3 == 1 & rm3d == "D"
label define destination 0 "none" 1 "domestic only" 2 "international only" 3 "domestic & international"
label values rm3 destination
label define yesno 0 "no" 1 "yes"
gen rm4_01 = 0 if rm4 != .
replace rm4_01 = 1 if rm4 == 1
label values rm4_01 yesno
foreach var of varlist rm5 rm5a {
	replace `var' = 0 if `var' == . & rm4 == 2
	recode `var' (9999999 = .)
	recode `var' (9999998 = .)
	}
gen rm6 = rm5 + rm5a
lab var rm6 "total domestic and international remittances"
* Define separate indicators for domestic and overseas remittances
gen rm4a = 0 if rm4 == 1 | rm4 == 2
replace rm4a = 1 if rm5 > 0 
label var rm4a "hh received remittances from inside the country"
label values rm4a yesno
gen rm4b = 0 if rm4 == 1 | rm4 == 2
replace rm4b = 1 if rm5a > 0 
label var rm4b "hh received remittances from overseas"
label values rm4b yesno
* Create categories for age of head 
egen hhhl6cat = cut(hhhl6), at(14, 25, 35, 45, 55, 65, 99, 100)
lab define hhhl6 14 "under 25" 25 "25-34" 35 "35-44" 45 "45-54" 55 "55-64" 65 "65+" 99 "missing"
lab values hhhl6cat hhhl6
gen hhhl6sq = hhhl6^2
* Recode a bunch of type and category variables
replace cl4 = 0 if cl2a == 2 & cl2b == 2 & cl2c == 2 & cl2d == 2
replace cl5 = 0 if cl2a == 2 & cl2b == 2 & cl2c == 2 & cl2d == 2
replace cl6 = 0 if cl2a == 2 & cl2b == 2 & cl2c == 2 & cl2d == 2
foreach var of varlist cl7a cl7b cl7c cl7d cl7e cl7f {
	replace `var' = 2 if `var' == . & cl2a != .
	}
replace cl9 = 0 if cl8 == 2
label define cd3 1 "yes" 2 "no" 3 "no children in hh" 8 "dk/no opinion" 9 "missing" 
foreach var of varlist cd3a cd3b cd3c cd3d cd3e cd3f cd3g cd3h cd3i cd3j cd3k {
	replace `var' = 3 if sl1 == 0
	label values `var' cd3
	}
gen cd3x = cd3f
lab val cd3x cd3
replace cd3x = 1 if cd3g == 1 | cd3i == 1 | cd3j == 1 | cd3k == 1 
replace cd4 = 3 if sl1 == 0
label values cd4 cd3
recode hc1b (9 = 6)
recode hc9b (9 = 2)
foreach var of varlist ws7a ws7b ws7c ws7d ws7e ws7f ws7x ws7z {
	replace `var' = "0" if `var' == "" & ws6 != .
	}
replace ws10 = 0 if ws10 == . & ws9 == 1
replace ws11 = 0 if ws11 == . & ws9 == 1
replace rm2 = 0 if rm2 == . & rm1 == 2 
foreach var of varlist rm3a rm3b rm3c rm3d rm3z { 
	replace `var' = "0" if `var' == "" & rm1 != .
	}
foreach var of varlist pb2a pb2b pb2x pb2z{
	replace `var' = "0" if `var' == "" & pb1 == 2
	}
recode sn1 (9 = 2)
recode sn1 (8 = 2)
foreach var of varlist sn2a sn2b sn2c sn2d sn2e sn2x sn2z {
	replace `var' = "0" if `var' == "" & sn1 == 2
	}
recode sn4 (9999999 = .)
replace sn4 = 0 if sn4 == . & sn3 == 2
replace sn7 = 0 if sn7 == . & sn6 == 2
foreach var of varlist hw3ba hw3bb hw3bc hw3bd {
	replace `var' = "0" if `var' == "" & hw3a != .
	}
foreach var of varlist hw5ba hw5bb hw5bc hw5bd {
	replace `var' = "0" if `var' == "" & hw5a != .
	}
gen hl3w = hl3
	replace hl3w = 5 if hl3 > 4
	lab define hl3w 1 "head" 2 "wife" 3 "daughter" 4 "daughter-in-law" 5 "other"
	lab values hl3w hl3w
	lab var hl3w "relationship to the head (collapsed)"
foreach var of varlist hl10ba hl10bb hl10bc hl10bd hl10bx hl10bz {
	replace `var' = "0" if `var' == "" & hl10a != .
	}
foreach var of varlist hl10da hl10db hl10dc hl10dd hl10dx hl10dz {
	replace `var' = "0" if `var' == "" & hl10c != .
	}
replace ed4a = 0 if ed3 == 2
replace ed4b = 0 if ed3 == 2 
gen ed4x = 0 if ed4a == 0
replace ed4x = ed4b if ed4a == 1 & ed4b <= 7
replace ed4x = ed4b + 5 if ed4a == 2 & ed4b <= 7
replace ed4x = ed4b + 8 if ed4a == 3 & ed4b <= 7
replace ed4x = ed4b + 10 if ed4a == 4 & ed4b <= 7
replace hhed4a = 0 if hhed3 == 2
replace hhed4b = 0 if hhed3 == 2
gen hhed4x = 0 if hhed4a == 0
replace hhed4x = hhed4b if hhed4a == 1 & hhed4b <= 7
replace hhed4x = hhed4b + 5 if hhed4a == 2 & hhed4b <= 7
replace hhed4x = hhed4b + 8 if hhed4a == 3 & hhed4b <= 7
replace hhed4x = hhed4b + 10 if hhed4a == 4 & hhed4b <= 7
* Recode missings as "missing" for categoricals. 
foreach var of varlist rm4 division hh14 cd3x cd4 hc1b pb1 sn1 sn3 helevel {
	recode `var' (. = 9)
	}
* Collapse work status categories. 
gen ie3_012 = 0 if ie3 != .
replace ie3_012 = 1 if ie3 == 10 | ie3 == 21 | ie3 == 22 | ie3 == 23 | ie3 == 24 | ie3 == 25 | ie3 == 95
replace ie3_012 = 2 if ie3 == 11 | ie3 == 26
lab define ie3_012 0 "employed" 1 "housewife/not employed" 2 "student" 
lab values ie3_012 ie3_012
gen hhie3_012 = 0 if hhie3 != .
replace hhie3_012 = 1 if hhie3 == 3 | hhie3 == 4 | hhie3 == 6 | hhie3 == 7 | hhie3 == 8 
replace hhie3_012 = 2 if hhie3 == 10 | hhie3 == 11 | hhie3 == 21 | hhie3 == 22 | hhie3 == 23 | hhie3 == 24 | hhie3 == 25 | hhie3 == 26 | hhie3 == 95
lab define hhie3_012 0 "employed" 1 "self-employed" 2 "not employed/student" 
lab values hhie3_012 hhie3_012
gen long uniqueid = 10000*hh1 + 100*hh2 + ln
replace uniqueid = _n*100 if uniqueid == .
egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
cd "D:\Google Drive\Research - Immigration\Remittances&ChildLabor"
save "MergedData.dta", replace
