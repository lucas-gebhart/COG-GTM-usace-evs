prompt --application/pages/page_00031
begin
--   Manifest
--     PAGE: 00031
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_page.create_page(
 p_id=>31
,p_name=>'Links from Comments'
,p_alias=>'LINKS-FROM-COMMENTS'
,p_page_mode=>'MODAL'
,p_step_title=>'Links from Comments'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1661186590416509825
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42497664376259646711)
,p_plug_name=>'Button Bar'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2126429139436695430
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(42497664691050646714)
,p_plug_name=>'links'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>3371237801798025892
,p_plug_display_sequence=>20
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    x                 clob            := null;',
'    r                 clob            := null;',
'    l_comment_count   int             := 0;',
'    l_link            varchar2(32767) := null;',
'    l_link_exists     boolean         := false;',
'    l_link_count      int             := 0;',
'    l_existing_links  int             := 0;',
'begin',
'    --',
'    -- count existing links',
'    --',
'    for c1 in (select count(*) c from sp_project_links where project_id = :P31_ID ) loop',
'        l_existing_links := c1.c;',
'    end loop;',
'    r := ''<p>This ''||:NOMENCLATURE_PROJECT||'' has ''||l_existing_links||'' links defined.</p>'';',
'    --',
'    -- search comments for links',
'    --',
'    for c1 in (',
'        select body, ',
'               id, ',
'               created, ',
'               project_id',
'        from SP_PROJECT_COMMENTS c ',
'        where c.PROJECT_ID = :P31_ID and ',
'              c.PRIVATE_YN = ''N''',
'        order by created desc) loop',
'       x := c1.body;',
'       for i in 1..30 loop',
'           l_link := REGEXP_SUBSTR ( x, ''http[s]?://[a-zA-Z0-9./?=_-]+'',1,i);',
'           if l_link is null then ',
'               exit;',
'           end if;',
'           --',
'           -- check for existing link',
'           --',
'           l_link_exists := false;',
'           for c2 in (',
'               select 1 x ',
'               from SP_PROJECT_LINKS l ',
'               where l.project_id = c1.project_id and ',
'                     lower(l.LINK_URL) = lower(l_link)) loop',
'               l_link_exists := true;',
'               exit;',
'           end loop;',
'           --',
'           -- display new links',
'           --',
'           if not l_link_exists then',
'                if dbms_lob.instr(r,l_link) = 0 then',
'                    l_link_count := l_link_count + 1;',
'                    if l_link_count = 1 then ',
'                        r := r||chr(10)||''<p>The following new links have been found:</p>''||chr(10)||''<ul>'';',
'                    end if;',
'                    r := r||chr(10)||''<li>''||l_link||''</li>'';',
'                end if;',
'           end if;',
'       end loop;',
'       l_comment_count := l_comment_count + 1;',
'       if l_comment_count >= 100 then ',
'           exit;',
'       end if;',
'    end loop;',
'    if l_link_count = 0 then ',
'        r := r||chr(10)||''No new links found searching ''||trim(to_char(l_comment_count,''999G999G990''))||'' comments'';',
'    else',
'       r := r||chr(10)||''</ul>'';',
'    end if;',
'    return r;',
'end;',
''))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P31_ID'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(42497664525085646712)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(42497664376259646711)
,p_button_name=>'Cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(42497664594737646713)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(42497664376259646711)
,p_button_name=>'add_links'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4072362960822175091
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Links'
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(42497664853212646715)
,p_branch_action=>'f?p=&APP_ID.:31:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(42497664099307646708)
,p_name=>'P31_ID'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_restricted_characters=>'US_ONLY'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(42497664890081646716)
,p_name=>'close on click'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(42497664525085646712)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(42497665020405646717)
,p_event_id=>wwv_flow_imp.id(42497664890081646716)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(42497664356927646710)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Add links'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    x               clob            := null;',
'    l_comment_count int             := 0;',
'    l_link          varchar2(32767) := null;',
'    l_link_exists   boolean         := false;',
'begin',
'    for c1 in (',
'       select body, ',
'              id, ',
'              created, ',
'              project_id',
'       from SP_PROJECT_COMMENTS c ',
'       where c.PROJECT_ID = :P31_ID and ',
'             c.PRIVATE_YN = ''N''',
'       order by created desc) loop',
'       -- ',
'       x := c1.body;',
'       for i in 1..30 loop',
'           l_link := REGEXP_SUBSTR ( x, ''http[s]?://[a-zA-Z0-9./?=_-]+'',1,i);',
'           if l_link is null then ',
'               exit;',
'           end if;',
'           --',
'           -- determine if link exists',
'           --',
'           l_link_exists := false;',
'           for c2 in (',
'               select 1 x ',
'               from SP_PROJECT_LINKS l',
'               where l.project_id = c1.project_id and',
'                     lower(l.LINK_URL) = lower(l_link)',
'               ) loop',
'               l_link_exists := true;',
'               exit;',
'           end loop;',
'           --',
'           if not l_link_exists then',
'                insert into SP_PROJECT_LINKS (',
'                    LINK_URL, LINK_NAME, project_id) ',
'                values (',
'                    l_link, ''Added from ''||to_char(c1.created,''DD-MON-YYYY'')||'' comment.'', c1.project_id);',
'           end if;',
'',
'       end loop;',
'       l_comment_count := l_comment_count + 1;',
'       if l_comment_count >= 100 then ',
'           exit;',
'       end if;',
'    end loop;',
'end;',
''))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error: #SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(42497664594737646713)
,p_process_success_message=>'Links Added'
,p_internal_uid=>5598306491525678941
);
wwv_flow_imp.component_end;
end;
/
