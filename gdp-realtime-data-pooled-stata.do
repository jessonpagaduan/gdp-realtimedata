use gdp-realtime-data-pooled-stata.dta

foreach var of varlist dfq4_pooled dfq1_pooled {
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

outreg2 [*] using gdp-realtimedata-pooled-results, excel replace
