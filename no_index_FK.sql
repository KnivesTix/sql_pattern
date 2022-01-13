select a.table_name,
 a.constraint_name,
 a.column_name,
 c.index_name
 from all_cons_columns a,
 all_constraints b,
all_ind_columns c
where a.table_name = &tbl_name
and a.owner = 'HR'
 and b.constraint_type = 'R'
 and a.owner = b.owner
 and a.table_name = b.table_name
 and a.constraint_name = b.constraint_name
 and a.owner = c.table_owner (+)
 and a.table_name = c.table_name (+)
 and a.column_name = c.column_name (+)
 and c.index_name is null
