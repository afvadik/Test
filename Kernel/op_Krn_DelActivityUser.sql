create or replace
procedure op_krn_delactivityuser
IS
/*StartComment
 ����������: ������� ����������� ������������ � �������
 ���������: ���
 ����������: ������
 Exception:   ���.
 ������ ������: Krn_ActivityUsers
EndComment*/
  cur_sid integer;
begin
  --cur_sid := userenv('sessionid');
  select sys_context('userenv','sessionid') into cur_sid from dual;
  --select i into cur_sid from aaa;
  delete from krn_activityusers where spid = cur_sid;
end;