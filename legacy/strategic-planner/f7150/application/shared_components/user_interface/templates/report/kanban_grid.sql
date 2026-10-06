prompt --application/shared_components/user_interface/templates/report/kanban_grid
begin
--   Manifest
--     ROW TEMPLATE: KANBAN_GRID
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_row_template(
 p_id=>wwv_flow_imp.id(46433465674625149314)
,p_row_template_name=>'Kanban Board'
,p_internal_name=>'KANBAN_GRID'
,p_row_template1=>wwv_flow_string.join(wwv_flow_t_varchar2(
'</div>',
'<h3 class="kb-Group"><span class="kb-Group-label">#FOCUS_AREA#</span></h3>',
'<div class="kb-Row" id="#FOCUS_AREA_ID#">',
'  <div class="#SORTABLE# kb-Cell" ID="#ROWNUM#" data-id="#COLUMN_ID#">',
'    <div id="#ID#" class="kb-Card #P_STYLE# #DISPLAY#" onclick="#LINK#">',
'      <h4 class="kb-Card-title" title="#PROJECT#">#PROJECT#</h4>',
'      <div class="kb-Card-attributes">#ATTRS#</div>',
'    </div>'))
,p_row_template_condition1=>'#ROWNUM# = 1'
,p_row_template2=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  </div>',
'</div>',
'<h3 class="kb-Group"><span class="kb-Group-label">#FOCUS_AREA#</span></h3>',
'<div class="kb-Row" id="#FOCUS_AREA_ID#">',
'  <div class="#SORTABLE# kb-Cell" ID="#ROWNUM#" data-id="#COLUMN_ID#">',
'    <div id="#ID#" class="kb-Card #P_STYLE# #DISPLAY#" onclick="#LINK#">',
'      <h4 class="kb-Card-title" title="#PROJECT#">#PROJECT#</h4>',
'      <div class="kb-Card-attributes">#ATTRS#</div>',
'    </div>'))
,p_row_template_condition2=>'#ROW_SPLIT# = 1'
,p_row_template3=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  </div>',
'  <div class="#SORTABLE# kb-Cell" ID="#ROWNUM#" data-id="#COLUMN_ID#">',
'    <div id="#ID#" class="kb-Card #P_STYLE# #DISPLAY#" onclick="#LINK#">',
'      <h4 class="kb-Card-title" title="#PROJECT#">#PROJECT#</h4>',
'      <div class="kb-Card-attributes">#ATTRS#</div>',
'    </div>'))
,p_row_template_condition3=>'#COLUMN_SPLIT# = 1'
,p_row_template4=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    <div id="#ID#" class="kb-Card #P_STYLE# #DISPLAY#" onclick="#LINK#">',
'      <h4 class="kb-Card-title" title="#PROJECT#">#PROJECT#</h4>',
'      <div class="kb-Card-attributes">#ATTRS#</div>',
'    </div>'))
,p_row_template_before_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div class="kb-Layout">',
'  <div class="kb-RowHeader">',
''))
,p_row_template_after_rows=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    </div>',
'  </div>',
'</div>'))
,p_row_template_type=>'NAMED_COLUMNS'
,p_column_heading_template=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  <div class="kb-Column">#COLUMN_HEADER#</div>',
''))
,p_row_template_display_cond1=>'NOT_CONDITIONAL'
,p_row_template_display_cond2=>'NOT_CONDITIONAL'
,p_row_template_display_cond3=>'NOT_CONDITIONAL'
,p_row_template_display_cond4=>'NOT_CONDITIONAL'
,p_theme_id=>42
,p_theme_class_id=>7
,p_translate_this_template=>'N'
);
wwv_flow_imp.component_end;
end;
/
