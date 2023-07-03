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
capture erase "TotalHours.xml"
capture erase "TotalHoursRM.xml"
capture erase "TotalHours.txt"
capture erase "TotalHoursRM.txt"

log using ChildLaborHours, replace 
use "MergedData.dta", clear
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLabor = 0 
replace ChildLabor = 1 if TotalHours > 20
replace ChildLabor = 1 if cl6  == 1 | cl5 == 1
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
reg TotalHours rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
outreg2 using TotalHours, excel ctitle("Unbalanced - All")
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using TotalHoursRM, excel ctitle("Unbalanced - All")
reg TotalHours rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
outreg2 using TotalHours, excel ctitle("Unbalanced - Abroad")
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using TotalHoursRM, excel ctitle("Unbalanced - Abroad")
reg TotalHours rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
outreg2 using TotalHours, excel ctitle("Unbalanced - Domestic")
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using TotalHoursRM, excel ctitle("Unbalanced - Domestic")

use "match3stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLabor = 0 
replace ChildLabor = 1 if TotalHours > 20
replace ChildLabor = 1 if cl6  == 1 | cl5 == 1
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
reg TotalHours rm4_01##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
outreg2 using TotalHours, excel ctitle("Balanced - All")
margins, post dydx(rm4_01) over(sl9c_cats)
outreg2 using TotalHoursRM, excel ctitle("Balanced - All")

use "match2stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLabor = 0 
replace ChildLabor = 1 if TotalHours > 20
replace ChildLabor = 1 if cl6  == 1 | cl5 == 1
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
reg TotalHours rm4b##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
outreg2 using TotalHours, excel ctitle("Balanced - Abroad")
margins, post dydx(rm4b) over(sl9c_cats)
outreg2 using TotalHoursRM, excel ctitle("Balanced - Abroad")

use "match1stackedPairs.dta", clear
keep if sl9c != . & sl9c >= 5
capture gen TotalHours = cl4 + cl9 + cl12
capture gen ChildLabor = 0 
replace ChildLabor = 1 if TotalHours > 20
replace ChildLabor = 1 if cl6  == 1 | cl5 == 1
capture egen sl9c_cats = cut(sl9c), at (5, 12, 14, 18)
reg TotalHours rm4a##sl9c_cats hh14 sl1 hh11 sl9a hl4 hl11 hl13 ed4x wscore sn1 sn3 [pweight = hhweight]
outreg2 using TotalHours, excel ctitle("Balanced - Domestic")
margins, post dydx(rm4a) over(sl9c_cats)
outreg2 using TotalHoursRM, excel ctitle("Balanced - Domestic")
log close
