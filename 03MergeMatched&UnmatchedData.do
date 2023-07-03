cd "D:\Google Drive\Research - Immigration\Remittances&ChildLabor\"
use "match1stackedPairs.dta", clear
capture gen matchsample1 = 1
save "match1stackedPairs.dta", replace
use "match2stackedPairs.dta", clear
capture gen matchsample2 = 1
save "match2stackedPairs.dta", replace
use "match3stackedPairs.dta", clear
capture gen matchsample3 = 1
save "match3stackedPairs.dta", replace
* use "MergedData.dta", clear
* merge 1:1 hh1 hh2 using "match3stackedPairs.dta", keep(master) generate(_mergeTreateds)
* replace matchsample = 0 if sample == .
* save "MergedData.dta", replace 
