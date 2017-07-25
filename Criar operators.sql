USE [msdb]
GO



/****** Object:  Operator [softdev]    Script Date: 28/11/2016 10:19:29 ******/
IF (EXISTS(SELECT TOP 1 1 FROM msdb.dbo.sysoperators where [name] = 'softdev'))
BEGIN
EXEC msdb.dbo.sp_delete_operator @name=N'softdev'
END
GO
/****** Object:  Operator [softdev]    Script Date: 28/11/2016 10:19:29 ******/
EXEC msdb.dbo.sp_add_operator @name=N'softdev', 
		@enabled=1, 
		@weekday_pager_start_time=90000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=90000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=90000, 
		@sunday_pager_end_time=180000, 
		@pager_days=62, 
		@email_address=N'softdev@multicomnet.com.br', 
		@category_name=N'[Uncategorized]'
GO


/****** Object:  Operator [Customer_Softdev]    Script Date: 28/11/2016 10:19:10 ******/
IF (EXISTS(SELECT TOP 1 1 FROM msdb.dbo.sysoperators where [name] = 'Customer_Softdev'))
BEGIN
EXEC msdb.dbo.sp_delete_operator @name=N'Customer_Softdev'
END
GO
/****** Object:  Operator [Customer_Softdev]    Script Date: 28/11/2016 10:19:10 ******/
EXEC msdb.dbo.sp_add_operator @name=N'Customer_Softdev', 
		@enabled=1, 
		@weekday_pager_start_time=80000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=80000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=80000, 
		@sunday_pager_end_time=180000, 
		@pager_days=0, 
		@email_address=N'customer@embrateledi.com.br;softdev@multicomnet.com.br', 
		@category_name=N'[Uncategorized]'
GO


/****** Object:  Operator [Customer_Softdev_Guilherme]    Script Date: 28/11/2016 10:19:20 ******/
IF (EXISTS(SELECT TOP 1 1 FROM msdb.dbo.sysoperators where [name] = 'Customer_Softdev_Guilherme'))
BEGIN
EXEC msdb.dbo.sp_delete_operator @name=N'Customer_Softdev_Guilherme'
END
GO
/****** Object:  Operator [Customer_Softdev_Guilherme]    Script Date: 28/11/2016 10:19:20 ******/
EXEC msdb.dbo.sp_add_operator @name=N'Customer_Softdev_Guilherme', 
		@enabled=1, 
		@weekday_pager_start_time=90000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=90000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=90000, 
		@sunday_pager_end_time=180000, 
		@pager_days=0, 
		@email_address=N'customer@embrateledi.com.br;softdev@multicomnet.com.br;guilherme@multicomnet.com.br', 
		@category_name=N'[Uncategorized]'
GO


IF (EXISTS(SELECT TOP 1 1 FROM msdb.dbo.sysoperators where [name] = 'danielm'))
BEGIN
EXEC msdb.dbo.sp_delete_operator @name=N'danielm'
END
GO
/****** Object:  Operator [danielm]    Script Date: 28/11/2016 10:19:24 ******/
EXEC msdb.dbo.sp_add_operator @name=N'danielm', 
		@enabled=1, 
		@weekday_pager_start_time=90000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=90000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=90000, 
		@sunday_pager_end_time=180000, 
		@pager_days=0, 
		@email_address=N'danielm@multicomnet.com.br', 
		@category_name=N'[Uncategorized]'
GO



