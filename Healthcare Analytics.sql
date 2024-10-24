-- FAC_NO	FAC_NAME	YEAR	QTR	BEG_DATE	END_DATE	OP_STATUS	COUNTY_NAME	HSA	HFPA	TYPE_CNTRL	TYPE_HOSP	CITY	ZIP_CODE	
-- CEO	LIC_BEDS	AVL_BEDS	STF_BEDS	DIS_MCAR	DIS_MCAR_MC	DIS_MCAL	DIS_MCAL_MC	DIS_CNTY	DIS_CNTY_MC	DIS_THRD	
-- DIS_THRD_MC	DIS_INDGNT	DIS_OTH	DIS_TOT	DIS_LTC	DAY_MCAR	DAY_MCAR_MC	DAY_MCAL	DAY_MCAL_MC	DAY_CNTY	DAY_CNTY_MC	DAY_THRD	
-- DAY_THRD_MC	DAY_INDGNT	DAY_OTH	DAY_TOT	DAY_LTC	VIS_MCAR	VIS_MCAR_MC	VIS_MCAL	VIS_MCAL_MC	VIS_CNTY	VIS_CNTY_MC	VIS_THRD	
-- VIS_THRD_MC	VIS_INDGNT	VIS_OTH	VIS_TOT	GRIP_MCAR	GRIP_MCAR_MC	GRIP_MCAL	GRIP_MCAL_MC	GRIP_CNTY	GRIP_CNTY_MC	GRIP_THRD	
-- GRIP_THRD_MC	GRIP_INDGNT	GRIP_OTH	GRIP_TOT	GROP_MCAR	GROP_MCAR_MC	GROP_MCAL	GROP_MCAL_MC	GROP_CNTY	GROP_CNTY_MC	GROP_THRD	
-- GROP_THRD_MC	GROP_INDGNT	GROP_OTH	GROP_TOT	BAD_DEBT	CADJ_MCAR	CADJ_MCAR_MC	CADJ_MCAL	CADJ_MCAL_MC	DISP_855	CADJ_CNTY	CADJ_CNTY_MC	
-- CADJ_THRD	CADJ_THRD_MC	CHAR_HB	CHAR_OTH	SUB_INDGNT	TCH_ALLOW	TCH_SUPP	DED_OTH	DED_TOT	CAP_MCAR	CAP_MCAL	CAP_CNTY	CAP_THRD	CAP_TOT	NET_MCAR	
-- NET_MCAR_MC	NET_MCAL	NET_MCAL_MC	NET_CNTY	NET_CNTY_MC	NET_THRD	NET_THRD_MC	NET_INDGNT	NET_OTH	NET_TOT	OTH_OP_REV	TOT_OP_EXP	PHY_COMP	NONOP_REV	DIS_PIPS	
-- DAY_PIPS	EXP_PIPS	EXP_POPS	CAP_EXP	FIX_ASSETS	DISP_TRNFR	DIS_TOT_CC	PAT_DAY_TOT_CC	TOT_OUT_VIS_CC	GROS_INPAT_REV_CC	GROS_OUTPAT_REV_CC	CONTR_ADJ_CC	
-- OTHR_DEDUCT_CC	CAP_PREM_REV_CC	NET_PAT_REV_CC	QA_FEES	QA_SUPPL_PAY	MNGD_CARE_QA_PAY

create database Hospital;
use hospital;
select * FROM HEALTHCARE LIMIT 2;
select count(*) FROM HEALTHCARE;

-- KPI-1
-- (TOTAL DISCHARGE)
SELECT SUM(DIS_TOT) FROM HEALTHCARE;
select concat(FORMAT(SUM(DIS_TOT)/1000000,2),"M") AS TOTAL_DISCHARGE FROM HEALTHCARE;

-- KPI-2
-- (TOTAL PATIENT DAYS)
SELECT SUM(DAY_TOT) FROM HEALTHCARE;
select year, concat(FORMAT(SUM(DAY_TOT)/1000000,2),"M") AS TOTAL_PATIENT_DAYS FROM HEALTHCARE group by year with rollup;


-- KPI 3
-- (NET PATIENT REVENUE)
SELECT SUM(NET_PAT_REV_CC) FROM HEALTHCARE;
select concat(FORMAT(SUM(NET_PAT_REV_CC)/1000000,2),"M") AS NET_PATIENT_REVENUE FROM HEALTHCARE;
select YEAR, concat(FORMAT(SUM(NET_PAT_REV_CC)/1000000,2),"M") AS NET_PATIENT_REVENUE FROM HEALTHCARE group by YEAR;




-- KPI-4
-- (REVENUE TREND)
select YEAR, concat(FORMAT(SUM(NET_TOT)/1000000000,2),"B") AS REVENUE FROM HEALTHCARE group by YEAR;
select  concat(FORMAT(SUM(NET_TOT)/1000000000,2),"B") AS REVENUE FROM HEALTHCARE ;

-- KPI-5
-- (STATE WISE NO OF HOSPITALS/REVENUE)
SELECT distinct(COUNTY_NAME), COUNT( FAC_NAME) AS TOTAL_HOSPITALS FROM HEALTHCARE group by (COUNTY_NAME) ORDER BY COUNT(FAC_NAME) DESC;



-- KPI-6 
-- (TYPE OF HOSPITAL/REVENUE)
SELECT	TYPE_HOSP,concat(FORMAT(SUM(NET_TOT)/1000000000,2),"B") AS REVENUE FROM HEALTHCARE group by TYPE_HOSP;
SELECT	TYPE_HOSP,YEAR, concat(FORMAT(SUM(NET_TOT)/1000000000,2),"B") AS REVENUE FROM HEALTHCARE group by TYPE_HOSP,YEAR;



-- KPI-7
-- (QTD AND YTD REVENUE)
SELECT YEAR, QTR, concat(FORMAT(SUM(NET_TOT)/1000000000,2),"B") AS REVENUE FROM HEALTHCARE group by YEAR, QTR;
SELECT YEAR, concat(FORMAT(SUM(NET_TOT)/1000000000,2),"B") AS REVENUE FROM HEALTHCARE group by YEAR;
SELECT QTR, concat(FORMAT(SUM(NET_TOT)/1000000000,2),"B") AS REVENUE FROM HEALTHCARE group by QTR order by qtr;



-- KPI-8 
-- (TOTAL PATIENTS AND TOTAL HOSPITALS)
SELECT concat(FORMAT(SUM((DIS_TOT)+(VIS_TOT))/1000000,2),"M") AS TOTAL_PATIENTS FROM HEALTHCARE;
SELECT count(distinct(FAC_NAME)) AS TOTAL_HOSPITALS FROM HEALTHCARE;
SELECT concat(FORMAT(SUM((DIS_TOT))/1000000,2),"M") as Total_discharge, concat(FORMAT(SUM(VIS_TOT)/1000000,2),"M") AS TOTAL_vis FROM HEALTHCARE;


-- CUSTOM KPIS'S 
-- KPI-9
-- ( TOTAL AVAILABLE BEDS)
SELECT concat(FORMAT(SUM(AVL_BEDS)/1000000,2),"M") AS TOTAL_AVAILABLE_BEDS FROM HEALTHCARE;
SELECT YEAR, concat(FORMAT(SUM(AVL_BEDS)/1000000,2),"M") FROM HEALTHCARE group by YEAR;



-- KPI-10
-- (TOTAL PATIENT DAYS BY HOSPITAL TYPE)
SELECT TYPE_HOSP, concat(FORMAT(SUM((DIS_TOT)+(VIS_TOT))/1000000,2),"M") AS TOTAL_PATIENT_DAYS FROM HEALTHCARE group by TYPE_HOSP;