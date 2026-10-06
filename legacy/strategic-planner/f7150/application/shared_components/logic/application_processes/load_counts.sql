prompt --application/shared_components/logic/application_processes/load_counts
begin
--   Manifest
--     APPLICATION PROCESS: Load Counts
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_flow_process(
 p_id=>wwv_flow_imp.id(48056301114520380238)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Counts'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_ok_to_re_count boolean := false;',
'    l_last_refresh   date;',
'begin',
'    if :LAST_COUNT_REFRESH is null then',
'        l_ok_to_re_count := true;',
'    else',
'        l_last_refresh := to_date(:LAST_COUNT_REFRESH,''YYYY.MM.DD-HH24:MI:SS'');',
'        if l_last_refresh < (sysdate - (1/96)) then',
'            l_ok_to_re_count := true; -- refresh if 15 minutes stale',
'        end if;',
'    end if;',
'    if l_ok_to_re_count then',
'        for c1 in (select count(*) c from sp_areas) loop',
'            :P1_AREAS := to_char(c1.c,''FM999G999G990''); ',
'        end loop;',
'        ',
'        for c1 in (select count(*) c from sp_project_groups) loop',
'            :P1_PROJECT_GROUPS := to_char(c1.c,''FM999G999G990''); ',
'        end loop;',
'        ',
'        for c1 in (select count(*) c from sp_initiatives)  loop',
'            :P1_INITIATIVES := to_char(c1.c,''FM999G999G990''); ',
'        end loop;',
'        ',
'        for c1 in (select count(*)  c',
'                     from sp_projects p',
'                    where p.ARCHIVED_YN = ''N'' and ',
'                          p.DUPLICATE_OF_PROJECT_ID is null',
'        ) loop',
'            :P1_PROJECTS := to_char(c1.c,''FM999G999G990''); ',
'        end loop;',
'        ',
'        for c1 in (select count(*) c ',
'                     from sp_activities ap, sp_projects p',
'                    where ap.project_id = p.id(+) and',
'                          p.DUPLICATE_OF_PROJECT_ID is null and',
'                          (p.ARCHIVED_YN = ''N'' or p.archived_yn is null) -- need the is null to         accomodate the outer join',
'        ) loop',
'            :P1_ACTIVITIES := to_char(c1.c,''FM999G999G990''); ',
'        end loop;',
'        ',
'        for c1 in (select count(*) c from SP_RELEASE_TRAINS) loop',
'            :P1_RELEASES := to_char(c1.c,''FM999G999G990''); ',
'        end loop;',
'        ',
'        for c1 in (select count(*) c from SP_TEAM_MEMBERS) loop',
'            :P1_PEOPLE := to_char(c1.c,''FM999G999G990''); ',
'        end loop;',
'        ',
'        for c1 in (select count(*) c from SP_GROUPS) loop',
'            :P1_GROUPS := to_char(c1.c,''FM999G999G990''); ',
'        end loop;',
'        ',
'        :LAST_COUNT_REFRESH := to_char(sysdate,''YYYY.MM.DD-HH24:MI:SS'');',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'1,3,502'
,p_process_when_type=>'CURRENT_PAGE_IN_CONDITION'
,p_version_scn=>44506467705324
);
wwv_flow_imp.component_end;
end;
/
