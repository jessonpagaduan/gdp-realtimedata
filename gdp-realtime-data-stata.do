use gdp-realtime-data-stata.dta, clear

foreach c of varlist gdp_decline_q1q4- gdp_decline_q2q1 {
local y_`c' = regexr("`c'", "gdp_", "")
rename `c' `y_`c''
}

foreach var of varlist gdp2020q1 decline_q1q4 {
reg `var' stringency_q1, r
estimates store `var'_str
reg `var' workmobility_q1 , r
estimates store `var'_mob
reg `var' lncc_q1, r
estimates store `var'_lncc
reg `var' stringency_q1 workmobility_q1, r
estimates store `var'_str_mob
reg `var' stringency_q1 lncc_q1, r
estimates store `var'_str_lncc
reg `var' workmobility_q1 lncc_q1, r
estimates store `var'_mob_lncc
reg `var' stringency_q1 workmobility_q1 lncc_q1, r
estimates store `var'_str_mob_lncc
}

foreach var of varlist gdp2020q2 decline_q2q4 decline_q2q1 {
reg `var' stringency_q2, r
estimates store `var'_str
reg `var' workmobility_q2 , r
estimates store `var'_mob
reg `var' lncc_q2, r
estimates store `var'_lncc
reg `var' stringency_q2 workmobility_q2, r
estimates store `var'_str_mob
reg `var' stringency_q2 lncc_q2, r
estimates store `var'_str_lncc
reg `var' workmobility_q2 lncc_q2, r
estimates store `var'_mob_lncc
reg `var' stringency_q2 workmobility_q2 lncc_q2, r
estimates store `var'_str_mob_lncc
}

***Pooling Q1 and Q2 2020 GDP declines

gen dfq4_pooled = .
replace dfq4_pooled  = decline_q1q4 if decline_q2q4 == .
replace dfq4_pooled = decline_q2q4 if dfq4_pooled == .

gen dfq1_pooled = .
replace dfq1_pooled  = decline_q1q4 if decline_q2q1 == .
replace dfq1_pooled = decline_q2q1 if dfq1_pooled == .

***Getting average over q1 and q2
gen str_q1q2 = (stringency_q1 + stringency_q2)/2
gen workmob_q1q2 = (workmobility_q1 + workmobility_q2)/2
gen lncc_q1q2 = (lncc_q1 + lncc_q2)/2

***Regressions using pooled GDP growth declines

foreach var of varlist dfq4_pooled dfq1_pooled {
reg `var' stringency_q1, r
estimates store `var'_str_q1
reg `var' workmobility_q1 , r
estimates store `var'_mob_q1
reg `var' lncc_q1, r
estimates store `var'_lncc_q1
reg `var' stringency_q1 workmobility_q1, r
estimates store `var'_str_mob_q1
reg `var' stringency_q1 lncc_q1, r
estimates store `var'_str_lncc_q1
reg `var' workmobility_q1 lncc_q1, r
estimates store `var'_mob_lncc_q1
reg `var' stringency_q1 workmobility_q1 lncc_q1, r
estimates store `var'_str_mob_lncc_q1
}

foreach var of varlist dfq4_pooled dfq1_pooled {
reg `var' stringency_q2, r
estimates store `var'_str_q2
reg `var' workmobility_q2 , r
estimates store `var'_mob_q2
reg `var' lncc_q2, r
estimates store `var'_lncc_q2
reg `var' stringency_q2 workmobility_q2, r
estimates store `var'_str_mob_q2
reg `var' stringency_q2 lncc_q2, r
estimates store `var'_str_lncc_q2
reg `var' workmobility_q2 lncc_q2, r
estimates store `var'_mob_lncc_q2
reg `var' stringency_q2 workmobility_q2 lncc_q2, r
estimates store `var'_str_mob_lncc_q2
}

foreach var of varlist dfq4_pooled dfq1_pooled {
reg `var' str_q1q2, r
estimates store `var'_str
reg `var' workmob_q1q2 , r
estimates store `var'_workmob
reg `var' lncc_q1q2, r
estimates store `var'_lncc
reg `var' str_q1q2 workmob_q1q2, r
estimates store `var'_str_mob
reg `var' str_q1q2 lncc_q1q2, r
estimates store `var'_str_lncc
reg `var' workmob_q1q2 lncc_q1q2, r
estimates store `var'_mob_lncc
reg `var' str_q1q2 workmob_q1q2 lncc_q1q2, r
estimates store `var'_str_mob_lncc
}


outreg2 [*] using gdp-realtimedata-results, excel replace

gen stringency_change = stringency_q2 - stringency_q1
gen mobility_change = mobility_q2 - mobility_q1
sum *_change
