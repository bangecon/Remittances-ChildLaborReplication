* "Our definition of child labour follows the ILO definition, in particular the ILO Conventions C138 and ///
* C182, and results in a binary indicator...all children working in hazardous occupations are automatically ///
* classified as child labourers. In our data, these are mostly jobs in the dangerous production of glass ///
* bangles, and to a lesser extent welding and mechanics work. Second, if children work in a non-hazardous ///
* occupation, the definition depends on age and number of hours worked: Children below 12 years who work ///
* more than one hour per week, children 12 to 13 who work more than 14 hours per week and juveniles 14 to ///
* 17 who work more than 43 hours are classified as child labourers. Hours of work also include hours worked ///
* at home, which is especially important for girls. Note that in our sample we only include children five ///
* years or older as potential child labourers."
cd  "C:\Users\jb0616165\Google Drive\Research - Immigration\Remittances&ChildLabor\"
capture log close
capture erase "LaborTypesUnbalanced.xml"
capture erase "LaborTypesUnbalancedMargins.xml"
capture erase "LaborTypesUnbalancedMarginsRM.xml"
capture erase "LaborTypesUnbalanced.txt"
capture erase "LaborTypesUnbalancedMargins.txt"
capture erase "LaborTypesUnbalancedMarginsRM.txt"
capture erase "LaborTypesBalanced.xml"
capture erase "LaborTypesBalancedMargins.xml"
capture erase "LaborTypesBalancedMarginsRM.xml"
capture erase "LaborTypesBalanced.txt"
capture erase "LaborTypesBalancedMargins.txt"
capture erase "LaborTypesBalancedMarginsRM.txt"

log using ChildLaborCats, replace 
use "MergedData.dta", clear
capture gen ChildIncome = 0 
replace ChildIncome = 1 if cl4 > 0 & cl4 != .
capture gen ChildHazard = 0 
replace ChildHazard = 1 if cl6  == 1 | cl5 == 1
capture gen ChildChores = 0 
replace ChildChores = 1 if cl12 > 0 & cl12 != .
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
capture erase UnbalancedSample4.xml
foreach var in ChildIncome ChildHazard ChildChores {
logit `var' rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using LaborTypesUnbalanced, excel ctitle(`var')
margins, post dydx(_all) 
outreg2 using LaborTypesUnbalancedMargins, excel ctitle(`var')
quietly logit `var' rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using LaborTypesUnbalancedMarginsRM, excel ctitle(`var')
logit `var' rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using LaborTypesUnbalanced, excel ctitle("Domestic")
margins, post dydx(_all) 
outreg2 using LaborTypesUnbalancedMargins, excel ctitle("Domestic")
quietly logit `var' rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using LaborTypesUnbalancedMarginsRM, excel ctitle("Domestic")
logit `var' rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using LaborTypesUnbalanced, excel ctitle("Abroad") 
margins, post dydx(_all) 
outreg2 using LaborTypesUnbalancedMargins, excel ctitle("Abroad")
quietly logit `var' rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using LaborTypesUnbalancedMarginsRM, excel ctitle("Abroad")
}

use "match3stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen ChildIncome = 0 
replace ChildIncome = 1 if cl4 > 0 & cl4 != .
capture gen ChildHazard = 0 
replace ChildHazard = 1 if cl6  == 1 | cl5 == 1
capture gen ChildChores = 0 
replace ChildChores = 1 if cl12 > 0 & cl12 != .
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
foreach var in ChildIncome ChildHazard ChildChores {
logit `var' rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using LaborTypesBalanced, excel ctitle(`var')
margins, post dydx(_all) 
outreg2 using LaborTypesBalancedMargins, excel ctitle(`var')
quietly logit `var' rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using LaborTypesBalancedMarginsRM, excel ctitle(`var')
}

use "match2stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen ChildIncome = 0 
replace ChildIncome = 1 if cl4 > 0 & cl4 != .
capture gen ChildHazard = 0 
replace ChildHazard = 1 if cl6  == 1 | cl5 == 1
capture gen ChildChores = 0 
replace ChildChores = 1 if cl12 > 0 & cl12 != .
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
foreach var in ChildIncome ChildHazard ChildChores {
logit `var' rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using LaborTypesBalanced, excel ctitle("International")
margins, post dydx(_all) 
outreg2 using LaborTypesBalancedMargins, excel ctitle("International")
quietly logit `var' rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using LaborTypesBalancedMarginsRM, excel ctitle("International")
}

use "match1stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen ChildIncome = 0 
replace ChildIncome = 1 if cl4 > 0 & cl4 != .
capture gen ChildHazard = 0 
replace ChildHazard = 1 if cl6  == 1 | cl5 == 1
capture gen ChildChores = 0 
replace ChildChores = 1 if cl12 > 0 & cl12 != .
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
foreach var in ChildIncome ChildHazard ChildChores {
logit `var' rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
outreg2 using LaborTypesBalanced, excel ctitle("Domestic")
margins, post dydx(_all) 
outreg2 using LaborTypesBalancedMargins, excel ctitle("Domestic")
quietly logit `var' rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight], asis
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using LaborTypesBalancedMarginsRM, excel ctitle("Domestic")
}
log close
