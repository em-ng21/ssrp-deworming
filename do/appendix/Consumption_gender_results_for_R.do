 
 * Filename: Consumption_gender_results_for_R.do
 * Table: Appendix Figure S3
 * Description: This do file prepares the coefficient estimates and confidence
 *		intervals used in graphing the consumption plot in Appendix Figure S3.
 *		This do file generates an xlsx file which is pulled into R to plot.

********************************************************************************

//Use data
	use "$data/Worms20_Analysis.dta", clear

//Create female interaction variables
	gen treatXfemale = treatment * female
	gen costXfemale = cost_sharing * female
	gen satXfemale = saturation_dm * female

//Run regressions to store in one large matrix	
**Pooled
	**Full Sample
		*Save control mean used to calculate treatment % effect
		summ tot_cnsp_t if treatment==0 [aw=weight]
		loc controlmean_pooled_all = r(mean)
	
		*Run regression
		xi: reg tot_cnsp_t treatment $x_controls_panel [pw=weight], cluster(psdpsch98)
	
		*Save coefficient and treatment % effect
		loc treat = _b[treatment]
		loc treat_pooled_all = `treat'
		loc teffect_pooled_all = 100*(`treat_pooled_all'/`controlmean_pooled_all')
		
		*Store results in matrix
		lincomest treatment
		eststo pooled_all	
		matrix list r(table)
		matrix define pooled_all = r(table)

	**Female
		*Save control mean used to calculate treatment % effect
		su tot_cnsp_t if treatment==0  & female==1 [aw=weight]
		local controlmean_pooled_female = r(mean)

		*Run regression
		xi: reg tot_cnsp_t treatment treatXfemale costXfemale satXfemale $x_controls_panel [pw=weight], cluster(psdpsch98)

		*Store results in matrix
		lincomest treatment + treatXfemale
		estimates store pooled_female
		matrix list r(table)
		matrix define pooled_female = r(table)

		*Save coefficient and treatment % effect
		xi: reg tot_cnsp_t treatment treatXfemale costXfemale satXfemale $x_controls_panel [pw=weight], cluster(psdpsch98)
		loc treat = _b[treatment] + _b[treatXfemale]
		loc treat_pooled_female = `treat'
		loc teffect_pooled_female= 100*(`treat_pooled_female'/`controlmean_pooled_female')

	**Male
		*Save control mean used to calculate treatment % effect
		su tot_cnsp_t if treatment==0 & female==0 [aw=weight]
		local controlmean_pooled_male = r(mean)

		*Run regression
		xi: reg tot_cnsp_t treatment treatXfemale costXfemale satXfemale $x_controls_panel [pw=weight], cluster(psdpsch98)

		*Save coefficient and treatment % effect
		loc treat = _b[treatment]
		loc treat_pooled_male = `treat'
		loc teffect_pooled_male= 100*(`treat_pooled_male'/`controlmean_pooled_male')

		*Store results in matrix
		lincomest treatment
		estimates store pooled_male
		matrix list r(table)
		matrix define pooled_male = r(table)

	
**KLPS-3 
	**Full sample
		*Save control mean used to calculate treatment % effect
		summ tot_cnsp_t if treatment==0 & interview_round==3 [aw=weight]
		loc controlmean_klps3_all=r(mean)
			
		*Run regression
		xi: reg tot_cnsp_t treatment $x_controls_panel if interview_round==3 [pw=weight], cluster(psdpsch98)
		
		*Save coefficient and treatment % effect	
		loc treat = _b[treatment]
		loc treat_klps3_all = `treat'
		loc teffect_klps3_all = 100*(`treat_klps3_all'/`controlmean_klps3_all')
		
		*Store results in matrix
		lincomest treatment
		eststo klps_3_all
		matrix list r(table)
		matrix define klps3_all = r(table)

	**Female
		*Save control mean used to calculate treatment % effect
		su tot_cnsp_t if treatment==0 & interview_round==3 & female==1 [aw=weight]
		local controlmean_klps3_female = r(mean)

		*Run regression
		reg tot_cnsp_t treatment treatXfemale costXfemale satXfemale $x_controls1 if interview_round==3 [pw=weight], cluster(psdpsch98)

		*Store results in matrix
		lincomest treatment + treatXfemale
		eststo klps_3_female
		matrix list r(table)
		matrix define klps3_female = r(table)

		*Save coefficient and treatment % effect	
		reg tot_cnsp_t treatment treatXfemale costXfemale satXfemale $x_controls1 if interview_round==3 [pw=weight], cluster(psdpsch98)
		loc treat = _b[treatment] + _b[treatXfemale]
		loc treat_klps3_female = `treat'
		loc teffect_klps3_female = 100*(`treat_klps3_female'/`controlmean_klps3_female')

	**Male
		*Save control mean used to calculate treatment % effect
		su tot_cnsp_t if treatment==0 & interview_round==3 & female==0 [aw=weight]
		local controlmean_klps3_male = r(mean)
		
		*Run regression
		reg tot_cnsp_t treatment treatXfemale costXfemale satXfemale $x_controls1 if interview_round==3 [pw=weight], cluster(psdpsch98)

		*Save coefficient and treatment % effect	
		loc treat = _b[treatment]
		loc treat_klps3_male = `treat'
		loc teffect_klps3_male = 100*(`treat_klps3_male'/`controlmean_klps3_male')
		
		*Store results in matrix
		lincomest treatment
		eststo klps_3_male
		matrix list r(table)
		matrix define klps3_male = r(table)


**KLPS-4
	**Full sample
		*Save control mean used to calculate treatment % effect
		summ tot_cnsp_t if treatment==0 & interview_round==4 [aw=weight]
		loc controlmean_klps4_all=r(mean)
	
		*Run regression
		xi: reg tot_cnsp_t treatment $x_controls1 if interview_round==4 [pw=weight], cluster(psdpsch98)
	
		*Save coefficient and treatment % effect	
		loc treat = _b[treatment]
		loc treat_klps4_all = `treat'
		loc teffect_klps4_all = 100*(`treat_klps4_all'/`controlmean_klps4_all')
	
		*Store results in matrix
		lincomest treatment
		eststo klps_4_all
		matrix list r(table)
		matrix define klps4_all = r(table)

	**Female
		*Save control mean used to calculate treatment % effect
		su tot_cnsp_t if treatment==0 & interview_round==4 & female==1 [aw=weight]
		local controlmean_klps4_female = r(mean)

		*Run regression
		reg tot_cnsp_t treatment treatXfemale costXfemale satXfemale $x_controls1 if interview_round==4 [pw=weight], cluster(psdpsch98)

		*Store results in matrix
		lincomest treatment + treatXfemale
		eststo klps_4_female
		matrix list r(table)
		matrix define klps4_female = r(table)

		*Save coefficient and treatment % effect	
		reg tot_cnsp_t treatment treatXfemale $x_controls1 if interview_round==4 [pw=weight], cluster(psdpsch98)

		loc treat = _b[treatment] + _b[treatXfemale]
		loc treat_klps4_female = `treat'
		loc teffect_klps4_female = 100*(`treat_klps4_female'/`controlmean_klps4_female')

	**Male
		*Save control mean used to calculate treatment % effect
		su tot_cnsp_t if treatment==0 & interview_round==4 & female==0 [aw=weight]
		local controlmean_klps4_male = r(mean)

		*Run regression
		reg tot_cnsp_t treatment treatXfemale costXfemale satXfemale $x_controls1 if interview_round==4 [pw=weight], cluster(psdpsch98)

		*Save coefficient and treatment % effect	
		loc treat = _b[treatment]
		loc treat_klps4_male = `treat'
		loc teffect_klps4_male = 100*(`treat_klps4_male'/`controlmean_klps4_male')

		*Store results in matrix
		lincomest treatment
		eststo klps_4_male
		matrix list r(table)
		matrix define klps4_male = r(table)

**Empty KLPS-2 (because no consumption measured in KLPS-2)
	gen zero=0
	mean zero
	estimates store klps_2_all
	estimates store klps_2_male
	estimates store klps_2_female
	drop zero
	local teffect_klps2 = 0

	matrix define klps2_all = [0\0\0\0\0\0\0\0\0]
	matrix define klps2_female = [0\0\0\0\0\0\0\0\0]
	matrix define klps2_male = [0\0\0\0\0\0\0\0\0]

*Create matrix of all estimates
	matrix all_estimates_old=[pooled_all , pooled_female , pooled_male, klps2_all, klps2_female, klps2_male, klps3_all, klps3_female, klps3_male, klps4_all, klps4_female, klps4_male]
	matrix list all_estimates_old

*Transpose matrix
	matrix define all_estimates = all_estimates_old'

*Change matrix to variables and output
	svmat all_estimates, names(col)
	keep b se ll ul 
	keep if b!=.
	gen model = ""
	replace model = "pooled_all" if _n==1
	replace model = "pooled_female" if _n==2
	replace model = "pooled_male" if _n==3
	replace model = "klps2_all" if _n==4
	replace model = "klps2_female" if _n==5
	replace model = "klps2_male" if _n==6
	replace model = "klps3_all" if _n==7
	replace model = "klps3_female" if _n==8
	replace model = "klps3_male" if _n==9
	replace model = "klps4_all" if _n==10
	replace model = "klps4_female" if _n==11
	replace model = "klps4_male" if _n==12

	gen model_num = 1 if model=="pooled_all"
	replace model_num = 2 if model=="pooled_female"
	replace model_num = 3 if model=="pooled_male"
	replace model_num = 5 if model=="klps2_all"
	replace model_num = 6 if model=="klps2_female"
	replace model_num = 7 if model=="klps2_male"
	replace model_num = 9 if model=="klps3_all"
	replace model_num = 10 if model=="klps3_female"
	replace model_num = 11 if model=="klps3_male"
	replace model_num = 13 if model=="klps4_all"
	replace model_num = 14 if model=="klps4_female"
	replace model_num = 15 if model=="klps4_male"

*Add variables for % treatment effect and control means
	gen treat_effect = .
	gen control_mean = .

foreach model in pooled_all pooled_female pooled_male klps3_all klps3_female klps3_male klps4_all klps4_female klps4_male {
	replace treat_effect = `teffect_`model'' if model=="`model'"
	replace control_mean = `controlmean_`model'' if model=="`model'"
}


*Export to excel for graphing in R
export excel using "$temp/Consumption_results_for_R.xlsx",replace firstrow(variables)

