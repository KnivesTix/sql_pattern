/*
-- ��������� ��������, ���� � �������� �� ������� ���� 
select * from dev.pt_v_for_medstat  WHERE ID_EMIAS = 19132456;
select * from  dev.pt_v_for_medstat_close_att a WHERE ID_EMIAS = 19132456 AND SDT_ID =10003483;
select l.*, rowid FROM MSKMEDSTAT.OP_PERSON_LPU l WHERE IDPERSON =249911588623 AND idlpu = 2161;
select o.*, rowid from op_loadlog o
where id_loadlog_type = 21
order by uploaded desc;
*/
-- ���� ������������� ��������� �� - ���
update op_loadlog a
set id_loadlog_status = 3
where id_loadlog in (select max(id_loadlog) from op_loadlog  where id_loadlog_type = 21 and id_loadlog_status = 1);
-------jdfgkdfgkjdnfkgjndfgndfdfkdfmdo
update MSKMEDSTAT.OP_PERSON_LPU
set archive = 0
, dateout = null
, IDREASONOUT  = null
WHERE IDPERSON =249911588623 AND idlpu = 2161;

update dev.pt_v_for_medstat_close_att
set attach_last_date = to_date('04.10.2021 06:00:00', 'dd.mm.yyyy hh24:mi:ss'),
attach_closed_date =to_date('04.10.2021', 'dd.mm.yyyy')
WHERE ID_EMIAS = 19132456 AND SDT_ID =10003483;

update dev.pt_v_for_medstat 
set last_date = to_date('04.10.2021', 'dd.mm.yyyy hh24:mi:ss')
WHERE ID_EMIAS = 19132456;
commit;
/* � �������� ����
begin
  -- Call the procedure
  P_INTGRTN_ERP;
end;
*/
-- � ������ �� ����������
-- ���� ������������� ��������� �� - ��
update op_loadlog a
set id_loadlog_status = 2
where id_loadlog in (select max(id_loadlog) from op_loadlog  where id_loadlog_type = 21 and id_loadlog_status = 1);

update MSKMEDSTAT.OP_PERSON_LPU
set archive = 0
, dateout = null
, IDREASONOUT  = null
WHERE IDPERSON =249911588623 AND idlpu = 2161;

update dev.pt_v_for_medstat_close_att
set attach_last_date = to_date('04.10.2021 06:00:00', 'dd.mm.yyyy hh24:mi:ss'),
attach_closed_date =to_date('04.10.2021', 'dd.mm.yyyy')
WHERE ID_EMIAS = 19132456 AND SDT_ID =10003483;

update dev.pt_v_for_medstat 
set last_date = to_date('04.10.2021', 'dd.mm.yyyy hh24:mi:ss')
WHERE ID_EMIAS = 19132456;
commit;
/* � �������� ����
begin
  -- Call the procedure
  P_INTGRTN_ERP;
end;
*/
-- ���������, iddisp = 3
