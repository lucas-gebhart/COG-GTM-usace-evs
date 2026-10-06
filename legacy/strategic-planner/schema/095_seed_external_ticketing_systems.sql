-- APEX supporting object install script: seed external_ticketing_systems
-- sequence 790, source application/deployment/install/install_seed_external_ticketing_systems.sql
-- kind: dml

insert into SP_EXTERNAL_TICKETING_SYSTEMS 
    ( ID, EVAULATION_SEQUENCE, EXTERNAL_SYSTEM_NAME, IS_ACTIVE_YN, LINK_PATTERN, description, TICKET_ID_REGEX) 
    values 
    (1, 10, 'Jira', 'Y', 'https://jira.myorg.com/jira/browse/#TICKET#', 'Our Jira', '[Jj][Ii][Rr][Aa][-: ]\d{3,5}');
