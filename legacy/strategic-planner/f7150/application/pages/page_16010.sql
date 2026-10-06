prompt --application/pages/page_16010
begin
--   Manifest
--     PAGE: 16010
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
 p_id=>16010
,p_name=>'Job Reporting'
,p_alias=>'JOB-REPORTING'
,p_step_title=>'Job Reporting'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_imp.id(176222235169458897802)
,p_page_css_classes=>'rw-pillar--sienna'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_imp.id(176222233957385897793)
,p_protection_level=>'C'
,p_help_text=>'<p>This report includes all the jobs selected to be monitored by this application.  More details of each job can be viewed by clicking on the job name.</p>'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(47992732668014585103)
,p_plug_name=>'Job Reporting'
,p_plug_display_sequence=>10
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select JOB_NAME,',
'       JOB_CLASS,',
'       ENABLED,',
'       STATE,',
'       RUN_COUNT,',
'       FAILURE_COUNT,',
'       RETRY_COUNT,',
'       REPEAT_INTERVAL,',
'       LAST_START_DATE,',
'       LAST_START_DATE DATE_SINCE,',
'       LAST_RUN_DURATION,',
'       JOB_SUBNAME,',
'       JOB_STYLE,',
'       JOB_CREATOR,',
'       CLIENT_ID,',
'       GLOBAL_UID,',
'       PROGRAM_OWNER,',
'       PROGRAM_NAME,',
'       JOB_TYPE,',
'       JOB_ACTION,',
'       NUMBER_OF_ARGUMENTS,',
'       SCHEDULE_OWNER,',
'       SCHEDULE_NAME,',
'       SCHEDULE_TYPE,',
'       START_DATE,',
'       EVENT_QUEUE_OWNER,',
'       EVENT_QUEUE_NAME,',
'       EVENT_QUEUE_AGENT,',
'       EVENT_CONDITION,',
'       EVENT_RULE,',
'       FILE_WATCHER_OWNER,',
'       FILE_WATCHER_NAME,',
'       END_DATE,',
'       AUTO_DROP,',
'       RESTART_ON_RECOVERY,',
'       RESTART_ON_FAILURE,',
'       JOB_PRIORITY,',
'       MAX_RUNS,',
'       MAX_FAILURES,',
'       NEXT_RUN_DATE,',
'       SCHEDULE_LIMIT,',
'       MAX_RUN_DURATION,',
'       LOGGING_LEVEL,',
'       STORE_OUTPUT,',
'       STOP_ON_WINDOW_CLOSE,',
'       INSTANCE_STICKINESS,',
'       RAISE_EVENTS,',
'       SYSTEM,',
'       JOB_WEIGHT,',
'       NLS_ENV,',
'       SOURCE,',
'       NUMBER_OF_DESTINATIONS,',
'       DESTINATION_OWNER,',
'       DESTINATION,',
'       CREDENTIAL_OWNER,',
'       CREDENTIAL_NAME,',
'       INSTANCE_ID,',
'       DEFERRED_DROP,',
'       ALLOW_RUNS_IN_RESTRICTED_MODE,',
'       COMMENTS,',
'       FLAGS,',
'       RESTARTABLE,',
'       CONNECT_CREDENTIAL_OWNER,',
'       CONNECT_CREDENTIAL_NAME',
'  from user_scheduler_jobs  ',
' where job_name in (''SP_NOTIF_SUBSCRIPTIONS'',''SP_GENERATE_AI_PROJECT_SUMMARIES_JOB'',''SBK_TEST_SUMMAIRES'')'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Job Reporting'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(47992733343261585103)
,p_name=>'Job Reporting'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'SBKENNED'
,p_internal_uid=>11093375477859617334
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992734898770585130)
,p_db_column_name=>'JOB_NAME'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Job Name'
,p_column_link=>'f?p=&APP_ID.:16011:&APP_SESSION.::&DEBUG.:RR:IR_JOB_NAME:#JOB_NAME#'
,p_column_linktext=>'#JOB_NAME#'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992735329716585131)
,p_db_column_name=>'JOB_CLASS'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Job Class'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992735749722585131)
,p_db_column_name=>'ENABLED'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Enabled'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992736123281585132)
,p_db_column_name=>'STATE'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'State'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992736483805585132)
,p_db_column_name=>'RUN_COUNT'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Run Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992736892453585133)
,p_db_column_name=>'FAILURE_COUNT'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Failure Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992737274274585133)
,p_db_column_name=>'RETRY_COUNT'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Retry Count'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992737710541585134)
,p_db_column_name=>'REPEAT_INTERVAL'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Repeat Interval'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992738157200585134)
,p_db_column_name=>'LAST_START_DATE'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Last Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992738556117585135)
,p_db_column_name=>'LAST_RUN_DURATION'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Last Run Duration'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'OTHER'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992738882981585135)
,p_db_column_name=>'JOB_SUBNAME'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Job Subname'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992739290511585136)
,p_db_column_name=>'JOB_STYLE'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>'Job Style'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992739721193585136)
,p_db_column_name=>'JOB_CREATOR'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>'Job Creator'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992740122429585137)
,p_db_column_name=>'CLIENT_ID'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Client ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992740490226585137)
,p_db_column_name=>'GLOBAL_UID'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Global Unique ID'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992740917520585138)
,p_db_column_name=>'PROGRAM_OWNER'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>'Program Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992741321278585138)
,p_db_column_name=>'PROGRAM_NAME'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>'Program Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992741673872585139)
,p_db_column_name=>'JOB_TYPE'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Job Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992742114388585139)
,p_db_column_name=>'JOB_ACTION'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Job Action'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992742481949585140)
,p_db_column_name=>'NUMBER_OF_ARGUMENTS'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>'Number of Arguments'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992742933916585141)
,p_db_column_name=>'SCHEDULE_OWNER'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>'Schedule Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992743306862585141)
,p_db_column_name=>'SCHEDULE_NAME'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Schedule Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992743669033585142)
,p_db_column_name=>'SCHEDULE_TYPE'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Schedule Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992744119812585142)
,p_db_column_name=>'START_DATE'
,p_display_order=>24
,p_column_identifier=>'X'
,p_column_label=>'Start Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992744486038585143)
,p_db_column_name=>'EVENT_QUEUE_OWNER'
,p_display_order=>25
,p_column_identifier=>'Y'
,p_column_label=>'Event Queue Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992744956232585143)
,p_db_column_name=>'EVENT_QUEUE_NAME'
,p_display_order=>26
,p_column_identifier=>'Z'
,p_column_label=>'Event Queue Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992745340991585144)
,p_db_column_name=>'EVENT_QUEUE_AGENT'
,p_display_order=>27
,p_column_identifier=>'AA'
,p_column_label=>'Event Queue Agent'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992745756726585144)
,p_db_column_name=>'EVENT_CONDITION'
,p_display_order=>28
,p_column_identifier=>'AB'
,p_column_label=>'Event Condition'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992746162663585145)
,p_db_column_name=>'EVENT_RULE'
,p_display_order=>29
,p_column_identifier=>'AC'
,p_column_label=>'Event Rule'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992746559588585145)
,p_db_column_name=>'FILE_WATCHER_OWNER'
,p_display_order=>30
,p_column_identifier=>'AD'
,p_column_label=>'File Watcher Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992746870759585146)
,p_db_column_name=>'FILE_WATCHER_NAME'
,p_display_order=>31
,p_column_identifier=>'AE'
,p_column_label=>'File Watcher Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992747362299585146)
,p_db_column_name=>'END_DATE'
,p_display_order=>32
,p_column_identifier=>'AF'
,p_column_label=>'End Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992747753772585147)
,p_db_column_name=>'AUTO_DROP'
,p_display_order=>33
,p_column_identifier=>'AG'
,p_column_label=>'Auto Drop'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992748112290585147)
,p_db_column_name=>'RESTART_ON_RECOVERY'
,p_display_order=>34
,p_column_identifier=>'AH'
,p_column_label=>'Restart on Recovery'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992748528836585148)
,p_db_column_name=>'RESTART_ON_FAILURE'
,p_display_order=>35
,p_column_identifier=>'AI'
,p_column_label=>'Restart on Failure'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992748903553585149)
,p_db_column_name=>'JOB_PRIORITY'
,p_display_order=>36
,p_column_identifier=>'AJ'
,p_column_label=>'Job Priority'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992749291808585149)
,p_db_column_name=>'MAX_RUNS'
,p_display_order=>37
,p_column_identifier=>'AK'
,p_column_label=>'Maximum Runs'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992749749880585150)
,p_db_column_name=>'MAX_FAILURES'
,p_display_order=>38
,p_column_identifier=>'AL'
,p_column_label=>'Maximum Failures'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992750164878585150)
,p_db_column_name=>'NEXT_RUN_DATE'
,p_display_order=>39
,p_column_identifier=>'AM'
,p_column_label=>'Next Run Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD-Mon-YYYY HH:MIPM'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992750547183585151)
,p_db_column_name=>'SCHEDULE_LIMIT'
,p_display_order=>40
,p_column_identifier=>'AN'
,p_column_label=>'Schedule Limit'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'OTHER'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992750949602585151)
,p_db_column_name=>'MAX_RUN_DURATION'
,p_display_order=>41
,p_column_identifier=>'AO'
,p_column_label=>'Maximum Run Duration'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'OTHER'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992751287724585152)
,p_db_column_name=>'LOGGING_LEVEL'
,p_display_order=>42
,p_column_identifier=>'AP'
,p_column_label=>'Logging Level'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992751697771585152)
,p_db_column_name=>'STORE_OUTPUT'
,p_display_order=>43
,p_column_identifier=>'AQ'
,p_column_label=>'Store Output'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992752110348585153)
,p_db_column_name=>'STOP_ON_WINDOW_CLOSE'
,p_display_order=>44
,p_column_identifier=>'AR'
,p_column_label=>'Stop on Window Close'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992752473870585153)
,p_db_column_name=>'INSTANCE_STICKINESS'
,p_display_order=>45
,p_column_identifier=>'AS'
,p_column_label=>'Instance Stickiness'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992752935719585154)
,p_db_column_name=>'RAISE_EVENTS'
,p_display_order=>46
,p_column_identifier=>'AT'
,p_column_label=>'Raise Events'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992753329565585154)
,p_db_column_name=>'SYSTEM'
,p_display_order=>47
,p_column_identifier=>'AU'
,p_column_label=>'System'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992753745884585155)
,p_db_column_name=>'JOB_WEIGHT'
,p_display_order=>48
,p_column_identifier=>'AV'
,p_column_label=>'Job Weight'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992754116558585155)
,p_db_column_name=>'NLS_ENV'
,p_display_order=>49
,p_column_identifier=>'AW'
,p_column_label=>'NLS Environment'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992754898103585157)
,p_db_column_name=>'SOURCE'
,p_display_order=>50
,p_column_identifier=>'AX'
,p_column_label=>'Source'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992755428403585158)
,p_db_column_name=>'NUMBER_OF_DESTINATIONS'
,p_display_order=>51
,p_column_identifier=>'AY'
,p_column_label=>'Number of Destinations'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992755858753585159)
,p_db_column_name=>'DESTINATION_OWNER'
,p_display_order=>52
,p_column_identifier=>'AZ'
,p_column_label=>'Destination Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992756241764585160)
,p_db_column_name=>'DESTINATION'
,p_display_order=>53
,p_column_identifier=>'BA'
,p_column_label=>'Destination'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992756642723585160)
,p_db_column_name=>'CREDENTIAL_OWNER'
,p_display_order=>54
,p_column_identifier=>'BB'
,p_column_label=>'Credential Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992756977254585161)
,p_db_column_name=>'CREDENTIAL_NAME'
,p_display_order=>55
,p_column_identifier=>'BC'
,p_column_label=>'Credential Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992757378415585162)
,p_db_column_name=>'INSTANCE_ID'
,p_display_order=>56
,p_column_identifier=>'BD'
,p_column_label=>'Instance ID'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992757793254585162)
,p_db_column_name=>'DEFERRED_DROP'
,p_display_order=>57
,p_column_identifier=>'BE'
,p_column_label=>'Deferred Drop'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992758247242585163)
,p_db_column_name=>'ALLOW_RUNS_IN_RESTRICTED_MODE'
,p_display_order=>58
,p_column_identifier=>'BF'
,p_column_label=>'Allow Runs in Restricted Mode'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992758589529585164)
,p_db_column_name=>'COMMENTS'
,p_display_order=>59
,p_column_identifier=>'BG'
,p_column_label=>'Comments'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992759028140585164)
,p_db_column_name=>'FLAGS'
,p_display_order=>60
,p_column_identifier=>'BH'
,p_column_label=>'Flags'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992759465318585165)
,p_db_column_name=>'RESTARTABLE'
,p_display_order=>61
,p_column_identifier=>'BI'
,p_column_label=>'Restartable'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992759864363585166)
,p_db_column_name=>'CONNECT_CREDENTIAL_OWNER'
,p_display_order=>62
,p_column_identifier=>'BJ'
,p_column_label=>'Connect Credential Owner'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(47992760251271585166)
,p_db_column_name=>'CONNECT_CREDENTIAL_NAME'
,p_display_order=>63
,p_column_identifier=>'BK'
,p_column_label=>'Connect Credential Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(29014890083986880764)
,p_db_column_name=>'DATE_SINCE'
,p_display_order=>73
,p_column_identifier=>'BL'
,p_column_label=>'Last Started'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'SINCE'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(47992779844904585192)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'110934220'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'JOB_NAME:ENABLED:STATE:RUN_COUNT:FAILURE_COUNT:RETRY_COUNT:REPEAT_INTERVAL:DATE_SINCE:LAST_RUN_DURATION:NEXT_RUN_DATE'
,p_sort_column_1=>'JOB_NAME'
,p_sort_direction_1=>'ASC'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(66003604245262935811)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2531463326621247859
,p_plug_display_sequence=>5
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(176221934902378897475)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4072363345357175094
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47994498818845745594)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(66003604245262935811)
,p_button_name=>'Reset'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft'
,p_button_template_id=>2082829544945815391
,p_button_image_alt=>'Reset'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:16010:&SESSION.::&DEBUG.:RR,16010::'
,p_icon_css_classes=>'fa-undo-alt'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(47994498413453745593)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(66003604245262935811)
,p_button_name=>'UP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI'
,p_button_template_id=>2349107722467437027
,p_button_image_alt=>'Navigate Up'
,p_button_position=>'UP'
,p_button_redirect_url=>'f?p=&APP_ID.:10000:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-arrow-up'
);
wwv_flow_imp.component_end;
end;
/
