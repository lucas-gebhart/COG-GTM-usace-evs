prompt --application/shared_components/user_interface/theme_style
begin
--   Manifest
--     THEME STYLE: 7150
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_theme_style(
 p_id=>wwv_flow_imp.id(41164245191273688151)
,p_theme_id=>42
,p_name=>'Redwood Light SP'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APEX_FILES#libraries/oracle-fonts/oraclesans-apex#MIN#.css?v=#APEX_VERSION#',
'#THEME_FILES#css/Redwood#MIN#.css?v=#APEX_VERSION#'))
,p_css_classes=>' rw-mode-body-header--dark rw-mode-header--dark rw-pillar--neutral'
,p_is_public=>true
,p_is_accessible=>false
,p_theme_roller_input_file_urls=>'#THEME_FILES#less/theme/Redwood-Theme.less'
,p_theme_roller_config=>'{"classes":["rw-mode-body-header--dark","rw-mode-header--dark","rw-pillar--neutral"],"vars":{},"customCSS":":root {\n  /* Reduce Redwood Padding */\n  --ut-footer-padding-x: var(--ut-body-content-padding-x);\n  --ut-body-content-padding-y: 2rem;\n  /'
||'* Unset badge font family */\n  --ut-treeview-badge-font-family: unset;\n  /* Better grid borders when backgrounds set on rows */\n  --a-gv-cell-border-color: rgba(0, 0, 0, .05);\n}\n\n.header-actions {\n  margin-inline-start: auto;\n}\n\n.header-act'
||'ions .t-ContentRow-wrap {\n  padding: 0;\n  float: right;\n}\n\n.has-header-actions {\n  display: inline-flex;\n}\n\n.header-actions .t-ContentRow-wrap button {\n  --a-button-background-color: transparent;\n}\n\n.t-BreadcrumbRegion--showBreadcrumb .t'
||'-BreadcrumbRegion-breadcrumb {\n  display: flex;\n  align-items: center;\n}\n\n\n/* Clear the default fa-user icon for content row regions with the clear-avatar-icons class */\n.clear-avatar-icons .t-Avatar.t-Avatar--icon.fa-user:before {\n  display:'
||' none;\n}\n\n/* Adding initiative icon to the left of contextual info region */\n.initiative-icon {\n  margin: 0 -2rem .5rem 3rem;\n  max-inline-size: 2.5rem;\n}\n\n.t-PageBody--showLeft .initiative-icon {\n  margin: 0 0 .5rem 1rem;\n  max-inline-siz'
||'e: 2.5rem;\n}\n\n/* Setting max height for facets, otherwise it gets too big */\n.a-FS-bodyInner .apex-item-checkbox {\n  max-height: 320px;\n  overflow: auto;\n}\n\n/* Search Clear Button */\n.sp-ClearButton {\n  position: absolute;\n  inline-size: '
||'1.5rem;\n  block-size: 1.5rem;\n  cursor: pointer;\n  inset-inline-end: .25rem;\n  inset-block-start: 50%;\n  transform: translateY(-50%);\n  visibility: visible;\n  opacity: 1;\n  transition: opacity .25s ease;\n  display: flex;\n  align-items: cent'
||'er;\n  justify-content: center;\n  order: 4;\n}\n\n.sp-ClearButton:before {\n  content: \"\\e0a2\";\n  font-size: 1rem;\n  speak: none;\n  font-style: normal;\n  font-weight: 400;\n  font-variant: normal;\n  text-transform: none;\n  text-rendering: a'
||'uto;\n  line-height: 1;\n  -webkit-font-smoothing: antialiased;\n  -moz-osx-font-smoothing: grayscale;\n  font-family: var(--a-icon-font-family, \"apex-5-icon-font\");\n  opacity: .8;\n}\n\n.t-Form-itemWrapper {\n  position: relative;\n}\n\n.t-Form-f'
||'ieldContainer:not(.t-Form-fieldContainer--floatingLabel):not(.t-Form-fieldContainer--hiddenLabel) .t-Form-itemWrapper {\n  display: inline-flex;\n}\n\n.t-Form-itemWrapper:has(:placeholder-shown) .sp-ClearButton {\n  visibility: hidden;\n  opacity: 0;'
||'\n}\n\n.t-Comments-comment img {max-width: 100%; height: auto;}","useCustomLess":"N"}'
,p_theme_roller_output_file_url=>'#THEME_DB_FILES#41162705609405630023.css'
,p_theme_roller_read_only=>false
);
wwv_flow_imp.component_end;
end;
/
