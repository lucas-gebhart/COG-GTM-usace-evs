-- APEX supporting object install script: Sequences
-- sequence 10, source application/deployment/install/install_sequences.sql
-- kind: ddl

create sequence SP_SEQ;

create sequence sp_kb_stack_rank_seq
start with 1
increment by 1
cache 20
nocycle;
