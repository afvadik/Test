create or replace procedure OP_KRN_USERRIGHTSINSTANCES(UserTID Number, p_cur out SYS_REFCURSOR)

as
 /*StartComment
  Назначение: Возвращает эффективные разрешения пользователя для экземпляров.
  Права пользователя суммируются с групповыми.
  Параметры:
    @UserTID Krn_Users.TID
  Возвращает: Данные в табличном виде.
  Пример вызова: 
	select * from op_Krn_UserRightsInstances(1)
 EndComment*/

begin
  open p_cur for
   select 
    si.TID, 
    si.Code, 
    si.CodeString, 
    st.TypeName, 
    st.TableName, 
    su.Permissions, 
    su.Krn_Users as UserTID, 
    cast(null as int)
	 from
	   Krn_SecurityUsers su
	   inner join Krn_SecurityInstance si on (si.TID=su.Krn_SecurityInstance)
	   inner join Krn_SecurityType st on st.TID=si.Krn_SecurityType
	   where su.Krn_Users=UserTID 
	     and st.TableName<>'Krn_Methods' 
	     and TableName<>'Krn_BusinessObjects'
	 union
	  select 
	     si.TID, 
	     si.Code, 
	     si.CodeString, 
	     st.TypeName, 
	     st.TableName, 
	     sr.Permissions, 
	     cast(null as int), 
	     sr.Krn_Roles as RoleTID
	  from
	   Krn_SecurityRoles sr
	   inner join Krn_SecurityInstance si on (si.TID=sr.Krn_SecurityInstance)
	   inner join Krn_SecurityType st on st.TID=si.Krn_SecurityType
	   where Krn_Roles in (select Krn_Roles from Krn_Users_Krn_Roles where Krn_Users=UserTID) 
	   and st.TableName<>'Krn_Methods' 
	   and TableName<>'Krn_BusinessObjects';

end OP_KRN_USERRIGHTSINSTANCES;