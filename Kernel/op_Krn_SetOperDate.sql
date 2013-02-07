if exists (select * from sysobjects where id = object_id(N'[dbo].[op_Krn_SetOperDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[op_Krn_SetOperDate]
GO

CREATE PROCEDURE op_Krn_SetOperDate
 @OperDate OperDate_Type
AS
/*StartComment
 Назначение: Устанавливает дату опер дня
 Параметры:
 @OperDate		 - дата опер дня
 Возвращает:  Ничего
 Exception:   Нет.
 Пример вызова: exec op_Krn_SetOperDate '20071010'
EndComment*/
  
 UPDATE Krn_ActivityUsers 
 SET OperDate = @OperDate 
 WHERE Spid = @@SPID
go
