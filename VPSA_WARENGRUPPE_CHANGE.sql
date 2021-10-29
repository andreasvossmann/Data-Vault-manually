
/*
 * AUTOR: J. DOMANSKI
 * CREATE-DATE: 10.10.2021
 * LAST-MOD-DATE: 29.10.2021 - Andreas Vossmann 
 * 	ZWGR und HWGR aufgenommen
 * 	WH_Landingzone auf WH_DEVELOPMENT ge�ndert
 */

USE WAREHOUSE WH_LANDINGZONE;
USE DATABASE D_LANDINGZONE;
USE SCHEMA S_MOEVE_PORTA;

CREATE OR REPLACE VIEW D_LANDINGZONE.S_MOEVE_PORTA.VPSA_WARENGRUPPE_CHANGEL AS
SELECT
	-- CHANGE
	"header__change_seq" 	AS HEADER_CHANGE_SEQ,
	"header__change_oper" 	AS HEADER__CHANGE_OPER,
	"header__timestamp"		AS HEADER__TIMESTAMP,	
	
	-- KEY
	VDFIR 		AS FIRMA,
	-- CUT OUT
		--VDVAR
	CAST(RTRIM(VDVAR) AS VARCHAR) 			AS WARENGRUPPE, 
	
	--WGR-Hierarchie
	CASE WHEN  (TRY_TO_NUMBER(LEFT (VDVAR,3)) IS NOT NULL)	
		THEN 
			left(VDVAR,2) || 'X'
		ELSE 
			VDVAR
		END	AS ZWGR, 
	CASE WHEN (TRY_TO_NUMBER(LEFT (VDVAR,2)) IS NOT NULL) 	
		THEN 
			left(VDVAR,1) || 'XX'
		ELSE 
			VDVAR
		END	AS HWGR,	
	
	-- OTHER
	VDNLN 		AS FILIALE,
	VDAKT, VDNAD, VDNAU, VDDAT, VDDT2, VDRHF, VDDT3,
	
	-- CUT OUT
		--VDVAR
	
	LTRIM(RTRIM(SUBSTRING(VDVAR, 1, 3))) 	AS HAUPT_WARENGRUPPE,
	LTRIM(RTRIM(SUBSTRING(VDVAR, 4, 4))) 	AS UNTER_WARENGRUPPE,
	LTRIM(RTRIM(SUBSTRING(VDVAR, 8, 1))) 	AS V007NR,
	
		--VDDAT
	LTRIM(RTRIM(SUBSTRING(VDDAT, 1, 10))) 	AS WARENGRUPPENBEZEICHNUNG,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 31, 10))) 	AS SACHKONTO_WARENEINGANG,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 41, 10))) 	AS SACHKONTO_ERL_INLAND_MWST,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 51, 10))) 	AS SACHKONTO_ERL_INL_MWST_FREI,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 61, 10))) 	AS SACHKONTO_ERL_AUSLAND_1_FREI,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 71, 10))) 	AS SACHKONTO_ERL_AUSLAND_2_FREI,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 81, 10))) 	AS SACHKONTO_ERL_AUSLAND_3_FREI,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 91, 2))) 	AS PLZ_STATISTIK_REIHENFOLGE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 93, 12))) 	AS PLZ_STATISTIK_WARENHAUPTGRUPPE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 95, 4))) 	AS ALTERNATIVE_WARENGRUPPE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 95, 2))) 	AS ALTERNATVE_HAUPT_WGR,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 97, 2))) 	AS ALTERNATIVE_UNTER_WGR,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 99, 1))) 	AS DISPO_KZ_X_ZULAESSIG,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 100, 4))) 	AS KOSTENSTELLE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 104, 3))) 	AS EINKAUFSBEREICH,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 107, 4))) 	AS LIEFERUNG_UND_MONTAGE_IN_PROZ,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 111, 4))) 	AS LIEFERUNG_ODER_MONTAGE_IN_PROZ,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 115, 4))) 	AS NUR_MONTAGE_IN_PROZ,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 119, 5))) 	AS SORGF_UND_ERLEDIGUNGSPRAEMIE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 124, 4))) 	AS ANTEIL_AM_NETTOWERT_IN_PROZ,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 128, 5))) 	AS ZUSATZVERGUETUNG_JE_ANFAHRT,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 133, 8))) 	AS INTRATSTAT_WARENGRUPPE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 141, 2))) 	AS PRAEMIENART,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 143, 10))) AS SACHKONTO_WE_INLAND_2_FREI,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 153, 10))) AS SACHKONTO_WE_INLAND_3_FREI,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 163, 10))) AS SACHKONTO_WE_AUSLAND_EG,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 173, 10))) AS SACHKONTO_WE_AUSLAND_NICHT_EG,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 183, 1))) 	AS QUALIFIKATIONSMERKMAL,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 184, 1))) 	AS SUMMENBILDUNG,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 185, 4))) 	AS REDUZ_PLANZEIT_LIEFERUNG,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 189, 4))) 	AS REDUZ_PLANZEIT_MONTAGE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 193, 4))) 	AS REDUZ_BEI_PERSONALVERKAUF,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 197, 30))) AS SUMMENTEXT,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 227, 1))) 	AS WARENART,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 228, 4))) 	AS BONUS_PROZENTSATZ,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 232, 10))) AS WARENBESTANDSKONTO,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 242, 10))) AS BESTANDSVERAENDERUNGSKONTO,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 252, 5))) 	AS AUFSCHLAG_IN_PROZ_AUF_ABHOLPREIS,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 257, 9))) 	AS MINDEST_AUFSCHLAGSBETRAG,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 266, 3))) 	AS ABTEILUNG_FUER_PROV_ABR,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 269, 1))) 	AS PRAEMIENABZUG_ERFOLGT_NICHT,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 270, 6))) 	AS WARENGRUPPEN_PRAEMIE_IN_PROZ,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 276, 1))) 	AS VORMONTAGE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 277, 1))) 	AS TEPPICHPROVISION,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 278, 1))) 	AS MAZAUZ_B_ART_M_LAGERBESTAND,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 279, 2))) 	AS EDI_PROTOKOLL_VERSCHIEBUNGSTAGE,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 281, 1))) 	AS ERMITTL_AUSLIEFERORT_SA12,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 282, 4))) 	AS DEFAULT_PLANZEIT,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 286, 1))) 	AS ABC_KENNZEICHEN,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 287, 1))) 	AS ABC_KENNZEICHEN_ELEKTRO,
	LTRIM(RTRIM(SUBSTRING(VDDAT, 288, 3))) 	AS WGR_ELEKTRO,	
	"TIMESTAMP" AS LDTS,
	RECORDSOURCE_NAME AS RSRC
FROM
	"MVDATR__ct" 
WHERE
	VDSAA = 7 AND "header__change_oper" IN ('D', 'I', 'U')
	;