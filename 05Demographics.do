cd "D:\Google Drive\Research - Immigration\Remittances&ChildLabor"
use "MergedData.dta", clear
set more off
compress
capture drop _prime_id
capture drop DomesticVsNone OverseasVsNone
capture drop cl1sample
gen long _prime_id = uniqueid
gen DomesticVsNone = (rm4a == 1 | rm4_01 == 0)
gen OverseasVsNone = (rm4b == 1 | rm4_01 == 0)
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLaborILO = 0 
replace ChildLaborILO = 1 if sl9c <  12 & TotalHours > 1
replace ChildLaborILO = 1 if sl9c <= 13 & TotalHours > 14
replace ChildLaborILO = 1 if TotalHours >  43
replace ChildLaborILO = 1 if cl6  == 1 | cl5 == 1
capture gen ChildLabor20 = 0 
replace ChildLabor20 = 1 if TotalHours >  20
replace ChildLabor20 = 1 if cl6  == 1 | cl5 == 1
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
quietly logit ChildLaborILO hh14 sl1 hh11 sl9a ed4x wscore hhsize rm4_01 sl9c_cats hl4 hl11 hl13 sn1 sn3 ///
hhsex hc9b hhie3_012 hhed4a hhhl6cat windex5 sl9c_cats, asis
gen cl1sample = e(sample)
save "MergedData.dta", replace
keep if cl1sample == 1
capture log close 

log using "Remittances&DomesticViolenceDemographicsTable.log", text replace
quietly: reg ChildLaborILO hh14 sl1 hh11 sl9a ed4x wscore hhsize 
outreg2 using Demographics, replace excel sum ctitle("Full Sample")
outreg2 ChildLaborILO cl1sample using DemographicsTabs1, replace label excel cross 
foreach var of varlist ChildLabor20 rm4_01 sl9c_cats hl4 hl11 hl13 sn1 sn3 hhsex hc9b /// 
hhie3_012 hhed4a hhhl6cat windex5 {
  outreg2 `var' cl1sample using DemographicsTabs1, label excel cross ctitle(`var')
  }
quietly: reg ChildLaborILO hh14 sl1 hh11 sl9a ed4x wscore hhsize if rm4_01 == 1
outreg2 using Demographics, excel sum ctitle("Remittance-Receiving Households")
quietly: reg ChildLaborILO hh14 sl1 hh11 sl9a ed4x wscore hhsize if cl1sample == 1 & rm4_01 == 0
outreg2 using Demographics, excel sum ctitle("Non-Receiving Households")
outreg2 ChildLaborILO rm4_01 using DemographicsTabs1, label excel cross ctitle(read30_01)
outreg2 ChildLabor20 rm4_01 using DemographicsTabs1, label excel cross ctitle(read30_01)
foreach var of varlist ChildLaborILO ChildLabor20 rm4_01 sl9c_cats hl4 hl11 hl13 sn1 sn3 hhsex hc9b /// 
hhie3_012 hhed4a hhhl6cat windex5 {
  outreg2 `var' rm4_01 using DemographicsTabs1, label excel cross ctitle(`var')
  }
  
use "match3stackedPairs.dta", clear
capture gen sample = 1
capture drop cl1sample
quietly logit ChildLaborILO hh14 sl1 hh11 sl9a ed4x wscore hhsize rm4_01 sl9c_cats hl4 hl11 hl13 sn1 sn3 ///
hhsex hc9b hhie3_012 hhed4a hhhl6cat windex5 sl9c_cats, asis
gen cl1sample = e(sample)
keep if cl1sample == 1
quietly: reg ChildLaborILO hh14 sl1 hh11 sl9a ed4x wscore hhsize if rm4_01 == 1
outreg2 using Demographics, excel sum ctitle("Remittance-Receiving Households")
quietly: reg ChildLaborILO hh14 sl1 hh11 sl9a ed4x wscore hhsize if cl1sample == 1 & rm4_01 == 0
outreg2 using Demographics, excel sum ctitle("Non-Receiving Households")
outreg2 ChildLaborILO rm4_01 using DemographicsTabs1, label excel cross ctitle(read30_01)
outreg2 rm4_01 using DemographicsTabs1, label excel cross ctitle(read30_01)
foreach var of varlist ChildLabor20 rm4_01 sl9c_cats hl4 hl11 hl13 sn1 sn3 hhsex hc9b /// 
hhie3_012 hhed4a hhhl6cat windex5 {
  outreg2 `var' rm4_01 using DemographicsTabs1, label excel cross ctitle(`var')
  }
log close 

