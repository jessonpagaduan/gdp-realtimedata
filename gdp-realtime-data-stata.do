use gdp-realtime-data-stata.dta, clear

foreach c of varlist gdp_decline_q1q4- gdp_decline_q2q1 {
local y_`c' = regexr("`c'", "gdp_", "")
rename `c' `y_`c''
}

foreach var of varlist gdp2020q1 decline_q1q4 {
reg `var' stringency_q1, r
estimates store `var'_str
reg `var' mobility_q1 , r
estimates store `var'_mob
reg `var' lncc_q1, r
estimates store `var'_lncc
reg `var' stringency_q1 mobility_q1, r
estimates store `var'_str_mob
reg `var' stringency_q1 lncc_q1, r
estimates store `var'_str_lncc
reg `var' mobility_q1 lncc_q1, r
estimates store `var'_mob_lncc
reg `var' stringency_q1 mobility_q1 lncc_q1, r
estimates store `var'_str_mob_lncc
}

foreach var of varlist gdp2020q2 decline_q2q4 decline_q2q1 {
reg `var' stringency_q2, r
estimates store `var'_str
reg `var' mobility_q2 , r
estimates store `var'_mob
reg `var' lncc_q2, r
estimates store `var'_lncc
reg `var' stringency_q2 mobility_q2, r
estimates store `var'_str_mob
reg `var' stringency_q2 lncc_q2, r
estimates store `var'_str_lncc
reg `var' mobility_q2 lncc_q2, r
estimates store `var'_mob_lncc
reg `var' stringency_q2 mobility_q2 lncc_q2, r
estimates store `var'_str_mob_lncc
}

outreg2 [*] using gdp-realtimedata-results, excel replace

gen stringency_change = stringency_q2 - stringency_q1
gen mobility_change = mobility_q2 - mobility_q1
sum *_change
