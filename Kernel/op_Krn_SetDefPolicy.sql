create or replace
PROCEDURE op_Krn_SetDefPolicy
AS
/*StartComment
 ����������: ������������� �������� �� ��������� ��� ���������������� �������
 ���������: ���
 ����������: ������
 Exception:   ���.
 ������ ������: exec op_Krn_SetDefPolicy
EndComment*/
  tid integer;
  rowCount integer;
begin
  select count(1) into rowCount from krn_securitysettings s where name='AccountLockMin';
  if nvl(rowCount,0) != 1 then
    insert into krn_securitysettings (name,value,caption,note)
       VALUES ('AccountLockMin', '-1', '����� ���������� ������� ������ (�����)', '');
  else
    select s.tid into tid from krn_securitysettings s where name='AccountLockMin';
    UPDATE Krn_SecuritySettings s
       set value = '-1', caption = '����� ���������� ������� ������ (�����)', note = ''
     where s.tid=tid;
  end if;
 
  select count(1) into rowcount from krn_securitysettings s where name='AttemptCount';
  if nvl(rowCount,0) != 1 then
    insert into krn_securitysettings(name,value,caption,note)
       VALUES('AttemptCount', '-1', '���������� ������� ����� �� ����������', '');
  else
    select s.tid into tid from krn_securitysettings s where name='AttemptCount';
    UPDATE Krn_SecuritySettings s
       SET Value = '-1', Caption = '���������� ������� ����� �� ����������', Note = ''
     where s.tid=tid;
  end if;
     
  select count(1) into rowCount from krn_securitysettings s where name='ContentCheck';
  if nvl(rowcount,0) != 1 then
    insert into krn_securitysettings(name,value,caption,note)
       VALUES('ContentCheck', '0', '��������� ������ �� ������������ ������� ����/��������?', '');
  else
    select s.tid into tid from krn_securitysettings s where name='ContentCheck';
    UPDATE Krn_SecuritySettings s
       set value = '0', caption = '��������� ������ �� ������������ ������� ����/��������?', note = ''
     where s.tid = tid;
  end if;
     
  select count(1) into rowcount from krn_securitysettings s where name='ExpirationDays';
  if nvl(rowCount,0) != 1 then
    insert into krn_securitysettings(name,value,caption,note)
       VALUES('ExpirationDays', '-1', '����� �������� ������ (���)', '');
  else
    select s.tid into tid from krn_securitysettings s where name='ExpirationDays';
    UPDATE Krn_SecuritySettings s
       SET Value = '-1', Caption = '����� �������� ������ (���)', Note = ''
     where s.tid = tid;
  end if;
  
  select count(1) into rowcount from krn_securitysettings s where name='PassLenght';
  if nvl(rowCount,0) != 1 then
    insert into krn_securitysettings(name,value,caption,note)
       VALUES('PassLenght', '-1', '����� ������', '');
  else
    select s.tid into tid from krn_securitysettings s where name='PassLenght';
    UPDATE Krn_SecuritySettings s
       SET Value = '-1', Caption = '����� ������', Note = ''
     where s.tid = tid;
  end if;
end op_Krn_SetDefPolicy;