create or replace procedure OP_KRN_USERRIGHTS(
 UserTID Number, p_cur out SYS_REFCURSOR
)

AS
/*StartComment
 Назначение: 
  Возвращает эффективные разрешения пользователя для БО и методов.
 Параметры:
  @UserTID Krn_Users.TID
 Возвращает: 
  Данные в табличном виде.
 Пример вызова: 
	 exec op_Krn_UserRights @UserTID=0
EndComment*/

begin
  open p_cur for
  select u.*
    from 
    (select -- пользовательские разрешения
      si.TID, si.Code, si.CodeString, st.TypeName, st.TableName 
      from
      Krn_SecurityUsers su
      inner join Krn_SecurityInstance si on (si.TID=su.Krn_SecurityInstance)
      inner join Krn_SecurityType st on st.TID=si.Krn_SecurityType
      where 
      su.Krn_Users=usertid and su.Permissions=4 and (st.TableName='Krn_Methods' or TableName='Krn_BusinessObjects')
      union -- разрешения групп
 	    select 
 	      si.TID, si.Code, si.CodeString, st.TypeName, st.TableName
 	    from
 	      Krn_SecurityRoles sr
 	      inner join Krn_SecurityInstance si on (si.TID=sr.Krn_SecurityInstance)
 	      inner join Krn_SecurityType st on st.TID=si.Krn_SecurityType
 	    where 
 	      Krn_Roles in (select Krn_Roles from Krn_Users_Krn_Roles where Krn_Users=usertid) 
 	      and sr.Permissions=4 and (st.TableName='Krn_Methods' or TableName='Krn_BusinessObjects') ) u
 	  left outer join -- явно запрещено пользователю 
      (select distinct si.TID TID
        from
        Krn_SecurityUsers su
        inner join Krn_SecurityInstance si on (si.TID=su.Krn_SecurityInstance)
        inner join Krn_SecurityType st on st.TID=si.Krn_SecurityType
        where 
        su.Krn_Users=usertid and su.Permissions=0 and (st.TableName='Krn_Methods' or TableName='Krn_BusinessObjects')
      ) r on u.TID = r.TID
    where 
    r.TID is null;
end OP_KRN_USERRIGHTS;