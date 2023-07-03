* "Our definition of child labour follows the ILO definition, in particular the ILO Conventions C138 and ///
* C182, and results in a binary indicator...all children working in hazardous occupations are automatically ///
* classified as child labourers. In our data, these are mostly jobs in the dangerous production of glass ///
* bangles, and to a lesser extent welding and mechanics work. Second, if children work in a non-hazardous ///
* occupation, the definition depends on age and number of hours worked: Children below 12 years who work ///
* more than one hour per week, children 12 to 13 who work more than 14 hours per week and juveniles 14 to ///
* 17 who work more than 43 hours are classified as child labourers. Hours of work also include hours worked ///
* at home, which is especially important for girls. Note that in our sample we only include children five ///
* years or older as potential child labourers."
cd  "D:\Google Drive\Research - Immigration\Remittances&ChildLabor\"
capture log close

log using ChildLaborILO, replace 
use "MergedData.dta", clear
keep if sl9c != . & sl9c >= 5
capture drop cl1sample
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLaborILO = 0 
replace ChildLaborILO = 1 if sl9c <  12 & TotalHours > 1
replace ChildLaborILO = 1 if sl9c <= 13 & TotalHours > 14
replace ChildLaborILO = 1 if TotalHours >  43
replace ChildLaborILO = 1 if cl6  == 1 | cl5 == 1
capture gen ChildLabor20 = 0 
replace ChildLabor20 = 1 if TotalHours > 20
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
capture gen ChildIncome = 0 
replace ChildIncome = 1 if cl4 > 0 & cl4 != .
capture gen ChildHazard = 0 
replace ChildHazard = 1 if cl6  == 1 | cl5 == 1
capture gen ChildChores = 0 
replace ChildChores = 1 if cl12 > 0 & cl12 != .
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
save "MergedData.dta", replace
logit ChildLaborILO rm4_01 sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix01, excel ctitle("Unbalanced - All") replace
margins, post dydx(rm4_01) 
outreg2 using Table02, excel ctitle("Unbalanced - All") replace
logit ChildLaborILO rm4b sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix01, excel ctitle("Unbalanced - Abroad")
margins, post dydx(rm4b) 
outreg2 using Table02, excel ctitle("Unbalanced - Abroad")
logit ChildLaborILO rm4a sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix01, excel ctitle("Unbalanced - Domestic")
margins, post dydx(rm4a) 
outreg2 using Table02, excel ctitle("Unbalanced - Domestic")
logit ChildLaborILO rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix02, excel ctitle("Unbalanced - All") replace
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using Table03, excel ctitle("Unbalanced - All") replace
logit ChildLaborILO rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix02, excel ctitle("Unbalanced - Abroad")
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using Table03, excel ctitle("Unbalanced - Abroad")
logit ChildLaborILO rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix02, excel ctitle("Unbalanced - Domestic")
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using Table03, excel ctitle("Unbalanced - Domestic")
logit ChildLaborILO rm4_01##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix03, excel ctitle("Unbalanced - All") replace
margins, post dydx(rm4_01) over(hl4)
outreg2 using Table04, excel ctitle("Unbalanced - All") replace
logit ChildLaborILO rm4b##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix03, excel ctitle("Unbalanced - Abroad")
margins, post dydx(rm4b) over(hl4)
outreg2 using Table04, excel ctitle("Unbalanced - Abroad")
logit ChildLaborILO rm4a##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix03, excel ctitle("Unbalanced - Domestic")
margins, post dydx(rm4a) over(hl4)
outreg2 using Table04, excel ctitle("Unbalanced - Domestic")
logit ChildLaborILO rm4_01##hl4 rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix04, excel ctitle("Unbalanced - All") replace
margins, post dydx(rm4_01) over(hl4 sl9c_cats)
outreg2 using Table05, excel ctitle("Unbalanced - All") replace
logit ChildLaborILO rm4b##hl4 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix04, excel ctitle("Unbalanced - Abroad")
margins, post dydx(rm4b) over(hl4 sl9c_cats)
outreg2 using Table05, excel ctitle("Unbalanced - Abroad")
logit ChildLaborILO rm4a##hl4 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
outreg2 using Appendix04, excel ctitle("Unbalanced - Domestic")
margins, post dydx(rm4a) over(hl4 sl9c_cats)
outreg2 using Table05, excel ctitle("Unbalanced - Domestic")
logit ChildLabor20 rm4_01 sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4_01) 
outreg2 using Appendix06, excel ctitle("Unbalanced - All") replace
logit ChildLabor20 rm4b sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4b) 
outreg2 using Appendix06, excel ctitle("Unbalanced - Abroad")
logit ChildLabor20 rm4a sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4a) 
outreg2 using Appendix06, excel ctitle("Unbalanced - Domestic")
logit ChildLabor20 rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using Appendix07, excel ctitle("Unbalanced - All") replace
logit ChildLabor20 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using Appendix07, excel ctitle("Unbalanced - Abroad")
logit ChildLabor20 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using Appendix07, excel ctitle("Unbalanced - Domestic")
logit ChildLabor20 rm4_01##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4_01) over(hl4)
outreg2 using Appendix08, excel ctitle("Unbalanced - All") replace
logit ChildLabor20 rm4b##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4b) over(hl4)
outreg2 using Appendix08, excel ctitle("Unbalanced - Abroad")
logit ChildLabor20 rm4a##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4a) over(hl4)
outreg2 using Appendix08, excel ctitle("Unbalanced - Domestic")
logit ChildLabor20 rm4_01##hl4 rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4_01) over(hl4 sl9c_cats)
outreg2 using Appendix09, excel ctitle("Unbalanced - All") replace
logit ChildLabor20 rm4b##hl4 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4b) over(hl4 sl9c_cats)
outreg2 using Appendix09, excel ctitle("Unbalanced - Abroad")
logit ChildLabor20 rm4a##hl4 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != ., asis
margins, post dydx(rm4a) over(hl4 sl9c_cats)
outreg2 using Appendix09, excel ctitle("Unbalanced - Domestic")
reg TotalHours rm4_01 sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4_01) 
outreg2 using Appendix10, excel ctitle("Unbalanced - All") replace
reg TotalHours rm4b sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4b) 
outreg2 using Appendix10, excel ctitle("Unbalanced - Abroad")
reg TotalHours rm4a sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4a) 
outreg2 using Appendix10, excel ctitle("Unbalanced - Domestic")
reg TotalHours rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using Appendix11, excel ctitle("Unbalanced - All") replace
reg TotalHours rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using Appendix11, excel ctitle("Unbalanced - Abroad")
reg TotalHours rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using Appendix11, excel ctitle("Unbalanced - Domestic")
reg TotalHours rm4_01##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4_01) over(hl4)
outreg2 using Appendix12, excel ctitle("Unbalanced - All") replace
reg TotalHours rm4b##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4b) over(hl4)
outreg2 using Appendix12, excel ctitle("Unbalanced - Abroad")
reg TotalHours rm4a##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4a) over(hl4)
outreg2 using Appendix12, excel ctitle("Unbalanced - Domestic")
reg TotalHours rm4_01##hl4 rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4_01) over(hl4 sl9c_cats)
outreg2 using Appendix13, excel ctitle("Unbalanced - All") replace
reg TotalHours rm4b##hl4 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4b) over(hl4 sl9c_cats)
outreg2 using Appendix13, excel ctitle("Unbalanced - Abroad")
reg TotalHours rm4a##hl4 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight] if hhhl6cat != .
margins, post dydx(rm4a) over(hl4 sl9c_cats)
outreg2 using Appendix13, excel ctitle("Unbalanced - Domestic")

use "match3stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLaborILO = 0 
replace ChildLaborILO = 1 if sl9c <  12 & TotalHours > 1
replace ChildLaborILO = 1 if sl9c <= 13 & TotalHours > 14
replace ChildLaborILO = 1 if TotalHours >  43
replace ChildLaborILO = 1 if cl6  == 1 | cl5 == 1
capture gen ChildLabor20 = 0 
replace ChildLabor20 = 1 if TotalHours > 20
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
capture gen ChildIncome = 0 
replace ChildIncome = 1 if cl4 > 0 & cl4 != .
capture gen ChildHazard = 0 
replace ChildHazard = 1 if cl6  == 1 | cl5 == 1
capture gen ChildChores = 0 
replace ChildChores = 1 if cl12 > 0 & cl12 != .
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
save "match3stackedPairs.dta", replace
logit ChildLaborILO rm4_01 sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix01, excel ctitle("Balanced - All")
margins, post dydx(rm4_01) 
outreg2 using Table02, excel ctitle("Balanced - All")
logit ChildLaborILO rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix02, excel ctitle("Balanced - All")
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using Table03, excel ctitle("Balanced - All")
logit ChildLaborILO rm4_01##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix03, excel ctitle("Balanced - All")
margins, post dydx(rm4_01) over(hl4)
outreg2 using Table04, excel ctitle("Balanced - All")
logit ChildLaborILO rm4_01##hl4 rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix04, excel ctitle("Balanced - All")
margins, post dydx(rm4_01) over(hl4 sl9c_cats)
outreg2 using Table05, excel ctitle("Balanced - All")
capture erase "Appendix10.txt"
capture erase "Appendix10.xml"
capture erase "Table06.txt"
capture erase "Table06.xml"
foreach var in ChildIncome ChildHazard ChildChores {
logit `var' rm4_01##hl4 rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix05, excel ctitle(`var'_All)
margins, post dydx(rm4_01) over(sl9c_cats hl4)
outreg2 using Table06, excel ctitle(`var'_All)
}
logit ChildLabor20 rm4_01 sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4_01) 
outreg2 using Appendix06, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using Appendix07, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4_01##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4_01) over(hl4)
outreg2 using Appendix08, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4_01##hl4 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4_01) over(hl4 sl9c_cats)
outreg2 using Appendix09, excel ctitle("Balanced - Domestic")
reg TotalHours rm4_01 sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4_01) 
outreg2 using Appendix10, excel ctitle("Balanced - Domestic")
reg TotalHours rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using Appendix11, excel ctitle("Balanced - Domestic")
reg TotalHours rm4_01##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4_01) over(hl4)
outreg2 using Appendix12, excel ctitle("Balanced - Domestic")
reg TotalHours rm4_01##hl4 rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4_01) over(hl4 sl9c_cats)
outreg2 using Appendix13, excel ctitle("Balanced - Domestic")

use "match2stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLaborILO = 0 
replace ChildLaborILO = 1 if sl9c <  12 & TotalHours > 1
replace ChildLaborILO = 1 if sl9c <= 13 & TotalHours > 14
replace ChildLaborILO = 1 if TotalHours >  43
replace ChildLaborILO = 1 if cl6  == 1 | cl5 == 1
capture gen ChildLabor20 = 0 
replace ChildLabor20 = 1 if TotalHours > 20
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
capture gen ChildIncome = 0 
replace ChildIncome = 1 if cl4 > 0 & cl4 != .
capture gen ChildHazard = 0 
replace ChildHazard = 1 if cl6  == 1 | cl5 == 1
capture gen ChildChores = 0 
replace ChildChores = 1 if cl12 > 0 & cl12 != .
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
save "match2stackedPairs.dta", replace
logit ChildLaborILO rm4b sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix01, excel ctitle("Balanced - Abroad")
margins, post dydx(rm4b) 
outreg2 using Table02, excel ctitle("Balanced - Abroad")
logit ChildLaborILO rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix02, excel ctitle("Balanced - Abroad")
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using Table03, excel ctitle("Balanced - Abroad")
logit ChildLaborILO rm4b##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix03, excel ctitle("Balanced - Abroad")
margins, post dydx(rm4b) over(hl4)
outreg2 using Table04, excel ctitle("Balanced - Abroad")
logit ChildLaborILO rm4b##hl4 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix04, excel ctitle("Balanced - Abroad")
margins, post dydx(rm4b) over(hl4 sl9c_cats)
outreg2 using Table05, excel ctitle("Balanced - Abroad")
foreach var in ChildIncome ChildHazard ChildChores {
logit `var' rm4b##hl4 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix05, excel ctitle(`var'_Abroad)
margins, post dydx(rm4b) over(sl9c_cats hl4)
outreg2 using Table06, excel ctitle(`var'_Abroad)
}
logit ChildLabor20 rm4b sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4b) 
outreg2 using Appendix06, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using Appendix07, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4b##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4b) over(hl4)
outreg2 using Appendix08, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4b##hl4 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4b) over(hl4 sl9c_cats)
outreg2 using Appendix09, excel ctitle("Balanced - Domestic")
reg TotalHours rm4b sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4b) 
outreg2 using Appendix10, excel ctitle("Balanced - Domestic")
reg TotalHours rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using Appendix11, excel ctitle("Balanced - Domestic")
reg TotalHours rm4b##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4b) over(hl4)
outreg2 using Appendix12, excel ctitle("Balanced - Domestic")
reg TotalHours rm4b##hl4 rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4b) over(hl4 sl9c_cats)
outreg2 using Appendix13, excel ctitle("Balanced - Domestic")

use "match1stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLaborILO = 0 
replace ChildLaborILO = 1 if sl9c <  12 & TotalHours > 1
replace ChildLaborILO = 1 if sl9c <= 13 & TotalHours > 14
replace ChildLaborILO = 1 if TotalHours >  43
replace ChildLaborILO = 1 if cl6  == 1 | cl5 == 1
capture gen ChildLabor20 = 0 
replace ChildLabor20 = 1 if TotalHours > 20
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
capture gen ChildIncome = 0 
replace ChildIncome = 1 if cl4 > 0 & cl4 != .
capture gen ChildHazard = 0 
replace ChildHazard = 1 if cl6  == 1 | cl5 == 1
capture gen ChildChores = 0 
replace ChildChores = 1 if cl12 > 0 & cl12 != .
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
save "match1stackedPairs.dta", replace
logit ChildLaborILO rm4a sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix01, excel ctitle("Balanced - Domestic")
margins, post dydx(rm4a) 
outreg2 using Table02, excel ctitle("Balanced - Domestic")
logit ChildLaborILO rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix02, excel ctitle("Balanced - Domestic")
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using Table03, excel ctitle("Balanced - Domestic")
logit ChildLaborILO rm4a##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix03, excel ctitle("Balanced - Domestic")
margins, post dydx(rm4a) over(hl4)
outreg2 using Table04, excel ctitle("Balanced - Domestic")
logit ChildLaborILO rm4a##hl4 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix04, excel ctitle("Balanced - Domestic")
margins, post dydx(rm4a) over(hl4 sl9c_cats)
outreg2 using Table05, excel ctitle("Balanced - Domestic")
foreach var in ChildIncome ChildHazard ChildChores {
logit `var' rm4a##hl4 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using Appendix05, excel ctitle(`var'_Domestic)
margins, post dydx(rm4a) over(sl9c_cats hl4)
outreg2 using Table06, excel ctitle(`var'_Domestic)
}
logit ChildLabor20 rm4a sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4a) 
outreg2 using Appendix06, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using Appendix07, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4a##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4a) over(hl4)
outreg2 using Appendix08, excel ctitle("Balanced - Domestic")
logit ChildLabor20 rm4a##hl4 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4a) over(hl4 sl9c_cats)
outreg2 using Appendix09, excel ctitle("Balanced - Domestic")
reg TotalHours rm4a sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4a) 
outreg2 using Appendix10, excel ctitle("Balanced - Domestic")
reg TotalHours rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using Appendix11, excel ctitle("Balanced - Domestic")
reg TotalHours rm4a##hl4 sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4a) over(hl4)
outreg2 using Appendix12, excel ctitle("Balanced - Domestic")
reg TotalHours rm4a##hl4 rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
margins, post dydx(rm4a) over(hl4 sl9c_cats)
outreg2 using Appendix13, excel ctitle("Balanced - Domestic")

log close
