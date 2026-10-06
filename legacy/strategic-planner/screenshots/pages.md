### APEX page 1: home

| Attribute | Value |
|---|---|
| Title | Our Strategic Planner home |
| Mode | NORMAL |
| Page group | Home |
| Authorization | none (any authenticated user) |
| EVS route | / |
| Source file | `application/pages/page_00001.sql` |

**Regions (10)**

| Seq | Region | Type | Parent | SQL objects |
|---|---|---|---|---|
| 1 | Notifications | NATIVE_DYNAMIC_CONTENT |  |  |
| 10 | Menubar | TMPL_THEME_42$CONTENT_ROW | Breadcrumb |  |
| 11 | Reviews Needed | NATIVE_DYNAMIC_CONTENT |  |  |
| 21 | Project Search | STATIC |  |  |
| 31 | My Activities | TMPL_THEME_42$CONTENT_ROW |  | sp_activities, sp_activity_types, sp_date_range_pct_comp, sp_initiatives, sp_projects, sp_team_members |
| 41 | My Initiatives | TMPL_THEME_42$CONTENT_ROW |  | sp_areas, sp_initiatives, sp_project_contributors, sp_projects, sp_team_members |
| 51 | My Projects | TMPL_THEME_42$CONTENT_ROW |  | sp_activities, sp_favorites, sp_initiatives, sp_project_priorities, sp_projects, sp_release_trains, sp_tasks, sp_team_members |
| 61 | My Open Releases | TMPL_THEME_42$CONTENT_ROW |  | sp_activities, sp_projects, sp_release_milestones, sp_release_trains, sp_tasks, sp_team_members |
| 71 | Recently Changed Projects | NATIVE_SQL_REPORT |  | sp_initiatives, sp_project_priorities, sp_projects, sp_release_trains, sp_team_members |
| 75 | Breadcrumb | NATIVE_BREADCRUMB |  |  |

**Items (10, 9 hidden)**

| Item | Display as | Prompt | Region | Required |
|---|---|---|---|---|
| P1_SEARCH | NATIVE_TEXT_FIELD |  | Project Search |  |

**Dynamic actions (7)**

| Name | Event | Actions |
|---|---|---|
| refresh on dialog close | apexafterclosedialog | NATIVE_REFRESH |
| on my proj dc refresh | apexafterclosedialog | NATIVE_REFRESH, NATIVE_REFRESH |
| on Releases after edit | apexafterclosedialog | NATIVE_REFRESH |
| toggle favorite | change | NATIVE_EXECUTE_PLSQL_CODE, NATIVE_JAVASCRIPT_CODE |
| dismiss notif | change | NATIVE_EXECUTE_PLSQL_CODE, NATIVE_JAVASCRIPT_CODE |
| refresh my curr activity on dc | apexafterclosedialog | NATIVE_REFRESH |
| initiative refresh on dialog close | apexafterclosedialog | NATIVE_REFRESH |


### APEX page 21: Initiatives

| Attribute | Value |
|---|---|
| Title | Initiatives |
| Mode | NORMAL |
| Page group | Initiatives |
| Authorization | none (any authenticated user) |
| EVS route | /programs |
| Source file | `application/pages/page_00021.sql` |

**Regions (5)**

| Seq | Region | Type | Parent | SQL objects |
|---|---|---|---|---|
| 2 | items | STATIC |  |  |
| 10 | Menubar | TMPL_THEME_42$CONTENT_ROW | Breadcrumb |  |
| 20 | Initiatives | TMPL_THEME_42$CONTENT_ROW |  | sp_areas, sp_initiatives, sp_projects, sp_team_members |
| 20 | Faceted Search | NATIVE_FACETED_SEARCH |  |  |
| 30 | Breadcrumb | NATIVE_BREADCRUMB |  |  |

**Items (9, 1 hidden)**

| Item | Display as | Prompt | Region | Required |
|---|---|---|---|---|
| P21_ORDER_BY | NATIVE_SELECT_LIST | Order By | items | yes |
| P21_SEARCH | NATIVE_SEARCH | Search | Faceted Search |  |
| P21_FOCUS_AREA | NATIVE_CHECKBOX | Area | Faceted Search |  |
| P21_SPONSOR | NATIVE_CHECKBOX | Owner | Faceted Search |  |
| P21_TAGS | NATIVE_CHECKBOX | Tags | Faceted Search |  |
| P21_HIDDEN_BY_DEFAULT | NATIVE_CHECKBOX | Default Display | Faceted Search |  |
| P21_CREATED_MONTH | NATIVE_CHECKBOX | Created Month | Faceted Search |  |
| P21_UPDATED_MONTH | NATIVE_CHECKBOX | Updated Month | Faceted Search |  |

**Dynamic actions (4)**

| Name | Event | Actions |
|---|---|---|
| dialog close | apexafterclosedialog |  |
| refresh on dialog close | apexafterclosedialog | NATIVE_REFRESH |
| refresh bc | apexafterclosedialog | NATIVE_REFRESH, NATIVE_REFRESH |
| refresh on DC | apexafterclosedialog | NATIVE_REFRESH, NATIVE_REFRESH |


### APEX page 3: Project Details

| Attribute | Value |
|---|---|
| Title | &P3_PROJECT_NAME. |
| Mode | NORMAL |
| Page group | Projects |
| Authorization | none (any authenticated user) |
| EVS route | /projects/:p2 |
| Source file | `application/pages/page_00003.sql` |

**Regions (34)**

| Seq | Region | Type | Parent | SQL objects |
|---|---|---|---|---|
| 0 | Breadcrumb | NATIVE_BREADCRUMB |  |  |
| 10 | Comments | STATIC |  |  |
| 10 | Comment Form | STATIC | Comments |  |
| 10 | Review Needed | STATIC |  |  |
| 10 | Menubar | TMPL_THEME_42$CONTENT_ROW | Breadcrumb |  |
| 10 | contributor button container | STATIC | contributors content |  |
| 10 | milestone button container | STATIC | milestone content |  |
| 10 | review button container | STATIC | review content |  |
| 10 | Archived Project | STATIC |  |  |
| 20 | Comments Report | NATIVE_SQL_REPORT | Comments | sp_project_comments_v, sp_team_members |
| 20 | Duplicate of: | STATIC |  |  |
| 20 | Clarification Requested for Review | STATIC |  |  |
| 20 | task content | NATIVE_IR | Tasks | sp_task_comments, sp_task_documents, sp_task_links, sp_task_statuses, sp_task_types, sp_tasks, sp_team_members |
| 30 | RDS | NATIVE_DISPLAY_SELECTOR |  |  |
| 40 | Project Details | NATIVE_SQL_REPORT |  | sp_areas, sp_favorites, sp_initiative_focus_areas, sp_initiatives, sp_project_priorities, sp_project_scales, sp_project_statuses, sp_projects, sp_release_trains, sp_team_members |
| 50 | Activity | STATIC |  |  |
| 60 | Description | STATIC |  |  |
| 70 | Contributors | STATIC |  |  |
| 80 | review content | NATIVE_IR | Reviews | sp_task_comments, sp_task_documents, sp_task_links, sp_task_statuses, sp_task_types, sp_tasks, sp_team_members |
| 80 | contributors content | NATIVE_IR | Contributors | sp_project_comments, sp_project_contributors, sp_project_documents, sp_project_links, sp_resource_types, sp_team_members |
| 90 | Milestones | STATIC |  |  |
| 90 | milestone content | NATIVE_IR | Milestones | sp_task_comments, sp_task_documents, sp_task_links, sp_task_statuses, sp_task_types, sp_tasks, sp_team_members |
| 100 | Reviews | STATIC |  |  |
| 120 | Tasks | STATIC |  |  |
| 120 | description content | NATIVE_DYNAMIC_CONTENT | Description |  |
| 121 | activity content | TMPL_THEME_42$CONTENT_ROW | Activity | sp_activities, sp_activity_types, sp_date_range_pct_comp, sp_initiatives, sp_projects, sp_team_members |
| 130 | Links | NATIVE_IR |  | sp_project_links, sp_task_links, sp_task_types, sp_tasks |
| 140 | Documents | NATIVE_IR |  | sp_documents_v |
| 140 | footer | STATIC |  |  |
| 160 | Related | NATIVE_IR |  | sp_project_related, sp_projects |
| 165 | Approvals | TMPL_THEME_42$CONTENT_ROW |  | sp_approval_types, sp_project_approval_chain, sp_project_approvals, sp_team_members |
| 500 | Additional Attriubtes | NATIVE_SQL_REPORT | footer | sp_areas, sp_favorites, sp_initiatives, sp_proj_interactions_log, sp_project_groups, sp_project_history, sp_projects, sp_task_history, sp_task_types, sp_tasks, sp_team_members |
| 1102 | description button container | STATIC | Description |  |
| 1111 | Activity Filters | STATIC | Activity |  |

**Interactive Reports (7)**

| Region | Columns | Saved reports | Detail link |
|---|---|---|---|
| review content | 15 | 1 | f?p=&APP_ID.:509:&SESSION.::&DEBUG.:RP,509:P509_ID:#ID# |
| milestone content | 14 | 1 | f?p=&APP_ID.:508:&SESSION.::&DEBUG.:RP,508:P508_ID:#ID# |
| Related | 10 | 1 | f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP,10:P10_ID:#RELATION_ID# |
| contributors content | 9 | 1 | f?p=&APP_ID.:9:&SESSION.::&DEBUG.:RP,9:P9_ID:#ID# |
| task content | 16 | 1 | f?p=&APP_ID.:501:&SESSION.::&DEBUG.:RP,501:P501_ID:#ID# |
| Links | 10 | 1 | f?p=&APP_ID.:#EDIT_PAGE#:&SESSION.::&DEBUG.:#EDIT_PAGE#:P#EDIT_PAGE#_ID:#ID# |
| Documents | 15 | 1 | f?p=&APP_ID.:#EDIT_PAGE#:&SESSION.::&DEBUG.:#EDIT_PAGE#:P#EDIT_PAGE#_ID:#DOCUMENT_ID###DOCUMENT_ID# |

**Items (22, 13 hidden)**

| Item | Display as | Prompt | Region | Required |
|---|---|---|---|---|
| P3_COMMENT | NATIVE_RICH_TEXT_EDITOR |  Comment | Comment Form |  |
| P3_CONTRIBUTOR | NATIVE_POPUP_LOV | Add Contributor | Contributors |  |
| P3_LINK_NAME | NATIVE_TEXT_FIELD | Link Name | Links |  |
| P3_RELATED_PROJECT_ID | NATIVE_SELECT_ONE | Related Project | Related |  |
| P3_CONTRIBUTOR_ROLE | NATIVE_SELECT_LIST | Role | Contributors |  |
| P3_LINK | NATIVE_TEXT_FIELD | Link URL | Links |  |
| P3_INCLUDE_FUTURE | NATIVE_YES_NO | Include Future | Activity Filters |  |
| P3_INCLUDE_PAST | NATIVE_YES_NO | Include Past | Activity Filters |  |
| P3_PRIVATE_YN | NATIVE_SINGLE_CHECKBOX | This is a private comment | Comment Form |  |

**Processes (1)**

| Process | Type | Point | PL/SQL objects |
|---|---|---|---|
| log | NATIVE_PLSQL | BEFORE_HEADER | sp_log |

**Dynamic actions (26)**

| Name | Event | Actions |
|---|---|---|
| Add Comment | click | NATIVE_DISABLE, NATIVE_EXECUTE_PLSQL_CODE, NATIVE_REFRESH, NATIVE_JAVASCRIPT_CODE, NATIVE_ENABLE |
| rpt dialog close | apexafterclosedialog | NATIVE_REFRESH |
| doc refresh dialog close | apexafterclosedialog | NATIVE_REFRESH |
| milestone refresh dialog close | apexafterclosedialog | NATIVE_REFRESH |
| milestone reviews dialog close | apexafterclosedialog | NATIVE_REFRESH |
| add link | click | NATIVE_ALERT, NATIVE_EXECUTE_PLSQL_CODE, NATIVE_REFRESH, NATIVE_JAVASCRIPT_CODE |
| doc refresh on dialog close | apexafterclosedialog | NATIVE_REFRESH |
| comments refresh on dialog close | apexafterclosedialog | NATIVE_REFRESH |
| add related | click | NATIVE_ALERT, NATIVE_EXECUTE_PLSQL_CODE, NATIVE_CLEAR, NATIVE_REFRESH |
| refresh related | apexafterclosedialog | NATIVE_REFRESH |
| Remove Tag | click | NATIVE_SET_VALUE, NATIVE_EXECUTE_PLSQL_CODE |
| show future activity da | change | NATIVE_EXECUTE_PLSQL_CODE, NATIVE_REFRESH |
| show activity on dc on add | apexafterclosedialog | NATIVE_REFRESH |
| refresh description | apexafterclosedialog | NATIVE_REFRESH |
| refresh activity rpt on dc | apexafterclosedialog | NATIVE_REFRESH |
| refresh tasks | apexafterclosedialog | NATIVE_REFRESH |
| show past activity | change | NATIVE_EXECUTE_PLSQL_CODE, NATIVE_REFRESH |
| refresh on change project | apexafterclosedialog | NATIVE_REFRESH |
| refresh on review project | apexafterclosedialog | NATIVE_REFRESH |
| on edit description dialog close | apexafterclosedialog | NATIVE_REFRESH |
| refresh on dialog closed bc | apexafterclosedialog | NATIVE_REFRESH, NATIVE_REFRESH |
| add contributor | click | NATIVE_EXECUTE_PLSQL_CODE, NATIVE_REFRESH, NATIVE_JAVASCRIPT_CODE |
| refresh cont on dc | apexafterclosedialog | NATIVE_REFRESH |
| refresh after review | apexafterclosedialog | NATIVE_SET_VALUE, NATIVE_REFRESH, NATIVE_REFRESH, NATIVE_HIDE |
| refresh after more info | apexafterclosedialog | NATIVE_SET_VALUE, NATIVE_REFRESH, NATIVE_REFRESH, NATIVE_HIDE |
| comment links in new tab | ready | NATIVE_JAVASCRIPT_CODE |


### APEX page 74: People

| Attribute | Value |
|---|---|
| Title | People |
| Mode | NORMAL |
| Page group | Users |
| Authorization | none (any authenticated user) |
| EVS route | /workforce |
| Source file | `application/pages/page_00074.sql` |

**Regions (5)**

| Seq | Region | Type | Parent | SQL objects |
|---|---|---|---|---|
| 3 | filters | STATIC |  |  |
| 10 | Menubar | TMPL_THEME_42$CONTENT_ROW | Breadcrumb |  |
| 30 | Faceted Search | NATIVE_FACETED_SEARCH |  |  |
| 33 | Users  | TMPL_THEME_42$CONTENT_ROW |  | sp_activities, sp_areas, sp_countries, sp_group_members, sp_groups, sp_initiative_comments, sp_initiative_documents, sp_initiatives, sp_project_comments, sp_project_comments_emails, sp_project_documents, sp_projects, sp_release_comments, sp_release_documents, sp_task_comments, sp_task_documents, sp_task_statuses, sp_task_types, sp_tasks, sp_team_members |
| 40 | Breadcrumb | NATIVE_BREADCRUMB |  |  |

**Items (14, 0 hidden)**

| Item | Display as | Prompt | Region | Required |
|---|---|---|---|---|
| P74_ORDER_BY | NATIVE_SELECT_LIST | Order By | filters | yes |
| P74_SEARCH | NATIVE_SEARCH | Search | Faceted Search |  |
| P74_APP_ROLE | NATIVE_CHECKBOX | App Role | Faceted Search |  |
| P74_COMPETENCIES | NATIVE_CHECKBOX | Competencies | Faceted Search |  |
| P74_TAGS | NATIVE_CHECKBOX | Tags | Faceted Search |  |
| P74_HAS_OPEN_REVIEWS | NATIVE_CHECKBOX | Open Reviews | Faceted Search |  |
| P74_GROUP_MEMBERSHIP | NATIVE_CHECKBOX | Groups | Faceted Search |  |
| P74_REGION | NATIVE_CHECKBOX | Region | Faceted Search |  |
| P74_COUNTRY | NATIVE_CHECKBOX | Country | Faceted Search |  |
| P74_HAS_ACTIVITIES | NATIVE_CHECKBOX | Current or Future Activities | Faceted Search |  |
| P74_EMAIL_DOMAIN | NATIVE_CHECKBOX | Email Domain | Faceted Search |  |
| P74_PROJECT_LEAD | NATIVE_CHECKBOX | Project Owner | Faceted Search |  |
| P74_HAS_PROFILE_PHOTO | NATIVE_CHECKBOX | Has Profile Photo | Faceted Search |  |
| P74_HAS_SCREEN_NAME | NATIVE_CHECKBOX | Has Screen Name | Faceted Search |  |

**Processes (1)**

| Process | Type | Point | PL/SQL objects |
|---|---|---|---|
| sync roles | NATIVE_PLSQL | BEFORE_HEADER | sp_util |

**Dynamic actions (2)**

| Name | Event | Actions |
|---|---|---|
| DC | apexafterclosedialog | NATIVE_REFRESH, NATIVE_REFRESH |
| refresh on dialog closed | apexafterclosedialog | NATIVE_REFRESH, NATIVE_REFRESH |


### APEX page 4: Kanban Board

| Attribute | Value |
|---|---|
| Title | Kanban Board |
| Mode | NORMAL |
| Page group |  |
| Authorization | none (any authenticated user) |
| EVS route | /schedule |
| Source file | `application/pages/page_00004.sql` |

**Regions (5)**

| Seq | Region | Type | Parent | SQL objects |
|---|---|---|---|---|
| 30 | Kanban Board | NATIVE_SQL_REPORT |  | sp_initiative_focus_areas, sp_project_priorities, sp_project_sizes, sp_projects, sp_release_trains, sp_team_members |
| 40 | do not drop - Search Results | NATIVE_SQL_REPORT |  | sp_initiative_focus_areas, sp_project_priorities, sp_project_sizes, sp_projects, sp_release_trains, sp_team_members |
| 90 | Faceted Search | NATIVE_FACETED_SEARCH |  |  |
| 100 | Menubar | TMPL_THEME_42$CONTENT_ROW | Breadcrumb |  |
| 120 | Breadcrumb | NATIVE_BREADCRUMB |  |  |

**Items (20, 10 hidden)**

| Item | Display as | Prompt | Region | Required |
|---|---|---|---|---|
| P4_KB_SEARCH | NATIVE_SEARCH | Kb Search | Faceted Search |  |
| P4_USER | NATIVE_POPUP_LOV | User | Faceted Search |  |
| P4_KB_PCT_COMPLETE | NATIVE_CHECKBOX | % Complete | Faceted Search |  |
| P4_KB_RELEASE | NATIVE_CHECKBOX | Release | Faceted Search |  |
| P4_KB_NAME | NATIVE_CHECKBOX | Owner | Faceted Search |  |
| P4_KB_FOCUS_AREA | NATIVE_CHECKBOX | Focus Area | Faceted Search |  |
| P4_KB_TAGS | NATIVE_CHECKBOX | Tags | Faceted Search |  |
| P4_KB_COLUMN_ID | NATIVE_CHECKBOX | Display | Faceted Search |  |
| P4_KB_PRIORITY | NATIVE_CHECKBOX | Priority | Faceted Search |  |
| P4_KB_PROJECT_SIZE | NATIVE_CHECKBOX | Project Size | Faceted Search |  |

**Processes (1)**

| Process | Type | Point | PL/SQL objects |
|---|---|---|---|
| set Items | NATIVE_PLSQL | BEFORE_HEADER | sp_initiatives |

**Dynamic actions (5)**

| Name | Event | Actions |
|---|---|---|
| Change Facets | NATIVE_FACETED_SEARCH\|REGION TYPE\|facetschange | NATIVE_REFRESH |
| Edit Project Dialog Close | apexafterclosedialog | NATIVE_REFRESH |
| Add Project Dialog Close | apexafterclosedialog | NATIVE_REFRESH |
| Drag & Drop | apexafterrefresh | NATIVE_JAVASCRIPT_CODE |
| Drop Item | change | NATIVE_EXECUTE_PLSQL_CODE, NATIVE_JAVASCRIPT_CODE |


### APEX page 10000: Administration

| Attribute | Value |
|---|---|
| Title | Administration |
| Mode | NORMAL |
| Page group | Administration |
| Authorization | Administration Rights |
| EVS route | /admin |
| Source file | `application/pages/page_10000.sql` |

**Regions (19)**

| Seq | Region | Type | Parent | SQL objects |
|---|---|---|---|---|
| 10 | ACL Information | NATIVE_PLSQL | Access Control |  |
| 10 | Report | NATIVE_SQL_REPORT | Feedback |  |
| 20 | Access Control Content | STATIC | Column 1 |  |
| 20 | Access Control Actions | NATIVE_LIST | Access Control |  |
| 30 | Administration | NATIVE_BREADCRUMB |  |  |
| 30 | Access Control | STATIC | Access Control Content |  |
| 30 | Warning | NATIVE_PLSQL | Access Control |  |
| 30 | Feedback | STATIC | Column 1 |  |
| 50 | User Counts Report | NATIVE_SQL_REPORT | Access Control |  |
| 65 | Look Up Values | NATIVE_LIST | Column 2 |  |
| 75 | Approval Options | NATIVE_LIST | Column 2 |  |
| 80 | Monitoring | NATIVE_LIST | Column 1 |  |
| 85 | Configuration | NATIVE_LIST | Column 2 |  |
| 90 | Project Interactions | NATIVE_LIST | Column 1 |  |
| 100 | Feedback | NATIVE_LIST | Feedback |  |
| 100 | Utilities | NATIVE_LIST | Column 1 |  |
| 110 | Notifications | NATIVE_LIST | Column 1 |  |
| 180 | Column 1 | STATIC |  |  |
| 190 | Column 2 | STATIC |  |  |

**Items (17, 17 hidden)**

| Item | Display as | Prompt | Region | Required |
|---|---|---|---|---|

**Dynamic actions (1)**

| Name | Event | Actions |
|---|---|---|
| Refresh Report | apexafterclosedialog | NATIVE_REFRESH |


### APEX page 86: Projects

| Attribute | Value |
|---|---|
| Title | Projects |
| Mode | NORMAL |
| Page group | Reporting |
| Authorization | none (any authenticated user) |
| EVS route | /projects |
| Source file | `application/pages/page_00086.sql` |

**Regions (3)**

| Seq | Region | Type | Parent | SQL objects |
|---|---|---|---|---|
| 10 | Projects Interactive Report | NATIVE_IR |  | sp_activities, sp_approval_types, sp_areas, sp_favorites, sp_initiative_focus_areas, sp_initiatives, sp_project_approvals, sp_project_comments, sp_project_groups, sp_project_priorities, sp_project_scales, sp_project_sizes, sp_project_statuses, sp_projects, sp_release_trains, sp_task_types, sp_tasks, sp_team_members |
| 10 | Menubar | TMPL_THEME_42$CONTENT_ROW | Breadcrumb |  |
| 20 | Breadcrumb | NATIVE_BREADCRUMB |  |  |

**Interactive Reports (1)**

| Region | Columns | Saved reports | Detail link |
|---|---|---|---|
| Projects Interactive Report | 50 | 3 | f?p=&APP_ID.:24:&SESSION.::&DEBUG.:RP,24:P24_ID:#PROJECT_ID# |

**Items (0, 0 hidden)**

| Item | Display as | Prompt | Region | Required |
|---|---|---|---|---|

**Dynamic actions (2)**

| Name | Event | Actions |
|---|---|---|
| refresh on dc | apexafterclosedialog | NATIVE_REFRESH |
| refresh on dc from report | apexafterclosedialog | NATIVE_REFRESH |


### APEX page 161: Cumulative Flow

| Attribute | Value |
|---|---|
| Title | Cumulative Flow |
| Mode | MODAL |
| Page group |  |
| Authorization | none (any authenticated user) |
| EVS route | /financial |
| Source file | `application/pages/page_00161.sql` |

**Regions (1)**

| Seq | Region | Type | Parent | SQL objects |
|---|---|---|---|---|
| 20 | Cumulative Flow | NATIVE_JET_CHART |  | sp_project_history, sp_projects |

**Charts (1)**

| Region | Type | Series | SQL objects |
|---|---|---|---|
| Cumulative Flow | area | Series 1 | sp_project_history, sp_projects |

**Items (4, 1 hidden)**

| Item | Display as | Prompt | Region | Required |
|---|---|---|---|---|
| P161_RESOLUTION | NATIVE_SELECT_LIST | Resolution | Cumulative Flow |  |
| P161_SCOPE | NATIVE_SELECT_LIST | Timescale | Cumulative Flow |  |
| P161_FOCUS_AREA | NATIVE_SELECT_LIST | Focus Area | Cumulative Flow |  |

**Dynamic actions (1)**

| Name | Event | Actions |
|---|---|---|
| Change Resolution | change | NATIVE_REFRESH |

