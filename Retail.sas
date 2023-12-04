/* Generated Code (IMPORT) */
/* Source File: Costco_Sales.csv */
/* Source Path: /home/u63281916/sasuser.v94/Group Assessment */
/* Code generated on: 5/14/23, 11:02 PM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u63281916/sasuser.v94/Group Assessment/Costco_Sales.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;

PROC MEANS DATA=WORK.IMPORT N MEAN MEDIAN STD MIN MAX;
  VAR Store Date Weekly_Sales Holiday_Flag Temperature Fuel_Price CPI Unemployment;
RUN;
PROC CORR DATA=WORK.IMPORT PLOTS=matrix(HISTOGRAM MAXPOINTS=6435);
VAR Weekly_Sales CPI Unemployment Fuel_Price;
RUN;


PROC REG DATA=WORK.IMPORT;
	MODEL Temperature CPI Unemployment Fuel_Price=Weekly_Sales;
	RUN;

PROC arima DATA=WORK.IMPORT;
	IDENTIFY VAR=Weekly_Sales nlag=24;
	RUN;

PROC arima DATA=WORK.IMPORT;
	IDENTIFY VAR=Weekly_Sales(1) nlag=24;
	ESTIMATE P=1;
	FORECAST LEAD=6 INTERVAL=MONTH ID=DATE;
	RUN;	
%web_open_table(WORK.IMPORT);