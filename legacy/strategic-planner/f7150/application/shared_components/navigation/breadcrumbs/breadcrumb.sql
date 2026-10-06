prompt --application/shared_components/navigation/breadcrumbs/breadcrumb
begin
--   Manifest
--     MENU: Breadcrumb
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>20
,p_default_application_id=>7150
,p_default_id_offset=>1539581868058128
,p_default_owner=>'ORACLE'
);
wwv_flow_imp_shared.create_menu(
 p_id=>wwv_flow_imp.id(176221934902378897475)
,p_name=>'Breadcrumb'
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40990648370739386545)
,p_option_sequence=>1
,p_short_name=>'Team Member Default Tags'
,p_link=>'f?p=&APP_ID.:10520:&SESSION.::&DEBUG.:::'
,p_page_id=>10520
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(6532995929852956222)
,p_short_name=>'Kanban Board: &P4_INITIATIVE.'
,p_link=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(6536755810797236378)
,p_short_name=>'Planning Board: &P135_INITIATIVE.'
,p_link=>'f?p=&APP_ID.:135:&SESSION.::&DEBUG.:::'
,p_page_id=>135
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(18063943555433890174)
,p_short_name=>'Team Member Notifications'
,p_link=>'f?p=&APP_ID.:10790:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10790
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(20625156849498085518)
,p_short_name=>'Weekly Summary for &P148_FIRST_NAME. &P148_LAST_NAME.'
,p_link=>'f?p=&APP_ID.:148:&SESSION.::&DEBUG.:::'
,p_page_id=>148
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(20627900142610283129)
,p_short_name=>'&NOMENCLATURE_PROJECT. Exceptions for &P153_FIRST_NAME. &P153_LAST_NAME.'
,p_link=>'f?p=&APP_ID.:153:&SESSION.::&DEBUG.:::'
,p_page_id=>153
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(23982224337906984869)
,p_short_name=>'Documents'
,p_link=>'f?p=&APP_ID.:156:&SESSION.::&DEBUG.:::'
,p_page_id=>156
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(24163915406951909310)
,p_short_name=>'Comments'
,p_link=>'f?p=&APP_ID.:158:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>158
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(24178069192666463986)
,p_short_name=>'&NOMENCLATURE_PROJECT. Contributors'
,p_link=>'f?p=&APP_ID.:159:&SESSION.::&DEBUG.:::'
,p_page_id=>159
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(24281808562495345612)
,p_short_name=>'Images in Comments'
,p_link=>'f?p=&APP_ID.:157:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>157
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(25086112012500322283)
,p_short_name=>'Change History: Release &P14_RELEASE.'
,p_link=>'f?p=&APP_ID.:14:&SESSION.::&DEBUG.:::'
,p_page_id=>14
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(27872506523622029597)
,p_short_name=>'AI Prompts'
,p_link=>'f?p=&APP_ID.:12135:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>12135
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(27873935015007090370)
,p_short_name=>'Edit Prompt'
,p_link=>'f?p=&APP_ID.:12136:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>12136
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(28205424230937881083)
,p_short_name=>'Error Log'
,p_link=>'f?p=&APP_ID.:16000:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>16000
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(28636591325818820583)
,p_short_name=>'All &NOMENCLATURE_PROJECT. Summaries'
,p_link=>'f?p=&APP_ID.:37:&SESSION.::&DEBUG.:::'
,p_page_id=>37
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(29014256678128785848)
,p_short_name=>'Interactive Report Catalog'
,p_link=>'f?p=&APP_ID.:10300:&SESSION.::&DEBUG.:::'
,p_page_id=>10300
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(29237423182997310600)
,p_short_name=>'Users that are not &NOMENCLATURE_USERS.'
,p_link=>'f?p=&APP_ID.:10015:&SESSION.::&DEBUG.:::'
,p_page_id=>10015
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(29237716749625438567)
,p_short_name=>'&NOMENCLATURE_USERS. that are not Users'
,p_link=>'f?p=&APP_ID.:10016:&SESSION.::&DEBUG.:::'
,p_page_id=>10016
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(29520578515042731185)
,p_short_name=>'Cross-Release Milestone Calendar'
,p_link=>'f?p=&APP_ID.:55:&SESSION.::&DEBUG.:::'
,p_page_id=>55
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(30776484985537358503)
,p_short_name=>'All Release Summaries'
,p_link=>'f?p=&APP_ID.:167:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>167
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(31285851241520652275)
,p_short_name=>'Release Milestone Default Tags'
,p_link=>'f?p=&APP_ID.:10515:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10515
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(31821607890923411353)
,p_short_name=>'All Events'
,p_link=>'f?p=&APP_ID.:710:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>710
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(38093814997538823312)
,p_short_name=>'&P501_PAGE_NAME.'
,p_link=>'f?p=&APP_ID.:501:&SESSION.::&DEBUG.:::'
,p_page_id=>501
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(38127478781691738501)
,p_short_name=>'&NOMENCLATURE_PROJECT. Groups'
,p_link=>'f?p=&APP_ID.:70:&SESSION.::&DEBUG.:::'
,p_page_id=>70
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(38173863826966508796)
,p_short_name=>'Change History'
,p_link=>'f?p=&APP_ID.:64:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>64
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(38288475714536131531)
,p_short_name=>'Add Project'
,p_link=>'f?p=&APP_ID.:104:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>104
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(38311109014970763969)
,p_short_name=>'My &NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:113:&SESSION.::&DEBUG.:::'
,p_page_id=>113
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(38704363369354416966)
,p_short_name=>'&P300_RELEASE. &NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.:::'
,p_page_id=>300
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(38891220362277586155)
,p_short_name=>'Developer Detail Views (31 Days)'
,p_link=>'f?p=&APP_ID.:129:&SESSION.::&DEBUG.:::'
,p_page_id=>129
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(39012384041890607342)
,p_short_name=>'&P29_PROJECT_NAME. - Images'
,p_link=>'f?p=&APP_ID.:29:&SESSION.::&DEBUG.:::'
,p_page_id=>29
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(39191497363024313737)
,p_short_name=>'About Page Text'
,p_link=>'f?p=&APP_ID.:14000:&SESSION.::&DEBUG.:::'
,p_page_id=>14000
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(39672792276775962980)
,p_short_name=>'&NOMENCLATURE_INITIATIVES. for &NOMENCLATURE_AREA. &P66_AREA.'
,p_link=>'f?p=&APP_ID.:66:&SESSION.::&DEBUG.:RP::'
,p_page_id=>66
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(39785052119060300606)
,p_short_name=>'&NOMENCLATURE_PROJECT. Related Current Activity'
,p_link=>'f?p=&APP_ID.:75:&SESSION.::&DEBUG.:::'
,p_page_id=>75
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40287976519496219296)
,p_short_name=>'Resource Type Usage'
,p_link=>'f?p=&APP_ID.:10601:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10601
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40292487769524944237)
,p_short_name=>'&NOMENCLATURE_INITIATIVE. Focus Areas'
,p_link=>'f?p=&APP_ID.:10150:&SESSION.::&DEBUG.:::'
,p_page_id=>10150
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40432342850592203175)
,p_short_name=>'Page Views'
,p_link=>'f?p=&APP_ID.:39:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>39
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40433326894323243386)
,p_short_name=>'Page Performance'
,p_link=>'f?p=&APP_ID.:71:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>71
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40443975227909825454)
,p_short_name=>'Page Views by User'
,p_link=>'f?p=&APP_ID.:72:&SESSION.::&DEBUG.:::'
,p_page_id=>72
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40479146254651325934)
,p_short_name=>'&P30_DOCUMENT_NAME.'
,p_link=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.:::'
,p_page_id=>30
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40595778765349176317)
,p_short_name=>'&NOMENCLATURE_STRATEGIC_PLANNER.'
,p_link=>'f?p=&APP_ID.:10820:&SESSION.::&DEBUG.:::'
,p_page_id=>10820
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40986306515232991367)
,p_short_name=>'Notifications'
,p_link=>'f?p=&APP_ID.:10074:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10074
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40988120837486943961)
,p_short_name=>'My Subscriptions'
,p_link=>'f?p=&APP_ID.:139:&SESSION.::&DEBUG.:::'
,p_page_id=>139
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(40994061847408554299)
,p_short_name=>'Manage My Subscriptions'
,p_link=>'f?p=&APP_ID.:149:&SESSION.::&DEBUG.:::'
,p_page_id=>149
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(41271544515461147724)
,p_short_name=>'&NOMENCLATURE_USERS.'
,p_link=>'f?p=&APP_ID.:74:&SESSION.::&DEBUG.:::'
,p_page_id=>74
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(41372782601505101936)
,p_short_name=>'External &NOMENCLATURE_PROJECT. Links'
,p_link=>'f?p=&APP_ID.:10750:&SESSION.::&DEBUG.:::'
,p_page_id=>10750
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(41376594137452488349)
,p_short_name=>'Home Page Messages'
,p_link=>'f?p=&APP_ID.:10770:&SESSION.::&DEBUG.:::'
,p_page_id=>10770
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(41564387654247467488)
,p_short_name=>'&NOMENCLATURE_INITIATIVE.: &P94_INITIATIVE.'
,p_link=>'f?p=&APP_ID.:94:&SESSION.::&DEBUG.:RP::'
,p_page_id=>94
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(41597303117170478210)
,p_short_name=>'Release: &P117_RELEASE.'
,p_link=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:::'
,p_page_id=>117
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(41993691676387342245)
,p_short_name=>'Release Calendar: &P203_RELEASE.'
,p_link=>'f?p=&APP_ID.:203:&SESSION.::&DEBUG.:::'
,p_page_id=>203
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(42289385964259682289)
,p_short_name=>'&NOMENCLATURE_PROJECT. Completeness Scales'
,p_link=>'f?p=&APP_ID.:10200:&SESSION.::&DEBUG.:::'
,p_page_id=>10200
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(42364015937717711534)
,p_short_name=>'Application Log'
,p_link=>'f?p=&APP_ID.:10050:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10050
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(42564079659635647220)
,p_short_name=>'Project Size'
,p_link=>'f?p=&APP_ID.:10100:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10100
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(43086925945631945168)
,p_short_name=>'Release Milestone Types'
,p_link=>'f?p=&APP_ID.:10090:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10090
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(43691977399675946958)
,p_short_name=>'Favorited &NOMENCLATURE_PROJECTS. by User'
,p_link=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:::'
,p_page_id=>15
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(43694942109895006128)
,p_short_name=>'Favorite &NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:91:&SESSION.::&DEBUG.:::'
,p_page_id=>91
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(43859237842494711679)
,p_short_name=>'Project Milestone Calendar'
,p_link=>'f?p=&APP_ID.:111:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>111
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(44407108586247678505)
,p_short_name=>'&P119_PROJECT_GROUP. &NOMENCLATURE_PROJECT. Group'
,p_link=>'f?p=&APP_ID.:119:&SESSION.::&DEBUG.:::'
,p_page_id=>119
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(44865520019745298199)
,p_short_name=>'Nomenclature'
,p_link=>'f?p=&APP_ID.:10400:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10400
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(45092356054943940493)
,p_short_name=>'Feedback'
,p_link=>'f?p=&APP_ID.:12123:&SESSION.::&DEBUG.:::'
,p_page_id=>12123
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(45482764895177658950)
,p_short_name=>'&NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:86:&SESSION.::&DEBUG.:::'
,p_page_id=>86
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(45886865193319306501)
,p_short_name=>'Groups'
,p_link=>'f?p=&APP_ID.:103:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>103
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(45888499159663841930)
,p_short_name=>'&P151_GROUP_NAME.'
,p_link=>'f?p=&APP_ID.:151:&SESSION.::&DEBUG.:::'
,p_page_id=>151
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(46235561770130238195)
,p_short_name=>'Change History'
,p_link=>'f?p=&APP_ID.:79:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>79
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(46255769369096639763)
,p_short_name=>'Workflow Console'
,p_link=>'f?p=&APP_ID.:4000:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>4000
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(46715334144020350473)
,p_short_name=>'Screen Names'
,p_link=>'f?p=&APP_ID.:122:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>122
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(46719944528118830117)
,p_short_name=>'Comments'
,p_link=>'f?p=&APP_ID.:7:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>7
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(46900431881184730197)
,p_short_name=>'APEX Bugs'
,p_link=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:::'
,p_page_id=>4
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(46929192644415405941)
,p_short_name=>'&NOMENCLATURE_PROJECT. Default Tags'
,p_link=>'f?p=&APP_ID.:10500:&SESSION.::&DEBUG.:::'
,p_page_id=>10500
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(46942950154672846864)
,p_short_name=>'Configure Application Features'
,p_link=>'f?p=&APP_ID.:12130:&SESSION.::&DEBUG.:::'
,p_page_id=>12130
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(47015349486524045875)
,p_short_name=>'Reports'
,p_link=>'f?p=&APP_ID.:41:&SESSION.::&DEBUG.:::'
,p_page_id=>41
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(47730325034785401653)
,p_short_name=>'Countries'
,p_link=>'f?p=&APP_ID.:43:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>43
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(47935125195560385639)
,p_short_name=>'Default Competencies'
,p_link=>'f?p=&APP_ID.:154:&SESSION.::&DEBUG.:::'
,p_page_id=>154
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(47994657274995186255)
,p_short_name=>'Job Reporting'
,p_link=>'f?p=&APP_ID.:16010:&SESSION.::&DEBUG.:::'
,p_page_id=>16010
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48024973199318138996)
,p_short_name=>'Subscriptions'
,p_link=>'f?p=&APP_ID.:16015:&SESSION.::&DEBUG.:::'
,p_page_id=>16015
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48131299932680303295)
,p_short_name=>'Settings'
,p_link=>'f?p=&APP_ID.:12150:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>12150
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48521659754604364784)
,p_short_name=>'Manage Archived &NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:11300:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>11300
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48564179345687220654)
,p_short_name=>'Archived &NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:45:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>45
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48574922560391928187)
,p_short_name=>'Duplicate &NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:::'
,p_page_id=>51
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48652285822784394517)
,p_short_name=>'Approval Types'
,p_link=>'f?p=&APP_ID.:4010:&SESSION.::&DEBUG.:::'
,p_page_id=>4010
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48653719424178575514)
,p_short_name=>'&NOMENCLATURE_INITIATIVE. Approval Types'
,p_link=>'f?p=&APP_ID.:4012:&SESSION.::&DEBUG.:::'
,p_page_id=>4012
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48656015397668049232)
,p_short_name=>'Initiative Approval Chain'
,p_link=>'f?p=&APP_ID.:4014:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>4014
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48773241858350264478)
,p_short_name=>'Email Reporting'
,p_link=>'f?p=&APP_ID.:16020:&SESSION.::&DEBUG.:::'
,p_page_id=>16020
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48857317095160847875)
,p_short_name=>'&NOMENCLATURE_PROJECT. Milestones, Reviews and Tasks'
,p_link=>'f?p=&APP_ID.:65:&SESSION.::&DEBUG.:::'
,p_page_id=>65
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48858734535293982460)
,p_short_name=>'Most Viewed Projects (90 Days)'
,p_link=>'f?p=&APP_ID.:97:&SESSION.::&DEBUG.:::'
,p_page_id=>97
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(48908827750190393564)
,p_short_name=>'Image Gallery'
,p_link=>'f?p=&APP_ID.:46:&SESSION.::&DEBUG.:::'
,p_page_id=>46
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(49172866796476132224)
,p_short_name=>'&NOMENCLATURE_PROJECT. Interactions'
,p_link=>'f?p=&APP_ID.:610:&SESSION.::&DEBUG.:::'
,p_page_id=>610
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(50489717236251786807)
,p_short_name=>'All &NOMENCLATURE_PROJECT. Approvals'
,p_link=>'f?p=&APP_ID.:134:&SESSION.::&DEBUG.:::'
,p_page_id=>134
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(50983444668694889518)
,p_short_name=>'Duplicate &NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:11320:&SESSION.::&DEBUG.:::'
,p_page_id=>11320
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(51100319066799816128)
,p_short_name=>'Activity Types'
,p_link=>'f?p=&APP_ID.:10700:&SESSION.::&DEBUG.:RP::'
,p_page_id=>10700
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(51183854919035154879)
,p_short_name=>'Activities'
,p_link=>'f?p=&APP_ID.:102:&SESSION.::&DEBUG.:::'
,p_page_id=>102
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(51364843274847809127)
,p_short_name=>'Release Dashboard: &P202_RELEASE.'
,p_link=>'f?p=&APP_ID.:202:&SESSION.::&DEBUG.:::'
,p_page_id=>202
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(51492516909629615726)
,p_short_name=>'Past Due Milestones, Reviews and Tasks'
,p_link=>'f?p=&APP_ID.:99:&SESSION.::&DEBUG.:RP::'
,p_page_id=>99
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(51680940191215176942)
,p_short_name=>'&P112_INITIATIVE. Milestones Report'
,p_link=>'f?p=&APP_ID.:112:&SESSION.::&DEBUG.:RP::'
,p_page_id=>112
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(51783405354852287668)
,p_short_name=>'Release Gantt'
,p_link=>'f?p=&APP_ID.:133:&SESSION.::&DEBUG.:::'
,p_page_id=>133
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(51905921352067107886)
,p_short_name=>'Jira Sync Information'
,p_link=>'f?p=&APP_ID.:142:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>142
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(52409747354142225714)
,p_short_name=>'Delete Sample Data'
,p_link=>'f?p=&APP_ID.:14010:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>14010
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(53087194972121160063)
,p_short_name=>'&NOMENCLATURE_PROJECT. Statuses'
,p_link=>'f?p=&APP_ID.:10110:&SESSION.::&DEBUG.:::'
,p_page_id=>10110
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(53550869642668945889)
,p_short_name=>'Links'
,p_link=>'f?p=&APP_ID.:146:&SESSION.::&DEBUG.:::'
,p_page_id=>146
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(53566301069943514733)
,p_short_name=>'&P42_DOCUMENT_NAME.'
,p_link=>'f?p=&APP_ID.:42:&SESSION.::&DEBUG.:::'
,p_page_id=>42
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(53569234736081784087)
,p_short_name=>'&P53_DOCUMENT_NAME.'
,p_link=>'f?p=&APP_ID.:53:&SESSION.::&DEBUG.:::'
,p_page_id=>53
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(53809960341105490073)
,p_short_name=>'&NOMENCLATURE_INITIATIVE. Change History'
,p_link=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:::'
,p_page_id=>11
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(53925713511607864530)
,p_short_name=>'&P33_INITIATIVE. - &P33_FOCUS_AREA.'
,p_link=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:::'
,p_page_id=>33
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54023495967509089075)
,p_short_name=>'&P57_INIT_FOCUS_AREA.'
,p_link=>'f?p=&APP_ID.:57:&SESSION.::&DEBUG.:::'
,p_page_id=>57
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54025783485827590663)
,p_short_name=>'&P59_DOCUMENT_NAME.'
,p_link=>'f?p=&APP_ID.:59:&SESSION.::&DEBUG.:::'
,p_page_id=>59
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54394305304098542828)
,p_short_name=>'&P60_TASK_NAME. - Images'
,p_link=>'f?p=&APP_ID.:60:&SESSION.::&DEBUG.:::'
,p_page_id=>60
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54428697161943446942)
,p_short_name=>'&P62_INITIATIVE_NAME. - Images'
,p_link=>'f?p=&APP_ID.:62:&SESSION.::&DEBUG.:::'
,p_page_id=>62
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54493193596823766120)
,p_short_name=>'&P68_FOCUS_AREA. -  Images'
,p_link=>'f?p=&APP_ID.:68:&SESSION.::&DEBUG.:::'
,p_page_id=>68
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(54501730688318340734)
,p_short_name=>'&P69_RELEASE. - Images'
,p_link=>'f?p=&APP_ID.:69:&SESSION.::&DEBUG.:::'
,p_page_id=>69
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55028475505125165295)
,p_short_name=>'&P502_TASK.'
,p_link=>'f?p=&APP_ID.:502:&SESSION.::&DEBUG.:::'
,p_page_id=>502
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55059803903518743298)
,p_short_name=>'Task Document Details'
,p_link=>'f?p=&APP_ID.:505:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>505
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55064619814166047201)
,p_short_name=>'Task Change History'
,p_link=>'f?p=&APP_ID.:507:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>507
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55134379762306396342)
,p_short_name=>'Task Statuses'
,p_link=>'f?p=&APP_ID.:10061:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10061
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55140953623659438634)
,p_short_name=>'Task Status'
,p_link=>'f?p=&APP_ID.:10062:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10062
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55144187753115644611)
,p_short_name=>'Task Types'
,p_link=>'f?p=&APP_ID.:10064:&APP_SESSION.::&DEBUG.:::'
,p_page_id=>10064
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55202764400903756923)
,p_short_name=>'&NOMENCLATURE_PROJECT. Views by User (90 days)'
,p_link=>'f?p=&APP_ID.:80:&SESSION.::&DEBUG.:::'
,p_page_id=>80
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55204199442564003694)
,p_short_name=>'&NOMENCLATURE_INITIATIVE. Views (last 90 Days)'
,p_link=>'f?p=&APP_ID.:81:&SESSION.::&DEBUG.:::'
,p_page_id=>81
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(55206281700122071948)
,p_short_name=>'Project Views by User by Month'
,p_link=>'f?p=&APP_ID.:89:&SESSION.::&DEBUG.:::'
,p_page_id=>89
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(68515766385711216597)
,p_short_name=>'Releases'
,p_link=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:::'
,p_page_id=>8
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(68815485564911521295)
,p_short_name=>'Release Train Gantt'
,p_link=>'f?p=&APP_ID.:16:&SESSION.::&DEBUG.:RP::'
,p_page_id=>16
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(149176772205324830833)
,p_short_name=>'&P3_PROJECT_NAME.'
,p_link=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:::'
,p_page_id=>3
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(151756076027494677987)
,p_short_name=>'&NOMENCLATURE_PROJECT. Priorities'
,p_link=>'f?p=&APP_ID.:10800:&SESSION.::&DEBUG.:::'
,p_page_id=>10800
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(151954488127839394932)
,p_short_name=>'&P5_FIRST_NAME. &P5_LAST_NAME.'
,p_link=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:::'
,p_page_id=>5
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(176221935068588897475)
,p_short_name=>'&NOMENCLATURE_STRATEGIC_PLANNER.'
,p_link=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:::'
,p_page_id=>1
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(176222298439494898494)
,p_short_name=>'Administration'
,p_link=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_page_id=>10000
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(176240966074924124010)
,p_short_name=>'Contributor Roles'
,p_link=>'f?p=&APP_ID.:10600:&SESSION.::&DEBUG.:::'
,p_page_id=>10600
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(176241898933063573759)
,p_short_name=>'&NOMENCLATURE_AREAS.'
,p_link=>'f?p=&APP_ID.:17:&SESSION.::&DEBUG.:::'
,p_page_id=>17
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(176242172118302591061)
,p_short_name=>'&NOMENCLATURE_USERS. Details'
,p_link=>'f?p=&APP_ID.:19:&SESSION.::&DEBUG.:::'
,p_page_id=>19
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(176257888442133813290)
,p_short_name=>'&NOMENCLATURE_INITIATIVES.'
,p_link=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:::'
,p_page_id=>21
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(176264905142446484097)
,p_short_name=>'&NOMENCLATURE_PROJECTS.'
,p_link=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:::'
,p_page_id=>23
);
wwv_flow_imp_shared.create_menu_option(
 p_id=>wwv_flow_imp.id(41222446553992653022)
,p_option_sequence=>10011
,p_short_name=>'Users'
,p_link=>'f?p=&APP_ID.:10011:&SESSION.::&DEBUG.:::'
,p_page_id=>10011
);
wwv_flow_imp.component_end;
end;
/
