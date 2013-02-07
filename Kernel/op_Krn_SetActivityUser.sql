create or replace
procedure op_krn_setactivityuser(
 userid int,
 username nvarchar2,--(128),
 computername varchar2,--(50),
 ip_address varchar2,--(20),
 windowsusername varchar2,--(50),
 OperDate date)
AS
/*StartComment
 ����������: ������������ ������������ � �������

 ���������:
 @UserID					 - �� ������������
 @UserName         - ��� ������������
 @ComputerName		 - ��� ����������
 @IP_Address			 - IP �����
 @WindowsUserName  - Windows ���
 @OperDate			- ���� ������� �� ������ ������������
 ����������:  ������
 Exception: ���.
 ������ ������: exec op_Krn_SetActivityUser 1,'qqq','aaa','2222222','qqq', '20080702'
EndComment*/
  cur_sid integer;
  cur_user varchar2(128);
begin
  --cur_sid := userenv('sessionid');
  select sys_context('userenv','sessionid') into cur_sid from dual;
  
  if username is null then
    select sys_context('userenv','session_user') into cur_user from dual;
  end if;
  
 -- �������� ������ ������ 
-- delete from db
-- from DocumentBusy db
-- where db.SessionID=@@SPID
 
  delete from Krn_ActivityUsers where Spid = cur_sid;
 -- ������ ������ 
 insert into Krn_ActivityUsers(Spid, Krn_Users, ComputerName, IP_Address, WindowsUserName,
                               username, operdate)
   values(cur_sid, userid, computername, ip_address, windowsusername,
        cur_user, current_date);
 
end op_krn_setactivityuser;
