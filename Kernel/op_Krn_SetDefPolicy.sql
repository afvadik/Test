create or replace
PROCEDURE op_Krn_SetDefPolicy
AS
/*StartComment
 Назначение: Устанавливает значения по умолчанию для административных политик
 Параметры: нет
 Возвращает: Ничего
 Exception:   Нет.
 Пример вызова: exec op_Krn_SetDefPolicy
EndComment*/
  tid integer;
  rowCount integer;
begin
  select count(1) into rowCount from krn_securitysettings s where name='AccountLockMin';
  if nvl(rowCount,0) != 1 then
    insert into krn_securitysettings (name,value,caption,note)
       VALUES ('AccountLockMin', '-1', 'Время блокировки учетной записи (минут)', '');
  else
    select s.tid into tid from krn_securitysettings s where name='AccountLockMin';
    UPDATE Krn_SecuritySettings s
       set value = '-1', caption = 'Время блокировки учетной записи (минут)', note = ''
     where s.tid=tid;
  end if;
 
  select count(1) into rowcount from krn_securitysettings s where name='AttemptCount';
  if nvl(rowCount,0) != 1 then
    insert into krn_securitysettings(name,value,caption,note)
       VALUES('AttemptCount', '-1', 'Количество попыток входа до блокировки', '');
  else
    select s.tid into tid from krn_securitysettings s where name='AttemptCount';
    UPDATE Krn_SecuritySettings s
       SET Value = '-1', Caption = 'Количество попыток входа до блокировки', Note = ''
     where s.tid=tid;
  end if;
     
  select count(1) into rowCount from krn_securitysettings s where name='ContentCheck';
  if nvl(rowcount,0) != 1 then
    insert into krn_securitysettings(name,value,caption,note)
       VALUES('ContentCheck', '0', 'Проверять пароль на обязательное наличие цифр/символов?', '');
  else
    select s.tid into tid from krn_securitysettings s where name='ContentCheck';
    UPDATE Krn_SecuritySettings s
       set value = '0', caption = 'Проверять пароль на обязательное наличие цифр/символов?', note = ''
     where s.tid = tid;
  end if;
     
  select count(1) into rowcount from krn_securitysettings s where name='ExpirationDays';
  if nvl(rowCount,0) != 1 then
    insert into krn_securitysettings(name,value,caption,note)
       VALUES('ExpirationDays', '-1', 'Время действия пароля (дни)', '');
  else
    select s.tid into tid from krn_securitysettings s where name='ExpirationDays';
    UPDATE Krn_SecuritySettings s
       SET Value = '-1', Caption = 'Время действия пароля (дни)', Note = ''
     where s.tid = tid;
  end if;
  
  select count(1) into rowcount from krn_securitysettings s where name='PassLenght';
  if nvl(rowCount,0) != 1 then
    insert into krn_securitysettings(name,value,caption,note)
       VALUES('PassLenght', '-1', 'Длина пароля', '');
  else
    select s.tid into tid from krn_securitysettings s where name='PassLenght';
    UPDATE Krn_SecuritySettings s
       SET Value = '-1', Caption = 'Длина пароля', Note = ''
     where s.tid = tid;
  end if;
end op_Krn_SetDefPolicy;