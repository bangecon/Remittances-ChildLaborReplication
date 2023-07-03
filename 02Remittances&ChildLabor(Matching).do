cd "D:\Google Drive\Research - Immigration\Remittances&ChildLabor"
use "MergedData.dta", clear
set more off
compress

capture drop _prime_id
capture drop DomesticVsNone
capture drop OverseasVsNone
capture drop cl1sample
gen long _prime_id = uniqueid
gen DomesticVsNone = (rm4a == 1 | rm4_01 == 0)
gen OverseasVsNone = (rm4b == 1 | rm4_01 == 0)
quietly reg cl12 rm4_01 sl9c hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 
gen cl1sample = e(sample)
capture drop match* 
capture erase "match1.dta"
capture erase "match2.dta"
capture erase "match3.dta"
capture log close 

* Distance match on Head's age and education, and on household size; 
* Exact match on other remittances, head wealth quintile, urban/rural, gov. benefits, language, division

*Domestic Remittances 
gen long match1 = .
display "$S_TIME"
mahapick hhsize, idvar(uniqueid) treated(rm4a) pickids(match1) genfile(match1) ///
	matchon(hhsex hc9b hhie3_012 hhed4a hhhl6cat windex5 sl9c_cats DomesticVsNone cl1sample) score
display "$S_TIME"
save "MergedData.dta", replace
use "match1.dta", clear
bysort _prime_id: egen nmatches = max(_matchnum)
drop if nmatches == 0
save "match1allmatches.dta", replace
drop if _matchnum == 0
merge m:1 uniqueid using "MergedData.dta", keep(master match) 
gen remit_domestic = 0
gen sample1 = 1
capture drop _merge
gen obs = 2*_n
save "match1controls.dta", replace
use "match1allmatches.dta", clear
drop if _matchnum == 0
merge m:m _prime_id using "MergedData.dta", keep(master match)
gen remit_domestic = 1
gen sample1 = 1
capture drop _merge
gen obs = 2*_n - 1
save "match1treateds.dta", replace
append using match1controls
save "match1stackedPairs.dta", replace
use "match1treateds.dta", clear
foreach var of varlist cl1sample rm4 rm4a rm4b ed4a ed4b ed4x ie3_012 windex5 sn1 sn3 hc1b helevel ///
	hh7 hhwindex5 division hh11 hhsize hhed4a hhed4b hhed4x hhhl6 hhhl6sq hhhl6cat wscore hh1 hh2 ///
	hl3w hhwscore rm1 hhsex {
	ren `var' `var'_treated
	}
merge 1:1 _prime_id using match1controls
foreach var of varlist cl1sample rm4 rm4a rm4b ed4a ed4b ed4x ie3_012 windex5 sn1 sn3 hc1b helevel ///
	hh7 hhwindex5 division hh11 hhsize hhed4a hhed4b hhed4x hhhl6 hhhl6sq hhhl6cat wscore hh1 hh2 ///
	hl3w hhwscore rm1 hhsex {
	ren `var' `var'_control
	gen `var'_diff = `var'_treated - `var'_control
	}
capture drop _merge
save "match1matchedPairs.dta", replace

*Overseas Remittances
use "MergedData.dta", clear
gen long match2 = .
display "$S_TIME"
mahapick hhsize, idvar(uniqueid) treated(rm4b) pickids(match2) genfile(match2) ///
	matchon(hhsex hc9b hhie3_012 hhed4a hhhl6cat windex5 sl9c_cats OverseasVsNone cl1sample) score
display "$S_TIME"
save "MergedData.dta", replace
use "match2.dta", clear
bysort _prime_id: egen nmatches = max(_matchnum)
drop if nmatches == 0
save "match2allmatches.dta", replace
drop if _matchnum == 0
merge m:1 uniqueid using "MergedData.dta", keep(master match) 
gen remit_domestic = 0
gen sample1 = 1
capture drop _merge
gen obs = 2*_n
save "match2controls.dta", replace
use "match2allmatches.dta", clear
drop if _matchnum == 0
merge m:m _prime_id using "MergedData.dta", keep(master match)
gen remit_overseas = 1
gen sample1 = 1
capture drop _merge
gen obs = 2*_n - 1
save "match2treateds.dta", replace
append using match2controls
save "match2stackedPairs.dta", replace
use "match2treateds.dta", clear
foreach var of varlist cl1sample rm4 rm4a rm4b ed4a ed4b ed4x ie3_012 windex5 sn1 sn3 hc1b helevel ///
	hh7 hhwindex5 division hh11 hhsize hhed4a hhed4b hhed4x hhhl6 hhhl6sq hhhl6cat wscore hh1 hh2 ///
	hl3w hhwscore rm1 hhsex {
	ren `var' `var'_treated
	}
merge 1:1 _prime_id using match2controls
foreach var of varlist cl1sample rm4 rm4a rm4b ed4a ed4b ed4x ie3_012 windex5 sn1 sn3 hc1b helevel ///
	hh7 hhwindex5 division hh11 hhsize hhed4a hhed4b hhed4x hhhl6 hhhl6sq hhhl6cat wscore hh1 hh2 ///
	hl3w hhwscore rm1 hhsex {
	ren `var' `var'_control
	gen `var'_diff = `var'_treated - `var'_control
	}
capture drop _merge
save "match2matchedPairs.dta", replace

* Any Remittances 
use "MergedData.dta", clear
gen long match3 = .
display "$S_TIME"
mahapick hhsize, idvar(uniqueid) treated(rm4_01) pickids(match3) genfile(match3) ///
	matchon(hhsex hc9b hhie3_012 hhed4a hhhl6cat windex5 sl9c_cats cl1sample) score
display "$S_TIME"
save "MergedData.dta", replace
use "match3.dta", clear
bysort _prime_id: egen nmatches = max(_matchnum)
drop if nmatches == 0
save "match3allmatches.dta", replace
drop if _matchnum == 0
merge m:1 uniqueid using "MergedData.dta", keep(master match) 
gen remit_domestic = 0
gen sample1 = 1
capture drop _merge
gen obs = 2*_n
save "match3controls.dta", replace
use "match3allmatches.dta", clear
drop if _matchnum == 0
merge m:m _prime_id using "MergedData.dta", keep(master match)
gen remit_any = 1
gen sample1 = 1
capture drop _merge
gen obs = 2*_n - 1
save "match3treateds.dta", replace
append using match3controls
save "match3stackedPairs.dta", replace
use "match3treateds.dta", clear
foreach var of varlist cl1sample rm4 rm4a rm4b ed4a ed4b ed4x ie3_012 windex5 sn1 sn3 hc1b helevel ///
	hh7 hhwindex5 division hh11 hhsize hhed4a hhed4b hhed4x hhhl6 hhhl6sq hhhl6cat wscore hh1 hh2 ///
	hl3w hhwscore rm1 hhsex {
	ren `var' `var'_treated
	}
merge 1:1 _prime_id using match3controls
foreach var of varlist cl1sample rm4 rm4a rm4b ed4a ed4b ed4x ie3_012 windex5 sn1 sn3 hc1b helevel ///
	hh7 hhwindex5 division hh11 hhsize hhed4a hhed4b hhed4x hhhl6 hhhl6sq hhhl6cat wscore hh1 hh2 ///
	hl3w hhwscore rm1 hhsex {
	ren `var' `var'_control
	gen `var'_diff = `var'_treated - `var'_control
	}
capture drop _merge
save "match3matchedPairs.dta", replace
