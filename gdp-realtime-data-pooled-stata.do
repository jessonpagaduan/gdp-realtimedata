use pooled-stata.dta

/*
foreach var of varlist dfq4 dfq1 {
reg `var' str_q1q2, r
estimates store `var'_str
reg `var' mob_q1q2 , r
estimates store `var'_mob
reg `var' lncc_q1q2, r
estimates store `var'_lncc
reg `var' str_q1q2 mob_q1q2, r
estimates store `var'_str_mob
reg `var' str_q1q2 lncc_q1q2, r
estimates store `var'_str_lncc
reg `var' mob_q1q2 lncc_q1q2, r
estimates store `var'_mob_lncc
reg `var' str_q1q2 mob_q1q2 lncc_q1q2, r
estimates store `var'_str_mob_lncc
}
*/


foreach var of varlist dfq4 dfq1 {
reg `var' str_q1q2, r
estimates store `var'_str
reg `var' workmob_q1q2 , r
estimates store `var'_workmob
reg `var' lncc_q1q2, r
estimates store `var'_lncc
reg `var' str_q1q2 workmob_q1q2, r
estimates store `var'_str_workmob
reg `var' str_q1q2 lncc_q1q2, r
estimates store `var'_str_lncc
reg `var' workmob_q1q2 lncc_q1q2, r
estimates store `var'_workmob_lncc
reg `var' str_q1q2 workmob_q1q2 lncc_q1q2, r
estimates store `var'_str_workmob_lncc
}


outreg2 [*] using pooled-results-workmob, excel replace
