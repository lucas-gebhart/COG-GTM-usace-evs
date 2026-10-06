-- APEX supporting object install script: sp_app_nomenclature table
-- sequence 90, source application/deployment/install/install_sp_app_nomenclature_table.sql
-- kind: ddl

create table SP_APP_NOMENCLATURE (
    id                             number default on null to_number(sys_guid(), 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX') 
                                   constraint SP_APP_NOMENCLATURE_pk primary key,
    static_id                      varchar2(50 char),
    default_order                  number,
    custom_value                   varchar2(50 char),
    default_value                  varchar2(50 char),
    --
    description                    varchar2(4000 char),
    --
    created                        date not null,
    created_by                     varchar2(255 char) not null,
    updated                        date not null,
    updated_by                     varchar2(255 char) not null
)
;

create unique index SP_APP_NOMENCLATURE_u1 on SP_APP_NOMENCLATURE (static_id);
