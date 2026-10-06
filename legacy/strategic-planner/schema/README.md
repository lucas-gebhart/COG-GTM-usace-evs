# SP_ schema install scripts

Extracted from the APEX supporting objects (`application/deployment/install/*.sql`) by
`python -m apex_inventory ... --schema-out`. Files run in APEX install order; `install_all.sql`
chains them for SQL*Plus or SQLcl. These are Oracle SQL and PL/SQL; WP2 feeds the DDL files to
ora2pg (`ora2pg -t TABLE -i <file>`) and ports the packages by hand or through ora2pg's
PL/SQL pass.

Object counts: 2 function, 101 index, 9 package, 8 package_body, 1 procedure, 2 sequence, 72 table, 92 trigger, 6 view.

| # | File | Kind | Objects |
|---|---|---|---|
| 1 | `001_sequences.sql` | ddl | sequence: sp_kb_stack_rank_seq, sp_seq |
| 2 | `002_sp_globals_spec.sql` | ddl | package: sp_globals |
| 3 | `003_sp_util_spec.sql` | ddl | package: sp_util |
| 4 | `004_sp_comment_util_spec.sql` | ddl | package: sp_comment_util |
| 5 | `005_sp_contributor_summary_spec.sql` | ddl | package: sp_contributor_summary |
| 6 | `006_sp_release_timeline_package_spec.sql` | ddl | package: sp_release_timeline |
| 7 | `007_sp_approvals_spec.sql` | ddl | package: sp_approvals |
| 8 | `008_sp_summary_util_spec.sql` | ddl | package: sp_summary_util |
| 9 | `009_sp_app_log_table.sql` | ddl | table: sp_app_log; index: sp_app_log_i1; trigger: sp_app_log_bi |
| 10 | `010_sp_error_log_table_and_trigger.sql` | ddl | table: sp_error_log; index: sp_error_log_i1; trigger: sp_error_log_bi |
| 11 | `011_sp_app_settings.sql` | ddl | table: sp_app_settings; trigger: sp_app_settings_biu |
| 12 | `012_ai_prompts_table_and_trigger.sql` | ddl | table: sp_ai_prompts; trigger: sp_ai_prompts_biu |
| 13 | `013_sp_report_questions_table_and_trigger.sql` | ddl | table: sp_report_questions; trigger: sp_report_questions_biu |
| 14 | `014_sp_default_tags_table.sql` | ddl | table: sp_default_tags |
| 15 | `015_sp_app_nomenclature_table.sql` | ddl | table: sp_app_nomenclature |
| 16 | `016_sp_resource_types_table.sql` | ddl | table: sp_resource_types |
| 17 | `017_sp_competencies_table.sql` | ddl | table: sp_competencies |
| 18 | `018_sp_groups_table.sql` | ddl | table: sp_groups |
| 19 | `019_sp_team_members_table.sql` | ddl | table: sp_team_members; index: sp_team_members_i1 |
| 20 | `020_sp_group_members_table.sql` | ddl | table: sp_group_members; index: sp_group_members_i1 |
| 21 | `021_sp_release_trains_table.sql` | ddl | table: sp_release_trains; index: sp_release_trains_u1 |
| 22 | `022_sp_release_history_table.sql` | ddl | table: sp_release_history; index: sp_release_history_i1, sp_release_history_i2 |
| 23 | `023_sp_areas_table.sql` | ddl | table: sp_areas; index: sp_areas_i1 |
| 24 | `024_sp_project_scales_table.sql` | ddl | table: sp_project_scales |
| 25 | `025_sp_initiatives_tables.sql` | ddl | table: sp_initiative_history, sp_initiatives; index: sp_initiative_history_i1, sp_initiative_history_i2, sp_initiatives_i1, sp_initiatives_i2, sp_initiatives_i3 |
| 26 | `026_sp_project_priorities_table.sql` | ddl | table: sp_project_priorities |
| 27 | `027_sp_project_sizes_table.sql` | ddl | table: sp_project_sizes |
| 28 | `028_sp_project_statuses_table.sql` | ddl | table: sp_project_statuses; trigger: sp_project_statuses_biu |
| 29 | `029_sp_project_groups_table.sql` | ddl | table: sp_project_groups; trigger: sp_project_groups_biu |
| 30 | `030_sp_initiative_focus_areas_tables.sql` | ddl | table: sp_init_focus_area_comments, sp_init_focus_area_documents, sp_init_focus_area_history, sp_init_focus_area_links, sp_initiative_focus_areas; index: sp_init_focus_area_comments_i1, sp_init_focus_area_comments_i2, sp_init_focus_area_comments_i3, sp_init_focus_area_documents_i1, sp_init_focus_area_documents_i2, sp_init_focus_area_history_i1, sp_init_focus_area_history_i2, sp_init_focus_area_links_i1, sp_init_focus_area_links_i2 |
| 31 | `031_sp_projects_tables.sql` | ddl | table: sp_project_contributors, sp_project_documents, sp_project_related, sp_projects; index: sp_project_contrib_i1, sp_project_contrib_i2, sp_project_contrib_i3, sp_project_contributors_i4, sp_project_documents_i1, sp_project_documents_i2, sp_project_related_i1, sp_project_related_i2, sp_projects_i1, sp_projects_i2, sp_projects_i3, sp_projects_i4, sp_projects_i5, sp_projects_i6, sp_projects_i7, sp_projects_i8 |
| 32 | `032_sp_project_history_table.sql` | ddl | table: sp_project_history; index: sp_project_history_i1, sp_project_history_i2 |
| 33 | `033_sp_project_links_table.sql` | ddl | table: sp_project_links; index: sp_project_links_i1, sp_project_links_i2 |
| 34 | `034_sp_project_comments_table.sql` | ddl | table: sp_project_comments, sp_project_comments_emails; index: sp_project_comm_emails_i1, sp_project_comm_emails_i2, sp_project_comments_i1, sp_project_comments_i2, sp_project_comments_i3, sp_project_comments_i4 |
| 35 | `035_sp_release_comments_table.sql` | ddl | table: sp_release_comments; index: sp_release_comments_i1, sp_release_comments_i2, sp_release_comments_i3 |
| 36 | `036_sp_comment_images_table_and_trigger.sql` | ddl | table: sp_comment_images; index: sp_comment_images_i1 |
| 37 | `037_sp_release_milestone_types_table_and_trigger.sql` | ddl | table: sp_release_milestone_types; trigger: sp_release_milestone_types_biu |
| 38 | `038_release_milestones_table.sql` | ddl | table: sp_release_milestones |
| 39 | `039_release_milestone_default_tags_table_and_trigger.sql` | ddl | table: sp_release_milestone_default_tags; trigger: sp_release_milestone_default_tags_biu |
| 40 | `040_release_documents_table_and_triggr.sql` | ddl | table: sp_release_documents; index: sp_release_documents_i1, sp_release_documents_i2; trigger: sp_release_documents_bd, sp_release_documents_biu |
| 41 | `041_package_sp_value_compare.sql` | ddl | package: sp_value_compare; package_body: sp_value_compare |
| 42 | `042_countries_table.sql` | ddl | table: sp_countries; trigger: sp_countries_biu |
| 43 | `043_external_system_names.sql` | ddl | table: sp_external_ticketing_systems; trigger: sp_external_ticketing_systems_biu |
| 44 | `044_triggers.sql` | ddl | trigger: sp_app_nomenclature_biu, sp_default_tags_biu, sp_project_priorities_biu, sp_project_scales_biu, sp_project_sizes_biu, sp_resource_types_biu |
| 45 | `045_sp_notifications_table.sql` | ddl | table: sp_notifications; trigger: sp_notifications_biu |
| 46 | `046_sp_notification_subscriptions.sql` | ddl | table: sp_notification_subscriptions; index: sp_notification_subscriptions_i1, sp_notification_subscriptions_i2; trigger: sp_notification_subscriptions_biu |
| 47 | `047_create_sp_areas_trigger.sql` | ddl | trigger: sp_areas_biu |
| 48 | `048_release_trains_triggers.sql` | ddl | trigger: sp_release_trains_ai, sp_release_trains_bd, sp_release_trains_biu |
| 49 | `049_create_sp_team_members_trigger.sql` | ddl | trigger: sp_team_members_biu |
| 50 | `050_sp_group_members_trigger.sql` | ddl | trigger: sp_group_members_biu |
| 51 | `051_sp_competencies_trigger.sql` | ddl | trigger: sp_competencies_biu |
| 52 | `052_sp_groups_trigger.sql` | ddl | trigger: sp_groups_biu |
| 53 | `053_initiatives_triggers.sql` | ddl | trigger: sp_initiatives_ai, sp_initiatives_bd, sp_initiatives_biu |
| 54 | `054_initiative_focus_area_triggers.sql` | ddl | trigger: sp_init_focus_area_comments_bd, sp_init_focus_area_comments_biu, sp_init_focus_area_documents_bd, sp_init_focus_area_documents_biu, sp_init_focus_area_links_bd, sp_init_focus_area_links_biu, sp_initiative_focus_areas_ai, sp_initiative_focus_areas_bd, sp_initiative_focus_areas_biu |
| 55 | `055_project_comments_triggers.sql` | ddl | trigger: sp_project_comments_bd, sp_project_comments_biu |
| 56 | `056_project_contributors_triggers.sql` | ddl | trigger: sp_project_contributors_bd, sp_project_contributors_biu |
| 57 | `057_release_comments_triggers.sql` | ddl | trigger: sp_release_comments_bd, sp_release_comments_biu |
| 58 | `058_project_documents_triggers.sql` | ddl | trigger: sp_project_documents_bd, sp_project_documents_biu |
| 59 | `059_project_links_triggers.sql` | ddl | trigger: sp_project_links_bd, sp_project_links_biu |
| 60 | `060_related_projects_trigger.sql` | ddl | trigger: sp_project_related_biu |
| 61 | `061_projects_triggers.sql` | ddl | trigger: sp_projects_ai, sp_projects_bd, sp_projects_biu |
| 62 | `062_release_milestone_triggers.sql` | ddl | trigger: sp_release_milestones_bd, sp_release_milestones_biu |
| 63 | `063_proj_interactions_log_table.sql` | ddl | table: sp_proj_interactions_log; trigger: sp_proj_interactions_log_biu; index: sp_proj_interactions_log_i1, sp_proj_interactions_log_i2; package: sp_log; package_body: sp_log |
| 64 | `064_activity_types_table.sql` | ddl | table: sp_activity_types |
| 65 | `065_activity_types_triggers.sql` | ddl | trigger: sp_activity_types_bd, sp_activity_types_biu |
| 66 | `066_sp_activities_table.sql` | ddl | table: sp_activities; index: sp_activities_i1, sp_activities_i2, sp_activities_i3, sp_activities_i4, sp_activities_i5, sp_activities_i6 |
| 67 | `067_sp_activities_trigger.sql` | ddl | trigger: sp_activities_biu |
| 68 | `068_sp_date_range_pct_comp_function.sql` | ddl | function: sp_date_range_pct_comp |
| 69 | `069_sp_tag_diff_function.sql` | ddl | function: sp_tag_diff |
| 70 | `070_favorites_table.sql` | ddl | table: sp_favorites; trigger: sp_favorites_biu |
| 71 | `071_favorite_toggle_procedure.sql` | ddl | procedure: sp_favorite_toggle |
| 72 | `072_configurable_text_table.sql` | ddl | table: sp_configurable_text; trigger: sp_configurable_text_biu |
| 73 | `073_sp_default_people_tags_table.sql` | ddl | table: sp_default_people_tags |
| 74 | `074_sp_default_people_tags_trigger.sql` | ddl | trigger: sp_default_people_tags_biu |
| 75 | `075_create_sp_application_notifications.sql` | ddl | table: sp_application_notifications; trigger: sp_application_notifications_biu |
| 76 | `076_initiative_comments_table_and_trigger.sql` | ddl | table: sp_initiative_comments; index: sp_initiative_comments_i1, sp_initiative_comments_i2, sp_initiative_comments_i3; trigger: sp_initiative_comments_bd, sp_initiative_comments_biu |
| 77 | `077_create_table_sp_release_links.sql` | ddl | table: sp_release_links; index: sp_release_links_i1; trigger: sp_release_links_bd, sp_release_links_biu |
| 78 | `078_initiative_links_table_and_trigger.sql` | ddl | table: sp_initiative_links; index: sp_initiative_links_i1; trigger: sp_initiative_links_biu |
| 79 | `079_initiative_documents_table_and_trigger.sql` | ddl | table: sp_initiative_documents; index: sp_initiative_documents_i1, sp_initiative_documents_i2; trigger: sp_initiative_documents_biu |
| 80 | `080_project_task_tables.sql` | ddl | table: sp_initiative_default_tasks, sp_task_comments, sp_task_documents, sp_task_history, sp_task_links, sp_task_statuses, sp_task_types, sp_tasks; index: sp_task_comments_i1, sp_task_comments_i2, sp_task_comments_i3, sp_task_documents_i1, sp_task_documents_i2, sp_task_history_i1, sp_task_history_i2, sp_task_links_i1, sp_task_links_i2, sp_tasks_i1, sp_tasks_i2, sp_tasks_i3, sp_tasks_i4 |
| 81 | `081_project_task_triggers.sql` | ddl | trigger: sp_initiative_def_tasks_biu, sp_task_comments_bd, sp_task_comments_biu, sp_task_documents_bd, sp_task_documents_biu, sp_task_links_bd, sp_task_links_biu, sp_task_statuses_biu, sp_task_types_biu, sp_tasks_ai, sp_tasks_bd, sp_tasks_biu |
| 82 | `082_team_member_notifications.sql` | ddl | table: sp_team_member_notifications; index: sp_team_member_notifications_i1, sp_team_member_notifications_i2, sp_team_member_notifications_i3; trigger: sp_team_member_notifications_biu |
| 83 | `083_approval_tables_and_triggers.sql` | ddl | table: sp_approval_types, sp_initiative_approval_chain, sp_initiative_approvals, sp_project_approval_chain, sp_project_approvals; trigger: sp_approval_types_biu, sp_initiative_approval_chain_bd, sp_initiative_approval_chain_biu, sp_initiative_approvals_bd, sp_initiative_approvals_biu, sp_project_approval_chain_biu, sp_project_approvals_bd, sp_project_approvals_biu; index: sp_initiative_approval_chain_i1, sp_initiative_approvals_i1, sp_project_approval_chain_i1, sp_project_approval_chain_i2, sp_project_approval_chain_i3, sp_project_approval_chain_i4, sp_project_approvals_i1, sp_project_approvals_i2, sp_project_approvals_i3, sp_project_approvals_i4 |
| 84 | `084_ai_summary_tables.sql` | ddl | table: sp_project_ai_summaries, sp_release_ai_summaries; index: sp_project_ai_summaries_i1, sp_project_ai_summaries_i2, sp_release_ai_summaries_i1, sp_release_ai_summaries_i2 |
| 85 | `085_comment_views.sql` | ddl | view: sp_init_focus_area_comments_v, sp_initiative_comments_v, sp_project_comments_v, sp_release_comments_v, sp_task_comments_v |
| 86 | `086_sp_documents_v_view.sql` | ddl | view: sp_documents_v |
| 87 | `087_sp_contributor_summary_body.sql` | ddl | package_body: sp_contributor_summary |
| 88 | `088_sp_release_timeline_package_body.sql` | ddl | package_body: sp_release_timeline |
| 89 | `089_sp_util_body.sql` | ddl | package_body: sp_util |
| 90 | `090_sp_approvals_body.sql` | ddl | package_body: sp_approvals |
| 91 | `091_sp_comment_util_body.sql` | ddl | package_body: sp_comment_util |
| 92 | `092_sp_summary_util_body.sql` | ddl | package_body: sp_summary_util |
| 93 | `093_seed_countries.sql` | dml | rows into sp_countries |
| 94 | `094_seed_nomenclature.sql` | dml | rows into sp_app_nomenclature |
| 95 | `095_seed_external_ticketing_systems.sql` | dml | rows into sp_external_ticketing_systems |
| 96 | `096_seed_resource_types.sql` | dml | rows into sp_resource_types |
| 97 | `097_seed_project_scales.sql` | dml | rows into sp_project_scales |
| 98 | `098_seed_project_statuses.sql` | dml | rows into sp_project_statuses |
| 99 | `099_seed_default_tags.sql` | dml | rows into sp_default_tags |
| 100 | `100_seed_project_priorities.sql` | dml | rows into sp_project_priorities |
| 101 | `101_seed_project_sizes.sql` | dml | rows into sp_project_sizes |
| 102 | `102_seed_activity_types.sql` | dml | rows into sp_activity_types |
| 103 | `103_seed_release_milestone_types.sql` | dml | rows into sp_release_milestone_types |
| 104 | `104_seed_settings_and_prompts.sql` | plsql_block |  |
| 105 | `105_seed_notifications.sql` | dml | rows into sp_notifications |
| 106 | `106_seed_competencies.sql` | dml | rows into sp_competencies |
| 107 | `107_seed_task_types_and_statuses.sql` | dml | rows into sp_task_statuses, sp_task_types |
| 108 | `108_create_sample_data.sql` | dml | rows into sp_activities, sp_areas, sp_initiative_links, sp_initiatives, sp_project_comments, sp_project_contributors, sp_project_links, sp_projects, sp_release_trains, sp_tasks, sp_team_members |
| 109 | `109_notifications_job.sql` | plsql_block |  |
| 110 | `110_sp_generate_ai_project_summaries_job.sql` | plsql_block |  |
| 111 | `111_seed_first_user.sql` | dml | rows into sp_team_members |
