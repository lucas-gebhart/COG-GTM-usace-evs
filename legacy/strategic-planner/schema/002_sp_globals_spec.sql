-- APEX supporting object install script: sp_globals spec
-- sequence 20, source application/deployment/install/install_sp_globals_spec.sql
-- kind: ddl

create or replace package sp_globals
as
    g_audit_this  boolean := TRUE;
end sp_globals;
/
