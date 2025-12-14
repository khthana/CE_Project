/* Microsoft SQL Server - Scripting			*/
/* Server: DP3					*/
/* Database: projecta					*/
/* Creation Date 27/5/41 15:48:10 			*/

/****** Object:  Stored Procedure dbo.Slib_changb2    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_changb2') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_changb2
GO

/****** Object:  Stored Procedure dbo.Slib_changeb1    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_changeb1') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_changeb1
GO

/****** Object:  Stored Procedure dbo.Slib_compareday    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_compareday') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_compareday
GO

/****** Object:  Stored Procedure dbo.Slib_del_b1b2    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_del_b1b2') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_del_b1b2
GO

/****** Object:  Stored Procedure dbo.Slib_Ldate_in    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_Ldate_in') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_Ldate_in
GO

/****** Object:  Stored Procedure dbo.Slib_sback    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_sback') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_sback
GO

/****** Object:  Stored Procedure dbo.slib_sbacklate    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.slib_sbacklate') and sysstat & 0xf = 4)
	drop procedure dbo.slib_sbacklate
GO

/****** Object:  Stored Procedure dbo.Slib_sbook    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_sbook') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_sbook
GO

/****** Object:  Stored Procedure dbo.slib_sborlate1    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.slib_sborlate1') and sysstat & 0xf = 4)
	drop procedure dbo.slib_sborlate1
GO

/****** Object:  Stored Procedure dbo.Slib_sd_sbor    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_sd_sbor') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_sd_sbor
GO

/****** Object:  Stored Procedure dbo.Slib_sd_tbor    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_sd_tbor') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_sd_tbor
GO

/****** Object:  Stored Procedure dbo.slib_sum_s    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.slib_sum_s') and sysstat & 0xf = 4)
	drop procedure dbo.slib_sum_s
GO

/****** Object:  Stored Procedure dbo.slib_sum_t    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.slib_sum_t') and sysstat & 0xf = 4)
	drop procedure dbo.slib_sum_t
GO

/****** Object:  Stored Procedure dbo.Slib_tback    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_tback') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_tback
GO

/****** Object:  Stored Procedure dbo.Slib_tbacklate    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.Slib_tbacklate') and sysstat & 0xf = 4)
	drop procedure dbo.Slib_tbacklate
GO

/****** Object:  Stored Procedure dbo.slib_tborlate    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.slib_tborlate') and sysstat & 0xf = 4)
	drop procedure dbo.slib_tborlate
GO

/****** Object:  Stored Procedure dbo.spAccEAdd    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccEAdd') and sysstat & 0xf = 4)
	drop procedure dbo.spAccEAdd
GO

/****** Object:  Stored Procedure dbo.spAccEAddListSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccEAddListSch') and sysstat & 0xf = 4)
	drop procedure dbo.spAccEAddListSch
GO

/****** Object:  Stored Procedure dbo.spAccEAddNo    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccEAddNo') and sysstat & 0xf = 4)
	drop procedure dbo.spAccEAddNo
GO

/****** Object:  Stored Procedure dbo.spAccEchgDel    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccEchgDel') and sysstat & 0xf = 4)
	drop procedure dbo.spAccEchgDel
GO

/****** Object:  Stored Procedure dbo.spAccEchgEdit    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccEchgEdit') and sysstat & 0xf = 4)
	drop procedure dbo.spAccEchgEdit
GO

/****** Object:  Stored Procedure dbo.spAccEChgSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccEChgSch') and sysstat & 0xf = 4)
	drop procedure dbo.spAccEChgSch
GO

/****** Object:  Stored Procedure dbo.spAccErpt    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccErpt') and sysstat & 0xf = 4)
	drop procedure dbo.spAccErpt
GO

/****** Object:  Stored Procedure dbo.spAccESumSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccESumSch') and sysstat & 0xf = 4)
	drop procedure dbo.spAccESumSch
GO

/****** Object:  Stored Procedure dbo.spAccRAdd    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccRAdd') and sysstat & 0xf = 4)
	drop procedure dbo.spAccRAdd
GO

/****** Object:  Stored Procedure dbo.spAccRAddListSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccRAddListSch') and sysstat & 0xf = 4)
	drop procedure dbo.spAccRAddListSch
GO

/****** Object:  Stored Procedure dbo.spAccRAddNo    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccRAddNo') and sysstat & 0xf = 4)
	drop procedure dbo.spAccRAddNo
GO

/****** Object:  Stored Procedure dbo.spAccRchgDel    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccRchgDel') and sysstat & 0xf = 4)
	drop procedure dbo.spAccRchgDel
GO

/****** Object:  Stored Procedure dbo.spAccRchgEdit    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccRchgEdit') and sysstat & 0xf = 4)
	drop procedure dbo.spAccRchgEdit
GO

/****** Object:  Stored Procedure dbo.spAccRChgSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccRChgSch') and sysstat & 0xf = 4)
	drop procedure dbo.spAccRChgSch
GO

/****** Object:  Stored Procedure dbo.spAccRrpt    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccRrpt') and sysstat & 0xf = 4)
	drop procedure dbo.spAccRrpt
GO

/****** Object:  Stored Procedure dbo.spAccRSumSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spAccRSumSch') and sysstat & 0xf = 4)
	drop procedure dbo.spAccRSumSch
GO

/****** Object:  Stored Procedure dbo.spBasicEdit    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spBasicEdit') and sysstat & 0xf = 4)
	drop procedure dbo.spBasicEdit
GO

/****** Object:  Stored Procedure dbo.spBasicSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spBasicSch') and sysstat & 0xf = 4)
	drop procedure dbo.spBasicSch
GO

/****** Object:  Stored Procedure dbo.spOtAbsentSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spOtAbsentSch') and sysstat & 0xf = 4)
	drop procedure dbo.spOtAbsentSch
GO

/****** Object:  Stored Procedure dbo.spOtCalSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spOtCalSch') and sysstat & 0xf = 4)
	drop procedure dbo.spOtCalSch
GO

/****** Object:  Stored Procedure dbo.spOtInOutSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spOtInOutSch') and sysstat & 0xf = 4)
	drop procedure dbo.spOtInOutSch
GO

/****** Object:  Stored Procedure dbo.spOtPerfSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spOtPerfSch') and sysstat & 0xf = 4)
	drop procedure dbo.spOtPerfSch
GO

/****** Object:  Stored Procedure dbo.spOtRateSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spOtRateSch') and sysstat & 0xf = 4)
	drop procedure dbo.spOtRateSch
GO

/****** Object:  Stored Procedure dbo.spOtRepSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spOtRepSch') and sysstat & 0xf = 4)
	drop procedure dbo.spOtRepSch
GO

/****** Object:  Stored Procedure dbo.spOtTableSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spOtTableSch') and sysstat & 0xf = 4)
	drop procedure dbo.spOtTableSch
GO

/****** Object:  Stored Procedure dbo.spOtTableSum    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spOtTableSum') and sysstat & 0xf = 4)
	drop procedure dbo.spOtTableSum
GO

/****** Object:  Stored Procedure dbo.spPayInsSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayInsSch') and sysstat & 0xf = 4)
	drop procedure dbo.spPayInsSch
GO

/****** Object:  Stored Procedure dbo.spPayInstallIns    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayInstallIns') and sysstat & 0xf = 4)
	drop procedure dbo.spPayInstallIns
GO

/****** Object:  Stored Procedure dbo.spPayListIns    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayListIns') and sysstat & 0xf = 4)
	drop procedure dbo.spPayListIns
GO

/****** Object:  Stored Procedure dbo.spPayListSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayListSch') and sysstat & 0xf = 4)
	drop procedure dbo.spPayListSch
GO

/****** Object:  Stored Procedure dbo.spPayNorIns    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayNorIns') and sysstat & 0xf = 4)
	drop procedure dbo.spPayNorIns
GO

/****** Object:  Stored Procedure dbo.sppayNorSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.sppayNorSch') and sysstat & 0xf = 4)
	drop procedure dbo.sppayNorSch
GO

/****** Object:  Stored Procedure dbo.spPayRateIns    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayRateIns') and sysstat & 0xf = 4)
	drop procedure dbo.spPayRateIns
GO

/****** Object:  Stored Procedure dbo.spPayRateSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayRateSch') and sysstat & 0xf = 4)
	drop procedure dbo.spPayRateSch
GO

/****** Object:  Stored Procedure dbo.spPayRptNot    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayRptNot') and sysstat & 0xf = 4)
	drop procedure dbo.spPayRptNot
GO

/****** Object:  Stored Procedure dbo.spPayRptNotComp    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spPayRptNotComp') and sysstat & 0xf = 4)
	drop procedure dbo.spPayRptNotComp
GO

/****** Object:  Stored Procedure dbo.sppayRptSum    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.sppayRptSum') and sysstat & 0xf = 4)
	drop procedure dbo.sppayRptSum
GO

/****** Object:  Stored Procedure dbo.spSalBorChk    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalBorChk') and sysstat & 0xf = 4)
	drop procedure dbo.spSalBorChk
GO

/****** Object:  Stored Procedure dbo.spSalBorIns    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalBorIns') and sysstat & 0xf = 4)
	drop procedure dbo.spSalBorIns
GO

/****** Object:  Stored Procedure dbo.spSalCoEdit    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalCoEdit') and sysstat & 0xf = 4)
	drop procedure dbo.spSalCoEdit
GO

/****** Object:  Stored Procedure dbo.spSalCoIns1    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalCoIns1') and sysstat & 0xf = 4)
	drop procedure dbo.spSalCoIns1
GO

/****** Object:  Stored Procedure dbo.spSalCoSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalCoSch') and sysstat & 0xf = 4)
	drop procedure dbo.spSalCoSch
GO

/****** Object:  Stored Procedure dbo.spSalInstIdSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalInstIdSch') and sysstat & 0xf = 4)
	drop procedure dbo.spSalInstIdSch
GO

/****** Object:  Stored Procedure dbo.spSalInstIns    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalInstIns') and sysstat & 0xf = 4)
	drop procedure dbo.spSalInstIns
GO

/****** Object:  Stored Procedure dbo.spSalInstNoSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalInstNoSch') and sysstat & 0xf = 4)
	drop procedure dbo.spSalInstNoSch
GO

/****** Object:  Stored Procedure dbo.spSalInstRptSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalInstRptSch') and sysstat & 0xf = 4)
	drop procedure dbo.spSalInstRptSch
GO

/****** Object:  Stored Procedure dbo.spSalmonthSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalmonthSch') and sysstat & 0xf = 4)
	drop procedure dbo.spSalmonthSch
GO

/****** Object:  Stored Procedure dbo.spSalRpt    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalRpt') and sysstat & 0xf = 4)
	drop procedure dbo.spSalRpt
GO

/****** Object:  Stored Procedure dbo.spSalRptSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalRptSch') and sysstat & 0xf = 4)
	drop procedure dbo.spSalRptSch
GO

/****** Object:  Stored Procedure dbo.spSalSalEdit    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalSalEdit') and sysstat & 0xf = 4)
	drop procedure dbo.spSalSalEdit
GO

/****** Object:  Stored Procedure dbo.spSalSalIns    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalSalIns') and sysstat & 0xf = 4)
	drop procedure dbo.spSalSalIns
GO

/****** Object:  Stored Procedure dbo.spSalSalSch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSalSalSch') and sysstat & 0xf = 4)
	drop procedure dbo.spSalSalSch
GO

/****** Object:  Stored Procedure dbo.spSrchTname    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spSrchTname') and sysstat & 0xf = 4)
	drop procedure dbo.spSrchTname
GO

/****** Object:  Stored Procedure dbo.sptest    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.sptest') and sysstat & 0xf = 4)
	drop procedure dbo.sptest
GO

/****** Object:  Stored Procedure dbo.sptestInsert    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.sptestInsert') and sysstat & 0xf = 4)
	drop procedure dbo.sptestInsert
GO

/****** Object:  Stored Procedure dbo.spTR_S1Sch    Script Date: 27/5/41 15:48:14 ******/
if exists (select * from sysobjects where id = object_id('dbo.spTR_S1Sch') and sysstat & 0xf = 4)
	drop procedure dbo.spTR_S1Sch
GO

/****** Object:  Stored Procedure dbo.spTR_T1Sch    Script Date: 27/5/41 15:48:15 ******/
if exists (select * from sysobjects where id = object_id('dbo.spTR_T1Sch') and sysstat & 0xf = 4)
	drop procedure dbo.spTR_T1Sch
GO

/****** Object:  Stored Procedure dbo.Spus_com1_change    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Spus_com1_change') and sysstat & 0xf = 4)
	drop procedure dbo.Spus_com1_change
GO

/****** Object:  Stored Procedure dbo.Spus_delete_order1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Spus_delete_order1') and sysstat & 0xf = 4)
	drop procedure dbo.Spus_delete_order1
GO

/****** Object:  Stored Procedure dbo.Spus_delte_com1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Spus_delte_com1') and sysstat & 0xf = 4)
	drop procedure dbo.Spus_delte_com1
GO

/****** Object:  Stored Procedure dbo.Spus_order1_change    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Spus_order1_change') and sysstat & 0xf = 4)
	drop procedure dbo.Spus_order1_change
GO

/****** Object:  Stored Procedure dbo.Spus_order2_change1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Spus_order2_change1') and sysstat & 0xf = 4)
	drop procedure dbo.Spus_order2_change1
GO

/****** Object:  Stored Procedure dbo.Spus_order2_change2    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Spus_order2_change2') and sysstat & 0xf = 4)
	drop procedure dbo.Spus_order2_change2
GO

/****** Object:  Stored Procedure dbo.Spus_pus1_change    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Spus_pus1_change') and sysstat & 0xf = 4)
	drop procedure dbo.Spus_pus1_change
GO

/****** Object:  Table dbo.AATest    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.AATest') and sysstat & 0xf = 3)
	drop table dbo.AATest
GO

/****** Object:  Table dbo.TAcc_EType    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TAcc_EType') and sysstat & 0xf = 3)
	drop table dbo.TAcc_EType
GO

/****** Object:  Table dbo.TAcc_Exp    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TAcc_Exp') and sysstat & 0xf = 3)
	drop table dbo.TAcc_Exp
GO

/****** Object:  Table dbo.TAcc_Rec    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TAcc_Rec') and sysstat & 0xf = 3)
	drop table dbo.TAcc_Rec
GO

/****** Object:  Table dbo.TAcc_RType    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TAcc_RType') and sysstat & 0xf = 3)
	drop table dbo.TAcc_RType
GO

/****** Object:  Table dbo.TBasic    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TBasic') and sysstat & 0xf = 3)
	drop table dbo.TBasic
GO

/****** Object:  Table dbo.Tlib1_book1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tlib1_book1') and sysstat & 0xf = 3)
	drop table dbo.Tlib1_book1
GO

/****** Object:  Table dbo.Tlib1_book2    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tlib1_book2') and sysstat & 0xf = 3)
	drop table dbo.Tlib1_book2
GO

/****** Object:  Table dbo.Tlib1_hdate    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tlib1_hdate') and sysstat & 0xf = 3)
	drop table dbo.Tlib1_hdate
GO

/****** Object:  Table dbo.Tlib1_lastdate    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tlib1_lastdate') and sysstat & 0xf = 3)
	drop table dbo.Tlib1_lastdate
GO

/****** Object:  Table dbo.Tlib1_Sback    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tlib1_Sback') and sysstat & 0xf = 3)
	drop table dbo.Tlib1_Sback
GO

/****** Object:  Table dbo.Tlib1_Sbor    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tlib1_Sbor') and sysstat & 0xf = 3)
	drop table dbo.Tlib1_Sbor
GO

/****** Object:  Table dbo.Tlib1_Tback    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tlib1_Tback') and sysstat & 0xf = 3)
	drop table dbo.Tlib1_Tback
GO

/****** Object:  Table dbo.Tlib1_Tbor    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tlib1_Tbor') and sysstat & 0xf = 3)
	drop table dbo.Tlib1_Tbor
GO

/****** Object:  Table dbo.TOt_Absent    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TOt_Absent') and sysstat & 0xf = 3)
	drop table dbo.TOt_Absent
GO

/****** Object:  Table dbo.TOt_Experiod    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TOt_Experiod') and sysstat & 0xf = 3)
	drop table dbo.TOt_Experiod
GO

/****** Object:  Table dbo.TOt_Inout    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TOt_Inout') and sysstat & 0xf = 3)
	drop table dbo.TOt_Inout
GO

/****** Object:  Table dbo.tot_period    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.tot_period') and sysstat & 0xf = 3)
	drop table dbo.tot_period
GO

/****** Object:  Table dbo.TOt_Rate    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TOt_Rate') and sysstat & 0xf = 3)
	drop table dbo.TOt_Rate
GO

/****** Object:  Table dbo.TOt_Semileave    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TOt_Semileave') and sysstat & 0xf = 3)
	drop table dbo.TOt_Semileave
GO

/****** Object:  Table dbo.TOt_teachtable    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TOt_teachtable') and sysstat & 0xf = 3)
	drop table dbo.TOt_teachtable
GO

/****** Object:  Table dbo.TOT_Type    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TOT_Type') and sysstat & 0xf = 3)
	drop table dbo.TOT_Type
GO

/****** Object:  Table dbo.TPay_install    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TPay_install') and sysstat & 0xf = 3)
	drop table dbo.TPay_install
GO

/****** Object:  Table dbo.TPay_list    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TPay_list') and sysstat & 0xf = 3)
	drop table dbo.TPay_list
GO

/****** Object:  Table dbo.TPay_Normal    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TPay_Normal') and sysstat & 0xf = 3)
	drop table dbo.TPay_Normal
GO

/****** Object:  Table dbo.TPay_Rate    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TPay_Rate') and sysstat & 0xf = 3)
	drop table dbo.TPay_Rate
GO

/****** Object:  Table dbo.TPay_std    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TPay_std') and sysstat & 0xf = 3)
	drop table dbo.TPay_std
GO

/****** Object:  Table dbo.TPm_Rate    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TPm_Rate') and sysstat & 0xf = 3)
	drop table dbo.TPm_Rate
GO

/****** Object:  Table dbo.TPm_Replace    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TPm_Replace') and sysstat & 0xf = 3)
	drop table dbo.TPm_Replace
GO

/****** Object:  Table dbo.TPm_time    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TPm_time') and sysstat & 0xf = 3)
	drop table dbo.TPm_time
GO

/****** Object:  Table dbo.Tpus_com1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tpus_com1') and sysstat & 0xf = 3)
	drop table dbo.Tpus_com1
GO

/****** Object:  Table dbo.Tpus_com2    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tpus_com2') and sysstat & 0xf = 3)
	drop table dbo.Tpus_com2
GO

/****** Object:  Table dbo.Tpus_order1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tpus_order1') and sysstat & 0xf = 3)
	drop table dbo.Tpus_order1
GO

/****** Object:  Table dbo.Tpus_order2    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tpus_order2') and sysstat & 0xf = 3)
	drop table dbo.Tpus_order2
GO

/****** Object:  Table dbo.Tpus_pus1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tpus_pus1') and sysstat & 0xf = 3)
	drop table dbo.Tpus_pus1
GO

/****** Object:  Table dbo.TR_brance    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TR_brance') and sysstat & 0xf = 3)
	drop table dbo.TR_brance
GO

/****** Object:  Table dbo.TR_S1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TR_S1') and sysstat & 0xf = 3)
	drop table dbo.TR_S1
GO

/****** Object:  Table dbo.TR_S2    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TR_S2') and sysstat & 0xf = 3)
	drop table dbo.TR_S2
GO

/****** Object:  Table dbo.TR_T1    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TR_T1') and sysstat & 0xf = 3)
	drop table dbo.TR_T1
GO

/****** Object:  Table dbo.Tsal_basic    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.Tsal_basic') and sysstat & 0xf = 3)
	drop table dbo.Tsal_basic
GO

/****** Object:  Table dbo.TSal_Borr    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TSal_Borr') and sysstat & 0xf = 3)
	drop table dbo.TSal_Borr
GO

/****** Object:  Table dbo.TSal_Coop    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TSal_Coop') and sysstat & 0xf = 3)
	drop table dbo.TSal_Coop
GO

/****** Object:  Table dbo.TSal_Install    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TSal_Install') and sysstat & 0xf = 3)
	drop table dbo.TSal_Install
GO

/****** Object:  Table dbo.TSal_InsType    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TSal_InsType') and sysstat & 0xf = 3)
	drop table dbo.TSal_InsType
GO

/****** Object:  Table dbo.TSal_Sal    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TSal_Sal') and sysstat & 0xf = 3)
	drop table dbo.TSal_Sal
GO

/****** Object:  Table dbo.TSal_Teach    Script Date: 27/5/41 15:48:16 ******/
if exists (select * from sysobjects where id = object_id('dbo.TSal_Teach') and sysstat & 0xf = 3)
	drop table dbo.TSal_Teach
GO

/****** Object:  Table dbo.AATest    Script Date: 27/5/41 15:48:16 ******/
CREATE TABLE dbo.AATest (
	date datetime NOT NULL ,
	ch char (10) NULL ,
	total decimal(5, 0) NULL 
)
GO

/****** Object:  Table dbo.TAcc_EType    Script Date: 27/5/41 15:48:18 ******/
CREATE TABLE dbo.TAcc_EType (
	TypeCode tinyint NOT NULL ,
	type varchar (35) NOT NULL ,
	CONSTRAINT pk_TAcc_EType PRIMARY KEY  CLUSTERED 
	(
		TypeCode
	),
	CONSTRAINT U_TAcc_EType UNIQUE  NONCLUSTERED 
	(
		type
	)
)
GO

/****** Object:  Table dbo.TAcc_Exp    Script Date: 27/5/41 15:48:18 ******/
CREATE TABLE dbo.TAcc_Exp (
	seq_no tinyint NOT NULL ,
	date1 datetime NOT NULL ,
	typecode tinyint NOT NULL ,
	list varchar (35) NOT NULL ,
	sum1 decimal(10, 2) NOT NULL ,
	dest char (35) NOT NULL ,
	CONSTRAINT pk_TAcc_exp PRIMARY KEY  CLUSTERED 
	(
		seq_no,
		date1
	)
)
GO

/****** Object:  Table dbo.TAcc_Rec    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.TAcc_Rec (
	seq_no tinyint NOT NULL ,
	date1 datetime NOT NULL ,
	typecode tinyint NOT NULL ,
	list varchar (35) NOT NULL ,
	sum1 decimal(10, 2) NOT NULL ,
	source varchar (35) NOT NULL ,
	CONSTRAINT pk_TAcc_Rec PRIMARY KEY  CLUSTERED 
	(
		seq_no,
		date1
	)
)
GO

/****** Object:  Table dbo.TAcc_RType    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.TAcc_RType (
	TypeCode tinyint NOT NULL ,
	type varchar (35) NOT NULL ,
	CONSTRAINT pk_TAcc_RType PRIMARY KEY  CLUSTERED 
	(
		TypeCode
	),
	CONSTRAINT U_TAcc_RType UNIQUE  NONCLUSTERED 
	(
		type
	)
)
GO

/****** Object:  Table dbo.TBasic    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.TBasic (
	year char (4) NOT NULL ,
	semester char (1) NOT NULL ,
	CONSTRAINT pk_TBasic PRIMARY KEY  CLUSTERED 
	(
		year,
		semester
	)
)
GO

/****** Object:  Table dbo.Tlib1_book1    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.Tlib1_book1 (
	reg_no char (6) NOT NULL ,
	call_no char (20) NOT NULL ,
	date datetime NOT NULL ,
	note char (40) NULL ,
	CONSTRAINT PK___5__12 PRIMARY KEY  CLUSTERED 
	(
		reg_no
	),
	CONSTRAINT FK_Tlib1_book1_7__12 FOREIGN KEY 
	(
		call_no
	) REFERENCES dbo.Tlib1_book2 (
		call_no
	)
)
GO

/****** Object:  Table dbo.Tlib1_book2    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.Tlib1_book2 (
	call_no char (20) NOT NULL ,
	name char (70) NOT NULL ,
	class_no char (3) NULL ,
	class_name char (35) NULL ,
	authour1 char (55) NULL ,
	authour2 char (55) NULL ,
	authour3 char (55) NULL ,
	publishing char (60) NULL ,
	year char (4) NULL ,
	edition char (3) NULL ,
	price decimal(8, 2) NULL ,
	class_borrow char (1) NULL ,
	CONSTRAINT PK___6__12 PRIMARY KEY  CLUSTERED 
	(
		call_no
	)
)
GO

/****** Object:  Table dbo.Tlib1_hdate    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.Tlib1_hdate (
	hdate datetime NOT NULL ,
	CONSTRAINT PK___11__12 PRIMARY KEY  CLUSTERED 
	(
		hdate
	)
)
GO

/****** Object:  Table dbo.Tlib1_lastdate    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.Tlib1_lastdate (
	last_date datetime NOT NULL ,
	CONSTRAINT PK___10__12 PRIMARY KEY  CLUSTERED 
	(
		last_date
	)
)
GO

/****** Object:  Table dbo.Tlib1_Sback    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.Tlib1_Sback (
	reg_no char (6) NOT NULL ,
	s_id char (10) NOT NULL ,
	date_bor datetime NOT NULL ,
	date_limit datetime NOT NULL ,
	date_back datetime NOT NULL ,
	CONSTRAINT PK___12__12 PRIMARY KEY  CLUSTERED 
	(
		reg_no,
		s_id,
		date_bor,
		date_limit,
		date_back
	),
	CONSTRAINT FK___13__12 FOREIGN KEY 
	(
		s_id
	) REFERENCES dbo.TR_S1 (
		S_ID
	)
)
GO

/****** Object:  Table dbo.Tlib1_Sbor    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.Tlib1_Sbor (
	reg_no char (6) NOT NULL ,
	s_id char (10) NOT NULL ,
	date_bor datetime NOT NULL ,
	date_limit datetime NOT NULL ,
	CONSTRAINT PK___7__12 PRIMARY KEY  CLUSTERED 
	(
		reg_no
	),
	CONSTRAINT FK___8__12 FOREIGN KEY 
	(
		s_id
	) REFERENCES dbo.TR_S1 (
		S_ID
	),
	CONSTRAINT FK_Tlib1_Sbor_1__14 FOREIGN KEY 
	(
		reg_no
	) REFERENCES dbo.Tlib1_book1 (
		reg_no
	)
)
GO

/****** Object:  Table dbo.Tlib1_Tback    Script Date: 27/5/41 15:48:19 ******/
CREATE TABLE dbo.Tlib1_Tback (
	reg_no char (6) NOT NULL ,
	t_id char (10) NOT NULL ,
	date_bor datetime NOT NULL ,
	date_limit datetime NOT NULL ,
	date_back datetime NOT NULL ,
	CONSTRAINT PK___13__12 PRIMARY KEY  CLUSTERED 
	(
		reg_no,
		t_id,
		date_bor,
		date_limit,
		date_back
	),
	CONSTRAINT FK___14__12 FOREIGN KEY 
	(
		t_id
	) REFERENCES dbo.TR_T1 (
		T_ID
	)
)
GO

/****** Object:  Table dbo.Tlib1_Tbor    Script Date: 27/5/41 15:48:20 ******/
CREATE TABLE dbo.Tlib1_Tbor (
	reg_no char (6) NOT NULL ,
	t_id char (10) NOT NULL ,
	date_bor datetime NOT NULL ,
	date_limit datetime NOT NULL ,
	CONSTRAINT PK___4__12 PRIMARY KEY  CLUSTERED 
	(
		reg_no
	),
	CONSTRAINT FK___5__12 FOREIGN KEY 
	(
		t_id
	) REFERENCES dbo.TR_T1 (
		T_ID
	),
	CONSTRAINT FK_Tlib1_Tbor_1__14 FOREIGN KEY 
	(
		reg_no
	) REFERENCES dbo.Tlib1_book1 (
		reg_no
	)
)
GO

/****** Object:  Table dbo.TOt_Absent    Script Date: 27/5/41 15:48:20 ******/
CREATE TABLE dbo.TOt_Absent (
	absentId char (10) NOT NULL ,
	date1 datetime NOT NULL ,
	period_no tinyint NOT NULL ,
	typecode tinyint NOT NULL ,
	ReplaceId char (10) NULL ,
	CONSTRAINT pk_Tot_Replace PRIMARY KEY  CLUSTERED 
	(
		absentId,
		date1,
		period_no
	),
	CONSTRAINT u_Tot_Replace UNIQUE  NONCLUSTERED 
	(
		ReplaceId,
		date1,
		period_no
	)
)
GO

/****** Object:  Table dbo.TOt_Experiod    Script Date: 27/5/41 15:48:20 ******/
CREATE TABLE dbo.TOt_Experiod (
	id char (10) NOT NULL ,
	month1 varchar (2) NOT NULL ,
	adv_amount tinyint NULL ,
	duty_amount tinyint NULL ,
	CONSTRAINT pk_TOt_Experiod PRIMARY KEY  CLUSTERED 
	(
		id,
		month1
	)
)
GO

/****** Object:  Table dbo.TOt_Inout    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TOt_Inout (
	id char (10) NOT NULL ,
	date1 datetime NOT NULL ,
	in_time datetime NOT NULL ,
	out_time datetime NOT NULL ,
	CONSTRAINT pk_Tot_Inout PRIMARY KEY  CLUSTERED 
	(
		id,
		date1
	)
)
GO

/****** Object:  Table dbo.tot_period    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.tot_period (
	period_no tinyint NOT NULL ,
	time datetime NOT NULL ,
	CONSTRAINT pk_tot_period PRIMARY KEY  CLUSTERED 
	(
		period_no
	),
	CONSTRAINT u_TOT_Period UNIQUE  NONCLUSTERED 
	(
		time
	)
)
GO

/****** Object:  Table dbo.TOt_Rate    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TOt_Rate (
	position char (3) NOT NULL ,
	rate tinyint NOT NULL ,
	CONSTRAINT pk_TOt_Rate PRIMARY KEY  CLUSTERED 
	(
		position
	)
)
GO

/****** Object:  Table dbo.TOt_Semileave    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TOt_Semileave (
	id char (10) NOT NULL ,
	date1 datetime NOT NULL ,
	out_time datetime NOT NULL ,
	in_time datetime NOT NULL ,
	sum_period tinyint NOT NULL ,
	CONSTRAINT pk_TOt_Semileave PRIMARY KEY  CLUSTERED 
	(
		id,
		date1
	)
)
GO

/****** Object:  Table dbo.TOt_teachtable    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TOt_teachtable (
	dayofweek tinyint NOT NULL ,
	period_no tinyint NOT NULL ,
	id char (10) NOT NULL ,
	Roomcode char (6) NOT NULL ,
	class char (4) NOT NULL ,
	subj_code char (8) NOT NULL ,
	CONSTRAINT pk_Tot_teachtable PRIMARY KEY  CLUSTERED 
	(
		dayofweek,
		period_no,
		id
	),
	CONSTRAINT u_Tot_teachtable UNIQUE  NONCLUSTERED 
	(
		dayofweek,
		period_no,
		class
	),
	CONSTRAINT u2_Tot_teachtable UNIQUE  NONCLUSTERED 
	(
		dayofweek,
		period_no,
		Roomcode
	)
)
GO

/****** Object:  Table dbo.TOT_Type    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TOT_Type (
	TypeCode tinyint NOT NULL ,
	type varchar (20) NOT NULL ,
	CONSTRAINT pk_TOT_Type PRIMARY KEY  CLUSTERED 
	(
		TypeCode
	),
	CONSTRAINT U_TOT_Type UNIQUE  NONCLUSTERED 
	(
		type
	)
)
GO

/****** Object:  Table dbo.TPay_install    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TPay_install (
	year char (4) NOT NULL ,
	semester char (1) NOT NULL ,
	id char (10) NOT NULL ,
	time_no decimal(1, 0) NOT NULL ,
	bill_no decimal(5, 0) NULL ,
	date datetime NOT NULL ,
	entry decimal(5, 0) NOT NULL ,
	CONSTRAINT pk_TPay_install PRIMARY KEY  CLUSTERED 
	(
		year,
		semester,
		id,
		time_no
	)
)
GO

/****** Object:  Table dbo.TPay_list    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TPay_list (
	seq_no tinyint IDENTITY (1, 1) NOT NULL ,
	list varchar (35) NOT NULL ,
	CONSTRAINT pk_TPay_list PRIMARY KEY  CLUSTERED 
	(
		seq_no
	),
	CONSTRAINT u_TPay_List UNIQUE  NONCLUSTERED 
	(
		list
	)
)
GO

/****** Object:  Table dbo.TPay_Normal    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TPay_Normal (
	year char (4) NOT NULL ,
	semester char (1) NOT NULL ,
	id char (10) NOT NULL ,
	bill_no decimal(5, 0) NULL ,
	date datetime NOT NULL ,
	CONSTRAINT pk_TPay_normal PRIMARY KEY  CLUSTERED 
	(
		year,
		semester,
		id
	)
)
GO

/****** Object:  Table dbo.TPay_Rate    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TPay_Rate (
	year char (4) NOT NULL ,
	semester char (1) NOT NULL ,
	class char (4) NOT NULL ,
	seq_no tinyint NOT NULL ,
	debit decimal(7, 2) NOT NULL ,
	CONSTRAINT pk_TPay_rate PRIMARY KEY  CLUSTERED 
	(
		year,
		semester,
		class,
		seq_no
	),
	CONSTRAINT fk_tpay_rate FOREIGN KEY 
	(
		seq_no
	) REFERENCES dbo.TPay_list (
		seq_no
	)
)
GO

/****** Object:  Table dbo.TPay_std    Script Date: 27/5/41 15:48:21 ******/
CREATE TABLE dbo.TPay_std (
	id char (10) NOT NULL ,
	pName varchar (10) NOT NULL ,
	fname varchar (35) NOT NULL ,
	lname varchar (35) NOT NULL ,
	class char (4) NOT NULL ,
	CONSTRAINT pk_Tpay_std PRIMARY KEY  CLUSTERED 
	(
		id
	)
)
GO

/****** Object:  Table dbo.TPm_Rate    Script Date: 27/5/41 15:48:22 ******/
CREATE TABLE dbo.TPm_Rate (
	id char (10) NOT NULL ,
	rate decimal(3, 0) NOT NULL ,
	CONSTRAINT pk_TPm_Rate PRIMARY KEY  CLUSTERED 
	(
		id
	)
)
GO

/****** Object:  Table dbo.TPm_Replace    Script Date: 27/5/41 15:48:22 ******/
CREATE TABLE dbo.TPm_Replace (
	id char (10) NOT NULL ,
	date1 datetime NOT NULL ,
	subj_code char (12) NOT NULL ,
	class char (4) NOT NULL ,
	period_no tinyint NOT NULL ,
	CONSTRAINT pk_TPm_Replace PRIMARY KEY  CLUSTERED 
	(
		id,
		date1,
		subj_code,
		class
	),
	CONSTRAINT fk_tpm_replace FOREIGN KEY 
	(
		period_no
	) REFERENCES dbo.tot_period (
		period_no
	)
)
GO

/****** Object:  Table dbo.TPm_time    Script Date: 27/5/41 15:48:22 ******/
CREATE TABLE dbo.TPm_time (
	id char (10) NOT NULL ,
	date1 datetime NOT NULL ,
	in_time datetime NOT NULL ,
	out_time datetime NOT NULL ,
	CONSTRAINT pk_TPm_time PRIMARY KEY  CLUSTERED 
	(
		id,
		date1
	)
)
GO

/****** Object:  Table dbo.Tpus_com1    Script Date: 27/5/41 15:48:22 ******/
CREATE TABLE dbo.Tpus_com1 (
	com_no char (4) NOT NULL ,
	name char (50) NOT NULL ,
	address char (100) NOT NULL ,
	person1 char (50) NULL ,
	person2 char (50) NULL ,
	note char (40) NULL ,
	CONSTRAINT PK___2__13 PRIMARY KEY  CLUSTERED 
	(
		com_no
	)
)
GO

/****** Object:  Table dbo.Tpus_com2    Script Date: 27/5/41 15:48:22 ******/
CREATE TABLE dbo.Tpus_com2 (
	com_no char (4) NOT NULL ,
	no2 char (3) NOT NULL ,
	com_order char (30) NOT NULL ,
	spec char (30) NULL ,
	price decimal(9, 2) NULL ,
	note char (40) NULL ,
	CONSTRAINT PK___3__12 PRIMARY KEY  CLUSTERED 
	(
		com_no,
		no2
	),
	CONSTRAINT FK___4__12 FOREIGN KEY 
	(
		com_no
	) REFERENCES dbo.Tpus_com1 (
		com_no
	)
)
GO

/****** Object:  Table dbo.Tpus_order1    Script Date: 27/5/41 15:48:22 ******/
CREATE TABLE dbo.Tpus_order1 (
	no char (8) NOT NULL ,
	id1 char (10) NOT NULL ,
	id2 char (10) NOT NULL ,
	com_no char (4) NOT NULL ,
	date1 datetime NULL ,
	date2 datetime NULL ,
	brance char (2) NULL ,
	note char (40) NULL ,
	CONSTRAINT PK___4__13 PRIMARY KEY  CLUSTERED 
	(
		no
	),
	CONSTRAINT FK___5__13 FOREIGN KEY 
	(
		brance
	) REFERENCES dbo.TR_brance (
		brance_no
	),
	CONSTRAINT FK___6__13 FOREIGN KEY 
	(
		com_no
	) REFERENCES dbo.Tpus_com1 (
		com_no
	),
	CONSTRAINT FK___7__13 FOREIGN KEY 
	(
		id1
	) REFERENCES dbo.TR_T1 (
		T_ID
	),
	CONSTRAINT FK___8__13 FOREIGN KEY 
	(
		id2
	) REFERENCES dbo.TR_T1 (
		T_ID
	)
)
GO

/****** Object:  Table dbo.Tpus_order2    Script Date: 27/5/41 15:48:22 ******/
CREATE TABLE dbo.Tpus_order2 (
	no char (8) NOT NULL ,
	no1 char (3) NOT NULL ,
	order1 char (30) NOT NULL ,
	spec char (30) NULL ,
	price decimal(9, 2) NOT NULL ,
	number decimal(7, 2) NOT NULL ,
	note char (40) NULL ,
	CONSTRAINT PK___5__13 PRIMARY KEY  CLUSTERED 
	(
		no,
		no1
	),
	CONSTRAINT FK___9__13 FOREIGN KEY 
	(
		no
	) REFERENCES dbo.Tpus_order1 (
		no
	)
)
GO

/****** Object:  Table dbo.Tpus_pus1    Script Date: 27/5/41 15:48:22 ******/
CREATE TABLE dbo.Tpus_pus1 (
	pus_no char (10) NOT NULL ,
	pus_order char (30) NOT NULL ,
	spec char (30) NULL ,
	brance char (2) NULL ,
	place char (20) NULL ,
	note char (40) NULL ,
	status char (6) NULL ,
	CONSTRAINT PK_Tpus_pus1_1__12 PRIMARY KEY  CLUSTERED 
	(
		pus_no
	),
	CONSTRAINT FK_Tpus_pus1_2__12 FOREIGN KEY 
	(
		brance
	) REFERENCES dbo.TR_brance (
		brance_no
	)
)
GO

/****** Object:  Table dbo.TR_brance    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TR_brance (
	brance_no char (2) NOT NULL ,
	name char (15) NOT NULL ,
	CONSTRAINT PK___9__12 PRIMARY KEY  CLUSTERED 
	(
		brance_no
	)
)
GO

/****** Object:  Table dbo.TR_S1    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TR_S1 (
	S_ID char (10) NOT NULL ,
	F_name char (12) NOT NULL ,
	Name char (35) NOT NULL ,
	L_name char (35) NOT NULL ,
	Room char (4) NULL ,
	CONSTRAINT PK___1__12 PRIMARY KEY  CLUSTERED 
	(
		S_ID
	)
)
GO

/****** Object:  Table dbo.TR_S2    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TR_S2 (
	Major char (2) NOT NULL ,
	Major_Name char (15) NOT NULL ,
	Course char (5) NOT NULL ,
	CONSTRAINT PK___2__12 PRIMARY KEY  CLUSTERED 
	(
		Major
	)
)
GO

/****** Object:  Table dbo.TR_T1    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TR_T1 (
	T_ID char (10) NOT NULL ,
	F_name char (12) NOT NULL ,
	Name char (35) NOT NULL ,
	L_name char (35) NOT NULL ,
	brance char (2) NULL ,
	CONSTRAINT PK___8__12 PRIMARY KEY  CLUSTERED 
	(
		T_ID
	)
)
GO

/****** Object:  Table dbo.Tsal_basic    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.Tsal_basic (
	InvRate decimal(4, 2) NOT NULL ,
	taxRate decimal(4, 2) NOT NULL ,
	month tinyint NOT NULL 
)
GO

/****** Object:  Table dbo.TSal_Borr    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TSal_Borr (
	id char (10) NOT NULL ,
	time_no tinyint NOT NULL ,
	date1 datetime NOT NULL ,
	sum1 decimal(7, 2) NOT NULL ,
	CONSTRAINT pk_TSal_Borr PRIMARY KEY  CLUSTERED 
	(
		id,
		time_no
	)
)
GO

/****** Object:  Table dbo.TSal_Coop    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TSal_Coop (
	id char (10) NOT NULL ,
	date1 datetime NOT NULL ,
	sum1 decimal(7, 2) NOT NULL ,
	CONSTRAINT pk_TSal_Coop PRIMARY KEY  CLUSTERED 
	(
		id,
		date1
	)
)
GO

/****** Object:  Table dbo.TSal_Install    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TSal_Install (
	id char (10) NOT NULL ,
	time_no tinyint NOT NULL ,
	time_period tinyint NOT NULL ,
	date1 datetime NOT NULL ,
	sum1 decimal(7, 2) NOT NULL ,
	intrst decimal(7, 2) NOT NULL ,
	CONSTRAINT pk_TSal_Install PRIMARY KEY  CLUSTERED 
	(
		id,
		time_no,
		time_period
	)
)
GO

/****** Object:  Table dbo.TSal_InsType    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TSal_InsType (
	TypeCode tinyint NOT NULL ,
	Type varchar (35) NOT NULL ,
	CONSTRAINT pk_TSal_InsType PRIMARY KEY  CLUSTERED 
	(
		TypeCode
	),
	CONSTRAINT U_TSal_InsType UNIQUE  NONCLUSTERED 
	(
		Type
	)
)
GO

/****** Object:  Table dbo.TSal_Sal    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TSal_Sal (
	Id char (10) NOT NULL ,
	year char (4) NOT NULL ,
	salary decimal(7, 2) NOT NULL ,
	CONSTRAINT pk_tSal_Sal PRIMARY KEY  CLUSTERED 
	(
		Id,
		year
	)
)
GO

/****** Object:  Table dbo.TSal_Teach    Script Date: 27/5/41 15:48:23 ******/
CREATE TABLE dbo.TSal_Teach (
	id char (10) NOT NULL ,
	pName varchar (10) NOT NULL ,
	fname varchar (35) NOT NULL ,
	lname varchar (35) NOT NULL ,
	position char (3) NULL ,
	CONSTRAINT pk_Tsal_teach PRIMARY KEY  CLUSTERED 
	(
		id
	)
)
GO

/****** Object:  Stored Procedure dbo.Slib_changb2    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE Slib_changb2
        @call_no_1     char(20),  
        @call_no      char(20),
	@name         char(70), 
	@class_no     char(3),
	@class_name   char(35),
	@authour1     char(55),
	@authour2     char(55),
	@authour3     char(55),
	@publishing   char(60), 
	@year         char(4),
	@edition      char(3),
	@price        dec(8,2), 
	@class_borrow char(1)

AS
BEGIN TRAN
insert 
into tlib1_book2
values (@call_no,@name,@class_no,@class_name,@authour1,@authour2,@authour3  
        ,@publishing,@year,@edition,@price,@class_borrow )
update tlib1_book1
set   call_no = @call_no
where call_no = @call_no_1
delete Tlib1_book2
where call_no = @call_no_1
COMMIT
GO

/****** Object:  Stored Procedure dbo.Slib_changeb1    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE   Slib_changeb1
         @reg_no    char(6),
         @reg_no1   char(6),  
         @call_no1  char(20),
         @call_no   char(20),
         @date      datetime,
         @note      char(40)
AS
BEGIN TRAN
update tlib1_book1
  set call_no  = @call_no,
      reg_no   = @reg_no,
      date     = @date,
      note     = @note  
  where ( call_no = @call_no1)
         and (reg_no = @reg_no1)

delete Tlib1_book2
where call_no = @call_no1
COMMIT
GO

/****** Object:  Stored Procedure dbo.Slib_compareday    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE Slib_compareday 
	@day1  datetime,
        @day2  datetime,
        @day_over  int output
AS
BEGIN TRAN
select  @day_over = datediff(dd,@day1,@day2) 
COMMIT
GO

/****** Object:  Stored Procedure dbo.Slib_del_b1b2    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE Slib_del_b1b2 
	@reg_no char(6),
        @call_no char(20)    
AS
BEGIN TRAN
delete Tlib1_book1
where reg_no = @reg_no

delete Tlib1_book2
where call_no = @call_no
COMMIT
GO

/****** Object:  Stored Procedure dbo.Slib_Ldate_in    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE Slib_Ldate_in 
	@last_date   datetime
AS
BEGIN TRAN
delete Tlib1_lastdate
insert 
into Tlib1_lastdate
values (@last_date)
COMMIT
GO

/****** Object:  Stored Procedure dbo.Slib_sback    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE Slib_sback 
	@reg_no char(6),
        @s_id   char(10),
        @date_bor   datetime,
        @date_limit datetime, 
        @date_back  datetime,
        @yet1   char(1)
As  
BEGIN TRAN

if (@yet1 = '1') 
begin
insert
into tlib1_sback
values (@reg_no,@s_id,@date_bor,@date_limit,@date_back)
end

delete
from tlib1_sbor
where reg_no = @reg_no
COMMIT
GO

/****** Object:  Stored Procedure dbo.slib_sbacklate    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE slib_sbacklate
          @day_begin  datetime,
          @day_end    datetime
AS
select reg_no,Tlib1_sback.s_id,name,l_name,room,date_bor,date_limit,date_back ,datediff(dd,date_limit,date_back)
from Tlib1_sback,TR_s1
where       ( date_back > date_limit)
            and ( date_back  >= @day_begin)
            and (date_back  <=  @day_end)
            and(Tlib1_sback.s_id = TR_s1.s_id)
order by date_back,Tlib1_sback.s_id,date_bor
GO

/****** Object:  Stored Procedure dbo.Slib_sbook    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE Slib_sbook
	@reg_no   	char(6),
	@call_no	char(20),
	@date		datetime,
	@note		char(40),
	@name		char(70),
	@class_no       char(3),
	@class_name	char(35),
	@pub		char(60),
	@year		char(4),
	@ed		char(3),
	@at1		char(55),
	@at2		char(55),
	@at3		char(55),
	@price		dec,
	@c_bor          char(1)
AS
BEGIN TRAN
insert 
into Tlib1_book2
values (@call_no,@name,@class_no,@class_name,@at1,@at2,@at3,@pub,@year,@ed,@price,@c_bor)
insert 
into Tlib1_book1
values (@reg_no,@call_no,@date,@note)
COMMIT
GO

/****** Object:  Stored Procedure dbo.slib_sborlate1    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE slib_sborlate1 
	@date1  datetime 
AS
select Tlib1_sbor.reg_no,Tlib1_sbor.s_id,TR_S1.name,l_name,room,date_bor,date_limit,
       Tlib1_book2.name,price 	
from   Tlib1_sbor,TR_S1,Tlib1_book1,Tlib1_book2
where   (date_limit <  @date1)
        and (Tlib1_sbor.s_id = TR_S1.s_id)
        and (Tlib1_sbor.reg_no = Tlib1_book1.reg_no)
        and (Tlib1_book1.call_no = Tlib1_book2.call_no)        

order by Tlib1_sbor.s_id,date_bor,date_limit
GO

/****** Object:  Stored Procedure dbo.Slib_sd_sbor    Script Date: 27/5/41 15:48:24 ******/
CREATE PROCEDURE Slib_sd_sbor
	@day_begin datetime,
        @day_end   datetime
AS
BEGIN TRAN
select reg_no,Tlib1_sbor.s_id,name,L_name,room,date_bor,date_limit
from Tlib1_sbor,Tr_s1
where (date_bor >= @day_begin)
      and (date_bor <= @day_end)
      and (Tlib1_sbor.s_id = Tr_s1.s_id)

Union

select  reg_no,Tlib1_sback.s_id,name,L_name,room,date_bor,date_limit
from Tlib1_sback,Tr_s1
where (date_bor >= @day_begin)
      and (date_bor <= @day_end)
      and (Tlib1_sback.s_id = Tr_s1.s_id)

order by date_bor,2,date_limit
COMMIT
GO

/****** Object:  Stored Procedure dbo.Slib_sd_tbor    Script Date: 27/5/41 15:48:25 ******/
CREATE PROCEDURE Slib_sd_tbor
	@day_begin datetime,
        @day_end   datetime
AS
BEGIN TRAN
select reg_no,Tlib1_tbor.t_id,name,l_name,date_bor,date_limit
from Tlib1_tbor,TR_T1
where (date_bor >= @day_begin)
      and (date_bor <= @day_end)
      and (Tlib1_tbor.t_id = TR_T1.t_id)

Union

select  reg_no,Tlib1_tback.t_id,name,l_name,date_bor,date_limit
from Tlib1_tback,TR_T1
where (date_bor >= @day_begin)
      and (date_bor <= @day_end)
      and (Tlib1_tback.t_id = TR_T1.t_id)

order by date_bor,2,date_limit

COMMIT
GO

/****** Object:  Stored Procedure dbo.slib_sum_s    Script Date: 27/5/41 15:48:25 ******/
CREATE PROCEDURE slib_sum_s
           @day_begin  datetime,
           @day_end    datetime   
           
AS

select sum( datediff(dd,date_limit,date_back) )
from Tlib1_sback
where      ( date_back > date_limit)
            and ( date_back  >= @day_begin)
            and (date_back  <=  @day_end)
GO

/****** Object:  Stored Procedure dbo.slib_sum_t    Script Date: 27/5/41 15:48:25 ******/
CREATE PROCEDURE slib_sum_t
           @day_begin  datetime,
           @day_end    datetime   
           
AS

select  sum( datediff(dd,date_limit,date_back) )
from Tlib1_tback
where      ( date_back > date_limit)
            and ( date_back  >= @day_begin)
            and (date_back  <=  @day_end)
GO

/****** Object:  Stored Procedure dbo.Slib_tback    Script Date: 27/5/41 15:48:25 ******/
CREATE PROCEDURE Slib_tback 
	@reg_no char(6),
        @t_id   char(10),
        @date_bor   datetime,
        @date_limit datetime, 
        @date_back  datetime,
        @yet1   char(1)  
As  
BEGIN TRAN

if @yet1 = '1'
begin
insert
into tlib1_tback
values (@reg_no,@t_id,@date_bor,@date_limit,@date_back)
end

delete
from tlib1_tbor
where reg_no = @reg_no
COMMIT
GO

/****** Object:  Stored Procedure dbo.Slib_tbacklate    Script Date: 27/5/41 15:48:25 ******/
CREATE PROCEDURE Slib_tbacklate 
         @day_begin  datetime,
         @day_end    datetime

AS
select reg_no,Tlib1_tback.t_id,name,l_name,date_bor,date_limit,date_back,datediff(dd,date_limit,date_back)
from Tlib1_tback,TR_T1
where   date_back  > date_limit
             and ( date_back  >= @day_begin)
             and (date_back  <=  @day_end)
             and (Tlib1_tback.t_id = TR_T1.t_id)
order by date_back,Tlib1_tback.t_id,date_bor
GO

/****** Object:  Stored Procedure dbo.slib_tborlate    Script Date: 27/5/41 15:48:25 ******/
CREATE PROCEDURE slib_tborlate
      @date1  datetime
AS
select Tlib1_tbor.reg_no,Tlib1_tbor.t_id,TR_T1.name,l_name,date_bor,date_limit,
       Tlib1_book2.name,price
from Tlib1_tbor,TR_T1,Tlib1_book1,Tlib1_book2
where  ( date_limit <  @date1)
       and (Tlib1_tbor.t_id = TR_T1.t_id)
       and (Tlib1_tbor.reg_no = Tlib1_book1.reg_no)
       and (Tlib1_book1.call_no = Tlib1_book2.call_no)        
 
order by Tlib1_tbor.t_id,date_bor,date_limit
GO

/****** Object:  Stored Procedure dbo.spAccEAdd    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccEAdd
(@date char(8) ,@type varchar(35),@list varchar(35),
 @sum1 decimal(10,2),@dest varchar(35))
as
declare @No tinyint
declare @Tcode tinyint

select @No = (isnull(max(seq_no),0)+1)
from TAcc_exp
where date1 = convert(datetime,@date,3)

 select @Tcode = typecode
from TAcc_etype
where type = @type

insert TAcc_exp
values(@No,convert(datetime,@date,3),@Tcode,@list,@sum1,@dest)

select  
        convert(char(8),date1,3) as'วันที่', type as 'ประเภท' ,
	list as 'รายการ', dest as 'ผู้รับ',sum1 as 'จำนวนเงิน'
 
from Tacc_exp,tacc_etype
where Tacc_exp.typecode = tacc_etype.typecode and
	date1 = convert(datetime,@date,3)
order by date1,seq_no
GO

/****** Object:  Stored Procedure dbo.spAccEAddListSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccEAddListSch(@date char(8))
as
select   convert(char(8),date1,3) as 'วันที่', type as 'ประเภท' ,
	list as 'รายการ', dest as 'ผู้รับ',sum1 as 'จำนวนเงิน'
from Tacc_exp,tacc_Etype
where Tacc_exp.typecode = tacc_Etype.typecode and
	date1= convert(datetime,@date,3) 
order by date1,Tacc_exp.typecode,seq_no
GO

/****** Object:  Stored Procedure dbo.spAccEAddNo    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccEAddNo(@date varchar(8))
as
declare @no tinyint
select @No = (isnull(max(seq_no),0)+1)
from TAcc_Exp
where date1 = convert(datetime,@date,3)

return @no

GO

/****** Object:  Stored Procedure dbo.spAccEchgDel    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccEchgDel
(@date char(8) ,@seq tinyint)
as

delete Tacc_exp
where date1 = convert(datetime,@date,3)
 and seq_no = @seq
GO

/****** Object:  Stored Procedure dbo.spAccEchgEdit    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccEchgEdit
(@date varchar(8) ,@seq tinyint, @type varchar(35),
 @list varchar(35), @sum1 decimal(10,2),@dest varchar(35))
as
declare @No tinyint
declare @Tcode tinyint

select @Tcode = typecode
from TAcc_etype
where type = @type

update Tacc_exp
set typecode = @Tcode,
    list     = @list,
    sum1     = @sum1,
    dest     = @dest	
where date1 = convert(datetime,@date,3) and seq_no = @seq


GO

/****** Object:  Stored Procedure dbo.spAccEChgSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccEChgSch
(@date1 varchar(8) ,@date2 varchar(8) ,@type varchar(35))
as

declare @Tcode tinyint

select convert(char(8),date1,3) as 'วันที่',seq_no as 'ลำดับที่',  type as 'ประเภท' ,
	list as 'รายการ', dest as 'ผู้รับ',sum1 as 'จำนวนเงิน'
from tAcc_exp,tAcc_Etype
where  tAcc_exp.typecode = tAcc_Etype.typecode 
	and (date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3))
	and tAcc_exp.typecode = any
		(select typecode
		 from TAcc_etype
 		 where type like @type)
order by date1,tAcc_exp.typecode ,seq_no
GO

/****** Object:  Stored Procedure dbo.spAccErpt    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccErpt
(@date1 char(8) , @date2 char(8),@type varchar(35))
as

select  seq_no,date1,type,list,dest,sum1
from    Tacc_exp,Tacc_Etype 
where 	Tacc_Exp.typecode = Tacc_Etype.typecode  and
	date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3)
	and type = @type 

GO

/****** Object:  Stored Procedure dbo.spAccESumSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccESumSch   
 (@date1 varchar(8) ,@date2 varchar(8) ,@type varchar(35))
as
declare @sum1 decimal(10,2)
select @sum1=sum(sum1)
from tAcc_exp,tAcc_Etype
where  tAcc_exp.typecode = tAcc_Etype.typecode 
	and (date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3))
	and tAcc_exp.typecode = any
		(select typecode
		 from TAcc_etype
 		 where type like @type)
GO

/****** Object:  Stored Procedure dbo.spAccRAdd    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccRAdd
(@date varchar(8) ,@type varchar(35),@list varchar(35),
 @sum1 decimal(10,2),@source varchar(35))
as
declare @No tinyint
declare @Tcode tinyint

select @No = (isnull(max(seq_no),0)+1)
from TAcc_Rec
where date1 = convert(datetime,@date,3)

select @Tcode = typecode
from TAcc_Rtype
where type = @type

insert TAcc_Rec
values(@No,convert(datetime,@date,3),@Tcode,@list,@sum1,@source)

select   convert(char(8),date1,3) as 'วันที่',  type as 'ประเภท' ,
	list as 'รายการ', source as 'ผู้จ่าย',sum1 as 'จำนวนเงิน'
	 
from Tacc_rec,tacc_Rtype
where Tacc_Rec.typecode = tacc_Rtype.typecode and
	date1 = convert(datetime,@date,3) 
order by date1,seq_no

--if (select count(*)
--	from TAcc_Rec
--	where seq_no = @no and 
--		date1 = convert(datetime,@date,3))=1
--	return 1
--else
--	return 2
GO

/****** Object:  Stored Procedure dbo.spAccRAddListSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccRAddListSch(@date char(8))
as
select  convert(char(8),date1,3) as 'วันที่',  type as 'ประเภท' ,
	list as 'รายการ', source as 'ผู้จ่าย',sum1 as 'จำนวนเงิน'
from Tacc_rec,tacc_Rtype
where Tacc_Rec.typecode = tacc_Rtype.typecode and
	date1 = convert(datetime,@date,3) 
order by date1,Tacc_Rec.typecode,seq_no
GO

/****** Object:  Stored Procedure dbo.spAccRAddNo    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccRAddNo(@date varchar(8))
as
declare @no tinyint
select @No = (isnull(max(seq_no),0)+1)
from TAcc_Rec
where date1 = convert(datetime,@date,3)

return @no
GO

/****** Object:  Stored Procedure dbo.spAccRchgDel    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccRchgDel
(@date varchar(8) ,@seq tinyint)
as

delete Tacc_rec
where date1 = convert(datetime,@date,3) and seq_no = @seq


GO

/****** Object:  Stored Procedure dbo.spAccRchgEdit    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccRchgEdit
(@date varchar(8) ,@seq tinyint, @type varchar(35),
 @list varchar(35), @sum1 decimal(10,2),@source varchar(35))
as
declare @No tinyint
declare @Tcode tinyint

select @Tcode = typecode
from TAcc_Rtype
where type = @type

update Tacc_rec
set typecode = @Tcode,
    list     = @list,
    sum1     = @sum1,
    source   = @source	
where date1 = convert(datetime,@date,3) and seq_no = @seq


GO

/****** Object:  Stored Procedure dbo.spAccRChgSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccRChgSch
(@date1 varchar(8) ,@date2 varchar(8) ,@type varchar(35))
as

declare @Tcode tinyint

--select @Tcode = typecode
--from TAcc_Rtype
--where type = @type

select convert(char(8),date1,3) as 'วันที่',seq_no as 'ลำดับที่',  type as 'ประเภท' ,
	list as 'รายการ', source as 'ผู้จ่าย',sum1 as 'จำนวนเงิน'

from tAcc_rec,tAcc_Rtype
where  tAcc_rec.typecode = tAcc_Rtype.typecode 
	and (date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3))
	and tAcc_rec.typecode = any
	      ( select  typecode
		from TAcc_Rtype
		where type like @type)
order by date1,tAcc_rec.typecode ,seq_no
GO

/****** Object:  Stored Procedure dbo.spAccRrpt    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccRrpt
(@date1 char(8) , @date2 char(8),@type varchar(35))
as

select  seq_no,date1,type,list,source,sum1
from    Tacc_rec ,Tacc_Rtype 
where 	Tacc_rec.typecode = Tacc_Rtype.typecode  and
	date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3)
	and type = @type 

GO

/****** Object:  Stored Procedure dbo.spAccRSumSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spAccRSumSch   
 (@date1 varchar(8) ,@date2 varchar(8) ,@type varchar(35))
as

declare @sum1 decimal(10,2)

select @sum1 =sum(sum1)
from tAcc_rec,tAcc_Rtype
where  tAcc_rec.typecode = tAcc_Rtype.typecode 
	and (date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3))
	and tAcc_rec.typecode = any
		(select typecode
		 from TAcc_Rtype
 		 where type like @type)
GO

/****** Object:  Stored Procedure dbo.spBasicEdit    Script Date: 27/5/41 15:48:25 ******/
create procedure spBasicEdit
(@year char(4), @semester char(1))
as

declare @ever tinyint



if (select count(*) from  TBasic) = 0
  insert tBasic 
  values (@year,@semester)
else
  update TBasic 
  set year = @year,
      semester = @semester


GO

/****** Object:  Stored Procedure dbo.spBasicSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spBasicSch
as

select *
from TBasic


GO

/****** Object:  Stored Procedure dbo.spOtAbsentSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spOtAbsentSch(@id char(10),@date1 char(8),@date2 char(8))
as
select date1 as 'วันที่', period_no as 'คาบที่'
from TOt_absent
where absentid = @id and
      date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3)
order by date1, period_no
GO

/****** Object:  Stored Procedure dbo.spOtCalSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spOtCalSch(@id char(10),@date1 char(8))
as

select  isnull(sum(case when  datepart(dw,i.date1) = 2 then 1 else 0 end) ,0) as w1,
        isnull(sum(case when  datepart(dw,i.date1) = 3 then 1 else 0 end) ,0) as w2,
        isnull(sum(case when  datepart(dw,i.date1) = 4 then 1 else 0 end) ,0) as w3,
        isnull(sum(case when  datepart(dw,i.date1) = 5 then 1 else 0 end) ,0) as w4,
        isnull(sum(case when  datepart(dw,i.date1) = 6 then 1 else 0 end) ,0) as w5
from Tot_Inout i,Tot_Teachtable t,TOt_absent a
where  (datepart(dw,i.date1) = t.dayofweek)  and
      (a.date1 = i.date1) and t.period_no = a.period_no and
	(a.absentid = @id) and (i.id= @id) and (t.id = @id) and
      (a.date1 between convert(datetime,@date1,3) and
         dateadd(dd,4,convert(datetime,@date1,3)) ) and
      (i.date1 between convert(datetime,@date1,3) and
         dateadd(dd,4,convert(datetime,@date1,3) ) )
GO

/****** Object:  Stored Procedure dbo.spOtInOutSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spOtInOutSch(@id char(10),@date1 char(8),@date2 char(8))
as

select date1 as 'วันที่', convert(char(8),in_time,8) as 'เวลาเข้า',convert(char(8),out_time,8) as 'เวลาออก'
from TOt_Inout 
where id = @id and
	date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3)
order by date1
GO

/****** Object:  Stored Procedure dbo.spOtPerfSch    Script Date: 27/5/41 15:48:25 ******/
create procedure spOtPerfSch(@id char(10),@date1 char(8),@m tinyint output,

		             @t tinyint output,@w tinyint output,
			     @th tinyint output,@f tinyint output)

as

declare @date datetime

select @date = convert(datetime,@date1,3)

--monday
select @m = count(*)
from Tot_Inout i,Tot_Teachtable t
where   (i.id= @id) and (t.id = @id) and
	(datepart(dw,i.date1) = t.dayofweek)  and
        i.date1 = @date

if (@m <> 0)
  select @m = @m
		-(select count(*)
		  from TOt_absent a,Tot_Teachtable t 
		  where (a.absentid= @id) and (t.id = @id) and
	               (datepart(dw,a.date1) = t.dayofweek)  and 
		        a.date1 = @date and a.period_no =t.period_no)
		+(select count(*)
		  from TOt_absent a
		  where (a.replaceid= @id)  and  a.date1 = @date)

select @date = dateadd(dd,1,@date)

--tueday
select @t = count(*)
from Tot_Inout i,Tot_Teachtable t
where   (i.id= @id) and (t.id = @id) and
	(datepart(dw,i.date1) = t.dayofweek)  and
        i.date1 = @date

if (@t <> 0)
  select @t = @t
		-(select count(*)
		  from TOt_absent a,Tot_Teachtable t 
		  where (a.absentid= @id) and (t.id = @id) and
	               (datepart(dw,a.date1) = t.dayofweek)  and 
		        a.date1 = @date and a.period_no =t.period_no)
		+(select count(*)
		  from TOt_absent a
		  where (a.replaceid= @id)  and  a.date1 = @date)

select @date = dateadd(dd,1,@date)

--wednesday
select @w = count(*)
from Tot_Inout i,Tot_Teachtable t
where   (i.id= @id) and (t.id = @id) and
	(datepart(dw,i.date1) = t.dayofweek)  and
        i.date1 = @date

if (@w <> 0)
  select @w = @w
		-(select count(*)
		  from TOt_absent a,Tot_Teachtable t 
		  where (a.absentid= @id) and (t.id = @id) and
	               (datepart(dw,a.date1) = t.dayofweek)  and 
		        a.date1 = @date and a.period_no =t.period_no)
		+(select count(*)
		  from TOt_absent a
		  where (a.replaceid= @id)  and  a.date1 = @date)

select @date = dateadd(dd,1,@date)

--thursday
select @th = count(*)
from Tot_Inout i,Tot_Teachtable t
where   (i.id= @id) and (t.id = @id) and
	(datepart(dw,i.date1) = t.dayofweek)  and
        i.date1 = @date

if (@th <> 0)
  select @th = @th
		-(select count(*)
		  from TOt_absent a,Tot_Teachtable t 
		  where (a.absentid= @id) and (t.id = @id) and
	               (datepart(dw,a.date1) = t.dayofweek)  and 
		        a.date1 = @date and a.period_no =t.period_no)
		+(select count(*)
		  from TOt_absent a
		  where (a.replaceid= @id)  and  a.date1 = @date)

select @date = dateadd(dd,1,@date)

--friday
select @f = count(*)
from Tot_Inout i,Tot_Teachtable t
where   (i.id= @id) and (t.id = @id) and
	(datepart(dw,i.date1) = t.dayofweek)  and
        i.date1 = @date

if (@f <> 0)
  select @f = @f
		-(select count(*)
		  from TOt_absent a,Tot_Teachtable t 
		  where (a.absentid= @id) and (t.id = @id) and
	               (datepart(dw,a.date1) = t.dayofweek)  and 
		        a.date1 = @date and a.period_no =t.period_no)
		+(select count(*)
		  from TOt_absent a
		  where (a.replaceid= @id)  and  a.date1 = @date)
GO

/****** Object:  Stored Procedure dbo.spOtRateSch    Script Date: 27/5/41 15:48:26 ******/
create procedure spOtRateSch (@id char(10))
as

select rate
from Tot_rate
where position  = substring(@id,5,3)
GO

/****** Object:  Stored Procedure dbo.spOtRepSch    Script Date: 27/5/41 15:48:26 ******/
create procedure spOtRepSch(@id char(10),@date1 char(8),@date2 char(8))
as
select date1 as 'วันที่', period_no as 'คาบที่'
from TOt_absent
where replaceid = @id and
      date1 between convert(datetime,@date1,3) and convert(datetime,@date2,3)
order by date1, period_no
GO

/****** Object:  Stored Procedure dbo.spOtTableSch    Script Date: 27/5/41 15:48:26 ******/
create procedure spOtTableSch(@id char(10))
as

select dayofweek as 'วันของสัปดาห์',period_no as 'คาบที่',
	subj_code  as 'รหัสวิชา',class as 'ห้อง',roomcode as 'ห้องเรียน'
from TOt_teachtable
where id = @id
order by dayofweek,period_no
GO

/****** Object:  Stored Procedure dbo.spOtTableSum    Script Date: 27/5/41 15:48:26 ******/
create procedure spOtTableSum(@id char(10),@m tinyint output,
		             @t tinyint output,@w tinyint output,
			     @th tinyint output,@f tinyint output)
as

select @m = count(*)
from TOt_teachtable
where id = @id and  dayofweek = 2

select @t = count(*)
from TOt_teachtable
where id = @id and  dayofweek = 3

select @w = count(*)
from TOt_teachtable
where id = @id and  dayofweek = 4

select @th = count(*)
from TOt_teachtable
where id = @id and  dayofweek = 5

select @f = count(*)
from TOt_teachtable
where id = @id and  dayofweek = 6


GO

/****** Object:  Stored Procedure dbo.spPayInsSch    Script Date: 27/5/41 15:48:26 ******/
create procedure spPayInsSch(@year char(4),@semester char(1),
                             @id char(10),@No tinyint output,
			     @credit decimal(5,0) output,
			     @date  char(15) output)
as 
 
 
select @no = count(*)+1,@credit = isnull(sum(entry),0),@date = isnull(convert(char(15),max(date),103),'00/00/0000')
from tpay_install
where year = @year and semester = @semester and id = @id
GO

/****** Object:  Stored Procedure dbo.spPayInstallIns    Script Date: 27/5/41 15:48:26 ******/
create procedure spPayInstallIns(@year char(4),@semester char(1), @id char(10),
		           @no decimal(1,0),@date char(8),@entry decimal(5,0))
as

insert TPay_install
values(@year,@semester,@id,@no,default,convert(datetime,@date,3),@entry)

GO

/****** Object:  Stored Procedure dbo.spPayListIns    Script Date: 27/5/41 15:48:26 ******/
create procedure spPayListIns
(@list varchar(35))
as
declare @No tinyint


insert Tpay_list
values (@list)



GO

/****** Object:  Stored Procedure dbo.spPayListSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spPayListSch
as

select list
from Tpay_list
GO

/****** Object:  Stored Procedure dbo.spPayNorIns    Script Date: 27/5/41 15:48:27 ******/
create procedure spPayNorIns(@year char(4),@semester char(1), @id char(10),
		           @date char(8))
as

insert TPay_normal
values(@year,@semester,@id,default,convert(datetime,@date,3))
GO

/****** Object:  Stored Procedure dbo.sppayNorSch    Script Date: 27/5/41 15:48:27 ******/
create procedure sppayNorSch(@year char(4),@semester char(1),
                             @id char(10),@dateC  char(15) output)
as 


  select @dateC = convert(char(15),date,103)
  from tpay_normal
  where year = @year and semester = @semester and id = @id
GO

/****** Object:  Stored Procedure dbo.spPayRateIns    Script Date: 27/5/41 15:48:27 ******/
create procedure spPayRateIns 
(@year char(4), @semester char(1), @class char(4),
 @list varchar(35), @debit  decimal(7,2))
as

declare @No tinyint

select @No = seq_no
from Tpay_list
where list = @list

insert Tpay_Rate
values (@year,@semester,@class,@no,@debit)


GO

/****** Object:  Stored Procedure dbo.spPayRateSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spPayRateSch(@year char(4),@semester char(1),
			      @class char(4))
as

select list as 'รายการ',debit as 'จำนวนเงิน'
from  TPay_rate r,tpay_list l
where r.seq_no=l.seq_no and year=@year and 
      semester = @semester and class = @class
GO

/****** Object:  Stored Procedure dbo.spPayRptNot    Script Date: 27/5/41 15:48:27 ******/
create procedure spPayRptNot (@year char(4),@semester char(4),@class char(4))
as
select s_id as 'รหัสนักศึกษา',f_name as 'คำนำหน้า',name as 'ชื่อ',l_name as 'นามสกุล' ,room as 'ห้อง'
from Tr_s1
where room like @class and s_id <> all 
	(select  id
	from Tpay_normal
	where year = @year and semester = @semester
	
	union
	
	select id
	from Tpay_install
	where year = @year and semester = @semester
	)
order by room,S_id
GO

/****** Object:  Stored Procedure dbo.spPayRptNotComp    Script Date: 27/5/41 15:48:27 ******/
create procedure spPayRptNotComp(@year char(4),@semester char(4),@class char(4))
as
select s_id as 'รหัสนักศึกษา',f_name as 'คำนำหน้า',name as 'ชื่อ',l_name as 'นามสกุล' ,room as 'ห้อง'
from Tr_s1
where room like @class and s_id <> all 
	(select  id
	from Tpay_normal
	where year = @year and semester = @semester
	
	union
	
	select t1.id 
	from Tpay_install t1
	where  t1.year = @year and t1.semester =  @semester 
	group by t1.id  
	having sum(entry) =( select sum(debit)
				 from tr_s1 t2,tpay_rate t3
				 where t1.id = t2.S_id and t2.room = t3.class
				 	and t3.year =@year and t3.semester =  @semester  )
	
	)
order by room,S_id
GO

/****** Object:  Stored Procedure dbo.sppayRptSum    Script Date: 27/5/41 15:48:27 ******/
create procedure sppayRptSum
(@date1 varchar(8) ,@date2 varchar(8))
as

select t1.id as 'รหัสนักศึกษา',date as 'วันที่',convert(decimal(5,0),sum(debit)) as 'จำนวนเงิน'

from tpay_normal t1,tr_s1 t2,tpay_Rate t3 
where t1.id =t2.s_id and t2.room = t3.class and t1.year = t3.year and t1.semester = t3.semester
	and (date between convert(datetime,@date1,3) and convert(datetime,@date2,3))
group by class,t1.id,date
  
union

select id,date,sum(entry) 
from tpay_install
where (date between convert(datetime,@date1,3) and convert(datetime,@date2,3))
group by id,date

order by 2,1
GO

/****** Object:  Stored Procedure dbo.spSalBorChk    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalBorChk(@id char(10),@time_no tinyint output,
			     @bal decimal(7,2) output,@bor decimal(7,2) output )
as

select @time_no = (isnull(max(time_no),0))
from Tsal_borr
where id = @id

if (@time_no <> 0)
begin
select @bor = isnull(sum1,0)
from Tsal_Borr
where (id = @id) and 
time_no = @time_no
	   
select @bal = @bor -isnull(sum(sum1),0)
from Tsal_install
where (id = @id) and
time_no = @time_no
end
GO

/****** Object:  Stored Procedure dbo.spSalBorIns    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalBorIns(@id char(10),@time_no tinyint,
	                      @date1 char(8),@sum1 decimal(7,2))
as

insert Tsal_Borr
values (@id,@time_no,convert(datetime,@date1,3),@sum1)



GO

/****** Object:  Stored Procedure dbo.spSalCoEdit    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalCoEdit(@id char(10), @date1 char(8),
				@sum decimal(7,2))
as

declare @date2 datetime

select @date2 = convert(datetime,@date1,3)

update TSal_Coop
set sum1 = @sum
where id = @id and (datepart(month,date1) = datepart(month,@date2))
      and (datepart(year,date1) = datepart(year,@date2))
GO

/****** Object:  Stored Procedure dbo.spSalCoIns1    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalCoIns1(@id char(10),
	         @date1 char(8),@sum1 decimal(7,2),@status tinyint output)
as 

declare @date2 datetime

select @date2 = convert(datetime,@date1,3)

if (    select count(*)
 	from Tsal_Coop 
	where id = @id and (datepart(month,date1) = datepart(month,@date2))
               and (datepart(year,date1) = datepart(year,@date2)) ) = 0 
--then
  begin 
  insert Tsal_Coop 
   values(@id,@date2,@sum1)
  select @status = 1	
   end
 else 
 select @status = 2
GO

/****** Object:  Stored Procedure dbo.spSalCoSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalCoSch(@id char(10),@date1 char(8))
as

declare @date2 datetime

select @date2 = convert(datetime,@date1,3)

select sum1
from TSal_Coop
where id = @id and (datepart(month,date1) = datepart(month,@date2))
      and (datepart(year,date1) = datepart(year,@date2)) 

GO

/****** Object:  Stored Procedure dbo.spSalInstIdSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalInstIdSch
as

declare @time_no tinyint

select distinct b.id
from Tsal_Borr b,Tsal_Install i
where  b.id = i.id and
       b.time_no = i.time_no
group by b.id,b.time_no
having max(b.sum1) >sum(i.sum1)

union

select distinct id
from Tsal_Borr
where  id <> all
(select distinct id
from Tsal_Install )

 
union

select distinct b.id
from Tsal_Borr b,Tsal_Install i
where  b.id = i.id 
group by b.id
having max(b.time_no) > max(i.time_no)
GO

/****** Object:  Stored Procedure dbo.spSalInstIns    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalInstIns(@id char(10),@no tinyint,
	@period tinyint,@date1 char(8),@sum1 decimal(7,2),
	@int decimal(7,2),@status tinyint output)
as

declare @date2 datetime

select @date2 = convert(datetime,@date1,3)

if (    select count(*)
 	from Tsal_install
	where id = @id and (datepart(month,date1) = datepart(month,@date2))
               and (datepart(year,date1) = datepart(year,@date2)) ) = 0 
insert Tsal_Install
values (@id,@no,@period,convert(datetime,@date1,3),@sum1,@int)
else  select @status = 1
GO

/****** Object:  Stored Procedure dbo.spSalInstNoSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalInstNoSch(@id char(10),@No tinyint output,
 		@Period tinyint output,@debit decimal(7,2) output,
		@credit decimal(7,2) output,@rate decimal(4,2) output,
		@int decimal(7,2) output)
as
--ever install but not complete in this time_no

begin
if (@id =any 
	(select distinct b.id
	from Tsal_Borr b,Tsal_Install i
	where  b.id = i.id and
        b.time_no = i.time_no
	group by b.id,b.time_no
	having max(b.sum1) >sum(i.sum1)))
begin
select @No = b.time_no,@period = max(time_period)+1 ,
	@debit = max(b.sum1),@credit = sum(i.sum1),@int = sum(i.intrst)
	from Tsal_Borr b,Tsal_Install i
	where b.id = @id and
	b.id = i.id and
        b.time_no = i.time_no
	group by b.id,b.time_no
	having max(b.sum1) >sum(i.sum1)
end

--ever install but not ever install in this time_no
else if (@id = any
	(select distinct b.id
	from Tsal_Borr b,Tsal_Install i
	where  b.id = i.id 
	group by b.id
	having max(b.time_no) > max(i.time_no) ))
begin
select @No = max(b.time_no),@period = 1,
@debit = max(b.sum1),@credit = 0,@int = 0
from Tsal_Borr b
,Tsal_Install i
where  b.id = @id  and
        b.time_no = 
	(select max(i.time_no) +1
	from Tsal_Install i
	where   i.id = @id)
group by b.id,b.time_no
--having max(b.time_no) > max(i.time_no)
end

--not ever install
else if (@id = any
	(select distinct id
	from Tsal_Borr
	where  id <> all
	(select distinct id
	from Tsal_Install ))
)
begin
select @No = min(time_No),@period = 1,
@debit = max(sum1),@credit = 0,@int = 0
from tsal_borr
where id = @id  and time_no =
		(select min(time_No) 
		from tsal_borr
		where  id = @id  )
	
 	
	
end


end
select @rate = invrate
from TSal_basic

--max time + 1 that borrow amount = install amount  
--select @No = count(b.time_no)+1
--isnull(max(id),0)+1
--from  Tsal_Borr b,TSal_Install i
--where b.id *= i.id and b.id = @id
--group by b.time_no
--having max(b.sum1) = sum(i.sum1)

--find install period no 
--select @period = isnull(max(time_period),0)+1 
--from Tsal_install
--where   id = @id and
--	Time_no = @no

 
--select @debit = max(b.sum1),@credit = sum(i.sum1)
--from   Tsal_Borr b,TSal_Install i
--where  b.id *= i.id and
--       b.id = @id   and
--       b.time_no = i.time_no and
--       b.time_no = @no
GO

/****** Object:  Stored Procedure dbo.spSalInstRptSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalInstRptSch(@id char(10),@time_no tinyint,
				@date char(8),@button tinyint output )
as

declare @date2 datetime
declare @date3 datetime
/*
if  
((select count(*)
from tsal_install i
where i.id = @id 
and i.time_no = @time_no ) > 0)
	(select  @date2 =max(i.date1)
	from tsal_install i
	where i.id = @id 
	and i.time_no = @time_no )
else

   (select @date2 =max(date1)
   from tsal_borr
   where id = @id 
    and time_no = @time_no )



select @date3 = convert(datetime,@date,3)

if (datediff(yy,@date2,@date3) < 0)
  select @button = 1
else if (datediff(yy,@date2,@date3) > 0)
  select @button =6
else if (datediff(yy,@date2,@date3) = 0)
  begin
  if (datepart(mm,@date2) > datepart(mm,@date3))
	select @button = 2
  else if (datepart(mm,@date2) < datepart(mm,@date3))
	select @button = 7
  else if (datepart(dd,@date2) <= datepart(dd,@date3))	select @button = 8
  else select @button = 3
  end
*/

select id as 'รหัส',time_no as 'ครั้งที่' , time_period as 'งวดที่',
	date1 as 'วันที่' , sum1 as 'เงินต้น', intrst as 'ดอกเบี้ย'
     
from Tsal_install
where id = @id and time_no = @time_no
GO

/****** Object:  Stored Procedure dbo.spSalmonthSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalmonthSch(@mm tinyint output)
as

select @mm = month
from TSal_basic

GO

/****** Object:  Stored Procedure dbo.spSalRpt    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalRpt(@id char(10),@date char(8),
		@sal  decimal(7,2) output, @bor  decimal(7,2) output,
		@int decimal(7,2) output,@Co decimal(7,2) output,
		@taxrate decimal(4,2) output)
as 
declare @date2 datetime 
declare @year integer

select @date2 = convert(datetime,@date,3)

if (datepart(mm,@date2) < (select max(month) from tsal_basic))
 	select @year = datepart(yy,@date2)-1+543
else
	select @year = datepart(yy,@date2)+543

select @sal = isnull(salary,0)
from TSal_Sal
where id = @id and year = convert(char(4),@year)

select @bor = isnull(sum1,0),@int = isnull(intrst,0)
from Tsal_install
where id = @id and datepart(mm,date1) = datepart(mm,@date2) and
	datepart(yy,date1) = datepart(yy,@date2)
 
select @co = isnull(sum1,0)
from Tsal_coop
where id = @id and datepart(mm,date1) = datepart(mm,@date2) and
	datepart(yy,date1) = datepart(yy,@date2)

select @taxrate = taxrate
from TSal_basic
GO

/****** Object:  Stored Procedure dbo.spSalRptSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalRptSch(@id char(10),@date1 char(8))
as

declare @year smallint
declare @salary decimal(7,2)
declare @taxRate decimal(4,2)
declare @Coop decimal(7,2)
declare @Inst decimal(7,2)

if datepart(mm,convert(datetime,@date1,3)) >= 6 
-- >= select month
--	from Tsal_Basic

    select @year = datepart(yy,convert(datetime,@date1,3))+543
else
    select @year = datepart(yy,convert(datetime,@date1,3))-1+543

select @salary=salary
from tsal_sal
where id = @id and
	year = convert(char(4),@year)

--select @taxRate = taxrate
--from TSal_Basic

select @Coop = isnull(sum(sum1),0)
from TSal_Coop
where id = @id and
      datepart(mm,date1)=datepart(mm,convert(datetime,@date1,3)) and
      datepart(yy,date1)=datepart(yy,convert(datetime,@date1,3)) 



select @inst = isnull(sum(sum1),0)
from TSal_install
where id = @id and
      datepart(mm,date1)=datepart(mm,convert(datetime,@date1,3)) and
      datepart(yy,date1)=datepart(yy,convert(datetime,@date1,3)) 

select @salary,@taxrate,@Coop,@Inst
GO

/****** Object:  Stored Procedure dbo.spSalSalEdit    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalSalEdit(@id char(10), @year char(4),
				@salary decimal(7,2))
as

update TSal_sal
set salary = @salary
where id= @id and year = @year


GO

/****** Object:  Stored Procedure dbo.spSalSalIns    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalSalIns(@id char(10),@year char(4),
			  @salary decimal(7,2))
as

insert Tsal_sal
values (@id,@year,@salary)


GO

/****** Object:  Stored Procedure dbo.spSalSalSch    Script Date: 27/5/41 15:48:27 ******/
create procedure spSalSalSch(@id char(10),@year char(4))
as

select salary
from TSal_Sal
where id = @id and year = @year
GO

/****** Object:  Stored Procedure dbo.spSrchTname    Script Date: 27/5/41 15:48:27 ******/
create procedure spSrchTname (@id char(10))
as 
begin tran
	select pname,fname,lname 
	from TSal_Teach
	where id = @id
if @@error <> 0 Rollback Tran
commit tran

GO

/****** Object:  Stored Procedure dbo.sptest    Script Date: 27/5/41 15:48:27 ******/
create procedure sptest(@date datetime,
			@out int output)
as
begin tran
	select *
	from TOT_Period 
	where time >= @date

	select @out = @@rowcount
if @@ERROR <> 0 ROLLBACK TRAN
COMMIT TRAN
return @@rowcount
GO

/****** Object:  Stored Procedure dbo.sptestInsert    Script Date: 27/5/41 15:48:27 ******/
create procedure sptestInsert
(@date datetime)
as
begin
begin tran
	insert aatest
	values (@date,default,default)
if @@error <> 0 
 begin
	rollback tran
	return 1
	
 end
else
	return 2
commit tran
end
GO

/****** Object:  Stored Procedure dbo.spTR_S1Sch    Script Date: 27/5/41 15:48:27 ******/
create procedure spTR_S1Sch(@id char(10))
as
select f_name,Name,L_name,room
from Tr_s1
where s_id = @id

GO

/****** Object:  Stored Procedure dbo.spTR_T1Sch    Script Date: 27/5/41 15:48:27 ******/
create procedure spTR_T1Sch(@id char(10))
as
select f_name,Name,L_name
from Tr_t1
where t_id = @id

GO

/****** Object:  Stored Procedure dbo.Spus_com1_change    Script Date: 27/5/41 15:48:27 ******/
CREATE PROCEDURE   Spus_com1_change
         @com_no_1     char(4),    
         @com_no       char(4),
	 @name         char(50),
         @address      char(100),
         @person1      char(50),
         @person2      char(50),      
         @note         char(40)
AS
BEGIN TRAN
insert 
into Tpus_com1
values  (@com_no,@name,@address,@person1,@person2,@note)
update Tpus_order1
  set    com_no  = @com_no
  where  com_no = @com_no_1
update Tpus_com2
  set    com_no  = @com_no
  where  com_no  = @com_no_1
delete Tpus_com1
where  com_no = @com_no_1
COMMIT
GO

/****** Object:  Stored Procedure dbo.Spus_delete_order1    Script Date: 27/5/41 15:48:27 ******/
CREATE PROCEDURE Spus_delete_order1
          @no      char(8)
AS
Begin  Tran
delete 
from Tpus_order2
where  no = @no
delete
from Tpus_order1
where no = @no
commit
GO

/****** Object:  Stored Procedure dbo.Spus_delte_com1    Script Date: 27/5/41 15:48:27 ******/
CREATE PROCEDURE Spus_delte_com1
    @com_no char(4)
As
Begin Tran
delete
from Tpus_com2
where com_no = @com_no
delete
from Tpus_com1
where com_no = @com_no
commit

GO

/****** Object:  Stored Procedure dbo.Spus_order1_change    Script Date: 27/5/41 15:48:27 ******/
CREATE PROCEDURE   Spus_order1_change
         @no1      char(8),
         @no       char(8),
	 @id1      char(10 ),
 	 @id2      char(10),
         @com_no   char(4),
         @date1    datetime,
         @date2    datetime,
         @brance   char(2),
         @note     char(40)
AS
BEGIN TRAN
insert 
into Tpus_order1
values  (@no,@id1,@id2,@com_no,@date1,@date2,@brance,@note)
update Tpus_order2
  set  no  = @no
  where  no = @no1
delete Tpus_order1
where  no = @no1
COMMIT
GO

/****** Object:  Stored Procedure dbo.Spus_order2_change1    Script Date: 27/5/41 15:48:27 ******/
CREATE PROCEDURE   Spus_order2_change1
         @no      char(8),
         @no1_1   char(3),
         @no1     char(3),
	 @order1  char(30),
 	 @spec    char(30),
         @price   decimal(9,2),
         @number  decimal(7,2),
         @note    char(40)
AS
BEGIN TRAN
update Tpus_order2
set     no      = @no,
        no1     = @no1,
        order1  = @order1,
        spec    = @spec,
        price   = @price,
        number  = @number,
        note    = @note
where    (no = @no )
         and (no1 = @no1_1)
         
COMMIT
GO

/****** Object:  Stored Procedure dbo.Spus_order2_change2    Script Date: 27/5/41 15:48:27 ******/
CREATE PROCEDURE   Spus_order2_change2
         @no      char(8),
         @no_1    char(8),
         @no1_1   char(3),
         @no1     char(3),
	 @order1  char(30),
 	 @spec    char(30),
         @price   decimal(9,2),
         @number  decimal(7,2),
         @note    char(40)
AS
BEGIN TRAN
update Tpus_order2
set     no      = @no,
        no1     = @no1,
        order1  = @order1,
        spec    = @spec,
        price   = @price,
        number  = @number,
        note    = @note
where    (no = @no_1 )
         and (no1 = @no1_1)
         
COMMIT
GO

/****** Object:  Stored Procedure dbo.Spus_pus1_change    Script Date: 27/5/41 15:48:27 ******/
CREATE PROCEDURE   Spus_pus1_change
         @pus_no1    char(10),
         @pus_no     char(10),
	 @pus_order  char(30 ),
 	 @spec       char(30),
         @brance     char(2),
         @place      char(20),
         @note       char(40),
	 @status     char(6)
AS
BEGIN TRAN
insert 
into Tpus_pus1
values  (@pus_no,@pus_order,@spec,@brance,@place,@note,@status)
delete Tpus_pus1
where  pus_no = @pus_no1
COMMIT
GO

