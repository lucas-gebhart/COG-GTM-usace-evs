# EVS Public Data Report: USACE sources for the Enterprise Visibility Suite demo

Research only. All fetches made 2026-10-06 (UTC) from a Devin VM with curl/python. "Verified" means the endpoint returned a 2xx with parseable data during this session and a sample is in `data_samples.zip`. Nothing was built, no repos or PRs created.

## 1. Summary table

| # | Dataset | Source URL | Format | Live/static | Update cadence | Verified | Recommended EVS use |
|---|---|---|---|---|---|---|---|
| A1 | LPMS Lock Status Report (hydrology, queue, delay, stoppage flag, NTNI links, coordinates) | `https://ndc.ops.usace.army.mil/ords/lpms/json/lock_status_report?in_river_codes=ALL` | JSON | Live | Site says every 15 min; `entryDatetime` values were 04:00 to 08:00 same day | Y (77 locks) | Primary feed for the R/Y/G lock table and map |
| A2 | LPMS Lock Delay (all locks, 4h and 24h avg delay) | `https://ndc.ops.usace.army.mil/ords/lpms/lock_delay_json` | JSON (malformed, see risks) | Live | Rolling 4h/24h | Y (192 locks) | Yellow signal; covers 192 locks vs 77 in A1 |
| A3 | LPMS Stall/Stoppage (closures, scheduled vs unscheduled, traffic stopped) | `https://ndc.ops.usace.army.mil/ords/lpms/stall_stoppage_json[?begin_date=DDMMYYYY&end_date=DDMMYYYY]` | JSON | Live | `refreshDate` stamped at request time | Y (22 active) | Red signal |
| A4 | LPMS Lock Queue (vessels waiting, per lock) | `.../ords/lpms/json/lock_queue_json?in_river=OH&in_lock=79` and `.../ords/lockqueue_xml?in_river=GI&in_lock=01` | JSON / XML | Live | Site says every 15 min | Y (619 rows OH79) | Drill-down panel per lock |
| A5 | LPMS Traffic Report (lockages, barges, hazmat) | `.../ords/lpms/json/traffic_report?in_river=OH&in_lock=79` | JSON | Live | 30-day window | Y (609 rows) | Throughput charts |
| A6 | LPMS River at a Glance | `.../ords/lpms/json/river_at_a_glance/OH/0/1000` | JSON | Live | 24h window | Y (161 rows) | River-level activity strip |
| A7 | LPMS Monthly Tonnage by commodity | `.../ords/lpms/json/monthly_tons_report?in_river_name=OH&in_lock=79&in_month_year=022026` | JSON | Static monthly | Daily 10 am ET | Y (8 commodity rows) | Value-to-public tonnage KPI |
| A8 | LPMS lookups (river codes, lock numbers, chambers, stoppage reasons, EROCs) | `.../ords/lpms/lookups/{river_codes,lock_numbers,chamber_numbers,stoppage_reason_codes,erocs,hydrology_reading_types}` | CSV (despite `.json` module name) | Static | Rare | Y (46 rivers, 194 locks, 1,791 chambers, 36 reason codes); `hydrology_weather_codes` returned HTTP 555 twice | Reference tables, dimension data |
| A9 | LPMS OpenAPI catalog | `https://ndc.ops.usace.army.mil/ords/lpms/open-api-catalog/` and `/json/`, `/lookups/` | Swagger 2.0 JSON | Static | n/a | Y | Codegen for the API layer |
| A10 | NDC Lock characteristics GIS layer (lat/lon, river mile, chamber dims, lift, year opened, district) | `https://services7.arcgis.com/n1YM8pTrFmm7L4hs/ArcGIS/rest/services/Locks/FeatureServer/0/query?where=1=1&outFields=*&f=geojson` | GeoJSON / Esri JSON | Static | Survey-based | Y (234 chamber features) | Authoritative lock lat/lon and attributes; join key RIVERCD+LOCKCD |
| A11 | District "Lock Status" ArcGIS layer (GIWW/Louisiana locks) | `https://services8.arcgis.com/auEgdZ2hucgD0iTE/arcgis/rest/services/Lock_Status/FeatureServer/1` | Esri JSON | Live | `EditDate` same day | Y (16 locks) | Supplemental status for Gulf locks not in LPMS A1 |
| A12 | NTNI notices (Notice to Navigation Interests) | `https://ndc.ops.usace.army.mil/ords/ntni/print_nav_notice?in_nav_notice_number=214992&in_title_formatting=UB` (links embedded in A1 `ntniNoticesLinks`) | HTML | Live | Per notice | Y (notice 214992, Olmsted closure) | Closure text for lock detail; no RSS/JSON found |
| A13 | USGS NWIS Instantaneous Values | `https://waterservices.usgs.gov/nwis/iv/?format=json&sites=03303280,03294500&parameterCd=00060,00065` | JSON | Live | 15 min to hourly | Y (5 series) | Stage/flow sparkline and high-water signal |
| A14 | USGS OGC API (new) latest continuous | `https://api.waterdata.usgs.gov/ogcapi/v0/collections/latest-continuous/items?monitoring_location_id=USGS-03303280` | GeoJSON | Live | Same | Y | Modern replacement for A13 |
| A15 | NOAA NWPS gauge + stage/forecast | `https://api.water.noaa.gov/nwps/v1/gauges/CNNI3` and `/gauges/CNNI3/stageflow` | JSON | Live | Hourly obs, forecast ~2x daily | Y (2,818 obs, 20 fcst) | Flood category (action/minor/moderate/major) drives Yellow/Red |
| B1 | SRP program figures (HEC official page, history timeline, sites list) | `https://www.hec.usace.army.mil/sustainablerivers/` (+ `/history/`, `/sites/`, `/sites/emerging/`) | HTML | Static | Annual | Y | SRP KPIs and timeline |
| B2 | SRP figures (TNC) | `https://www.nature.org/en-us/about-us/where-we-work/united-states/sustainable-rivers-project/`, newsroom 2026, 2019 PDF, RTI CBA report PDF | HTML / PDF | Static | Annual | Y | Growth story and economic value |
| C1 | National Inventory of Dams full export | `https://nid.sec.usace.army.mil/api/nation/csv` | CSV | Static | "Data Last Updated: 2026-10-5" header | Y (92,766 rows, 84 fields) | Dam map, USACE-owned subset (753 rows) |
| C2 | Civil Works budget Justification Sheets and Press Books | `https://usace.contentdm.oclc.org/utils/getfile/collection/p16021coll6/id/2565` (FY26 O&M) and siblings | PDF | Static | Annual | Y (75 pages, 399 project rows parsed, business-line amounts) | Seed for synthetic CEFMS/P2 financials; budget by business line |
| C3 | USACE hydropower and recreation headline stats | `usace.army.mil/Missions/Civil-Works/Hydropower/` and `/Recreation/` | HTML | Static | Ad hoc | Via Wayback only (live site returns 403 to curl) | KPI tiles |
| C4 | WCSC Waterborne Commerce | `https://ndc.ops.usace.army.mil/wcsc/webpub/` | HTML/PDF | Static | Annual | Partial (page loads; publications behind JS) | Use A7 tonnage instead |
| C5 | EIA electricity API (hydro generation) | `https://api.eia.gov/v2/...` | JSON | Static | Monthly | N (403 from this VM in 0.03 s, network policy) | Needs API key and egress; optional |
| D | CEFMS, P2, EMS, CMP, BUILDER | No public endpoints | n/a | n/a | n/a | Confirmed not public | Synthetic data using vocabulary in section 5 |

Screenshots (in `data_samples.zip/shots/`): `corpslocks_home.png`, `corpslocks_lock_status.png`, `corpslocks_river_glance.png`, `corpslocks_data_web_services.png`, `nid_home.png`, `tnc_srp.png`. `iwr_srp.png`, `iwr_ndc.png`, `usace_cw_budget.png` show the Akamai "Access Denied" page returned to the VM browser for `*.usace.army.mil` and `iwr.usace.army.mil` (see risks).

## 2. Section A: Lock status by river system

### 2.1 Where the data lives
`corpslocks.usace.army.mil` resolves to the LPMS Oracle APEX app at `https://ndc.ops.usace.army.mil/ords/r/lpms/corps-locks/home`. The "Data Web Services" page documents the public ORDS endpoints below and links Swagger docs. No authentication, no API key. HTTP headers set a 600 s `session` cookie and send `Access-Control-Allow-*` headers (CORS works for browser clients, but server-side polling is still recommended). The page states Lock Status and Lock Queue are "updated every 15 minutes" and River at a Glance "every 30 minutes"; Monthly Tonnage "daily at 10 am ET". No rate limit is documented; 9 calls inside 60 s all returned 200 in this session.

### 2.2 Endpoint list (all `https://ndc.ops.usace.army.mil/ords/...`)
| Endpoint | Params | Returns | Sample file |
|---|---|---|---|
| `lpms/json/lock_status_report` | `in_river_codes=ALL` or `OH` or `CH:AG` | array of lock status objects | `lpms/lock_status_report_ALL.json` |
| `lpms/lock_status_report_json` | `in_river_code=CH` | legacy shape `{riverName, locks[]}` (returned empty in this session) | `lpms/legacy_lock_status_ALL.json` |
| `lpms/lock_delay_json` | none | array `{eroc, riverCode, lockNumber, fourHourAverageDelayInMinutes, twentyFourHourAverageDelayInMinutes}` | `lpms/lock_delay.json` (raw), `lock_delay_fixed.json` |
| `lpms/stall_stoppage_json` | optional `begin_date`, `end_date` (DDMMYYYY) | array of stoppages | `lpms/stall_stoppage.json`, `stall_stoppage_range.json` |
| `lpms/json/lock_queue_json` | `in_river`, `in_lock` | vessel queue, 30 days | `lpms/lock_queue_OH79.json` |
| `lockqueue_xml` | `in_river`, `in_lock` | same, XML | `lpms/lockqueue_GI01.xml` |
| `lpms/json/traffic_report` | `in_river`, `in_lock` | lockages with timestamps | `lpms/traffic_OH79.json` |
| `lpms/json/river_at_a_glance/{river}/{begin_mile}/{end_mile}` | path | vessels past 24h with riverMile and MMSI | `lpms/river_at_a_glance_OH.json` |
| `lpms/json/monthly_tons_report` | `in_river_name`, `in_lock`, `in_month_year=MMYYYY` | tons by commodity | `lpms/monthly_tons_OH79.json` |
| `lpms/lookups/river_codes`, `lock_numbers`, `chamber_numbers`, `stoppage_reason_codes`, `erocs`, `hydrology_reading_types` | none | CSV | `lpms/lookup_*.json` |
| `lpms/open-api-catalog/`, `/json/`, `/lookups/` | none | Swagger 2.0 | `lpms/openapi_*.json` |
| `lpms/uscg/json` | none | HTTP 401 (restricted) | n/a |

### 2.3 Sample payloads
Lock Status (one of 77):
```json
{"eroc":"H2","riverCode":"OH","lockNo":"79","lockName":"OLMSTED LOCKS AND DAM","hoursOfOperation":"24-7/365","weatherCode":"FA","entryDatetime":"2026-10-06T08:00:00","upperGauge":"22.8","lowerGauge":"21.5","damType1":"Tainter","damValue1":"40","damType2":"Needles","damValue2":"0","damType3":"Wickets","damValue3":"0","damCondition":40,"airTemparture":49,"precipitation":"   0.00","totalPendingArrivals":10,"totalLocking":0,"totalLockedUp24Hours":10,"totalLockedDown24Hours":10,"average4HourDelay":"     172","notes":"Refreshed On: 06-OCT-2026\r\n----\r\nDAM UP, Locking River Chamber Only\r\nOct 5 - Nov 13 we will be locking land chamber only.","activeStallStoppages":"<a href='/ords/lpms/json/r/lpms/corps-locks/active-stall-stoppages?...'>YES</a>","ntniNoticesLinks":"<a href='https://ndc.ops.usace.army.mil/ords/ntni/print_nav_notice?in_nav_notice_number=214992...'>214992</a> , <a ...>215111</a> ","latitude":-89.0637580004307,"longitude":37.1836120000946}
```
Stall/Stoppage (one of 22 active):
```json
{"eroc":"B6","riverCode":"MI","lockNumber":"51","chamberNumber":"1","beginStopDate":"06/10/2015 00:00:00 CDT","endStopDate":"12/31/2125 23:59:00 CDT","isScheduled":"Yes","reasonCode":"Closed ( unmanned shift)","numHwCycles":null,"year":2015,"refreshDate":"10/06/2026 14:26:17 GMT","trafficStopped":"Y"}
```
Lock Delay (one of 192): `{"eroc":"H4","riverCode":"AG","lockNumber":"42","fourHourAverageDelayInMinutes":"N/A","twentyFourHourAverageDelayInMinutes":"4"}`

Traffic (one of 609 at OH79): `{"vesselNo":"1272385","vesselName":"A B YORK","arrivalDate":"09/14/26 10:15","solDate":"09/15/26 01:20","endOfLockage":"09/15/26 02:28","timezone":"CST","numBarges":15,"numberProcessed":15,"hazardCode":"N"}`

NDC Locks GIS feature (one of 234): fields `RIVERCD, LOCKCD, CHMBCD, NOCHMB, PMSDATA, NAVSTR, PMSNAME, STATUS, RIVER, RIVERMI, BANK, LIFT, LENGTH, WIDTH, YEAROPEN, GATETYPE, CHNDPTHA, DIVISION, DISTRICT, STATE, TOWN, OWNER1, OPER1` plus point geometry.

### 2.4 Field dictionary (Lock Status Report)
| Field | Meaning | Notes |
|---|---|---|
| `eroc` | District code (e.g. H2 Louisville, B5 Rock Island, H4 Pittsburgh, H7 Nashville, H1 Huntington) | Lookup `lpms/lookups/erocs` |
| `riverCode`, `lockNo` | 2-char river code + 2-char lock number; join key to GIS `RIVERCD`+`LOCKCD` | 77/77 status rows matched; 190/192 delay rows matched (misses: SM-01, WI-11) |
| `entryDatetime` | Operator entry time of this hydrology record (local, no tz) | Use as "as-of" |
| `upperGauge`, `lowerGauge` | Pool and tailwater gauge readings (ft) | strings |
| `damType1..4`, `damValue1..4`, `damCondition` | Gate type and opening (Tainter, Roller, Needles, Wickets) | |
| `weatherCode` | CL, FA, FG, PC observed | lookup endpoint failing (555) |
| `totalPendingArrivals` | Vessels waiting | queue depth |
| `totalLocking` | Vessels in chamber now | |
| `totalLockedUp24Hours`, `totalLockedDown24Hours` | Lockages last 24h | throughput |
| `average4HourDelay` | Minutes, string with padding | parse int |
| `iceCover`, `iceType`, `iceThickness`, `iceStructure`, `iceExtent` | Winter fields | mostly null in October |
| `notes` | Free text with `\r\n`, includes "Refreshed On" | display as-is |
| `activeStallStoppages` | HTML anchor "YES" or null | treat non-null as stoppage flag |
| `ntniNoticesLinks` | HTML anchors to NTNI notice numbers | parse `in_nav_notice_number` |
| `latitude`, `longitude` | Coordinates | Swapped in all 77 rows (latitude holds -89.06, longitude holds 37.18). Swap on ingest or prefer GIS layer |

### 2.5 Coverage
A1 returns 77 locks on 11 rivers (AG, CH, CU, GB, IL, KA, KS, MI, MN, OH, TN); only rivers that report hydrology. A2 returns 192 locks on 38 river codes. The GIS layer has 234 chamber records (several locks have 2 chambers). A11 adds 16 Gulf Intracoastal locks maintained by New Orleans District with `LOCK_STATUS` ("Open"), `QUEUE_TIME_HOURS`, `LOCK_REMARKS`, `CLOSURE_SCHEDULE`.

### 2.6 Proposed GREEN / YELLOW / RED rules
Evaluate per lock every poll, in this order; first match wins. Record `status_reason`, `as_of` (the newest timestamp among inputs) and `inputs_used`.

RED
1. A3 stoppage with `trafficStopped = "Y"` and now between `beginStopDate` and `endStopDate`, and `isScheduled = "No"` (unscheduled closure).
2. A3 stoppage with `trafficStopped = "Y"` at a single-chamber lock (GIS `NOCHMB = 1`), scheduled or not.
3. A2 `fourHourAverageDelayInMinutes >= 240` or A1 `average4HourDelay >= 240`.
4. NOAA NWPS observed `floodCategory` in {moderate, major} at the paired gauge, or USGS gage height above NWPS `flood.categories.moderate.stage`.

YELLOW
5. Any active A3 stoppage not already RED (scheduled maintenance, one chamber of two closed), or A1 `activeStallStoppages` non-null.
6. A2 4h delay 60 to 239 minutes, or `totalPendingArrivals >= 6`.
7. NOAA `floodCategory` in {action, minor}, or forecast category reaching action within 48h.
8. A1 `notes` contains "one chamber", "land chamber only", "river chamber only", "restricted", "outdraft" (case-insensitive).
9. Any open NTNI notice linked in `ntniNoticesLinks` whose effective window includes now.

GREEN
10. None of the above and newest input age <= 2 hours.

STALE (grey ring over last color)
11. Newest input older than 2 hours (A1 `entryDatetime` is operator-entered and often lags; 04:00 to 08:00 spread observed at 14:26 UTC). Keep last color, show "as of".

Paired gauges: map each lock to a NOAA LID and USGS site (e.g. OH 76 Cannelton -> CNNI3 / USGS 03303280; McAlpine -> USGS 03294500). The NWPS gauge payload includes `usgsId`, `flood.categories` (CNNI3: action 40 ft, minor 42, moderate 46, major 50) and `status.observed.floodCategory`, so one lookup table of ~80 LIDs is enough.

### 2.7 Fallback simulation
If LPMS is unavailable (HTTP 5xx or stale > 6h), switch the status engine to a seeded Markov simulation over the GIS lock list: hourly transition matrix G->Y 4%, Y->G 30%, Y->R 10%, R->Y 25%, with seasonal multipliers (high-water Yellow probability x3 in Mar to May) and scheduled-closure injections drawn from the 36 real `stoppage_reason_codes` ("High Water", "Debris in lock recess or lock chamber", "Tow detained by Coast Guard or Corps", etc.). Flag every simulated row `source = "simulated"` in the UI.

### 2.8 Lock lat/lon sources
1. NDC GIS Locks layer 0 (234 chambers, NAD83 points, maxRecordCount 2000): authoritative. 
2. LPMS A1 `latitude`/`longitude` (swapped) for the 77 reporting locks.
3. NID CSV `Latitude`/`Longitude` for dams with `Number of Locks > 0` (cross-check).
4. District layer A11 for 16 Gulf locks.

## 3. Section B: Sustainable Rivers Program figures with provenance

| Figure | Value | Source (fetched 2026-10-06) |
|---|---|---|
| Program start | Pilot 1998 on Green River KY; formally established 2002 with 8 river systems | HEC `sustainablerivers/history/` |
| Current scale (USACE) | "more than 60 river systems, 14,000 river miles, and 150,000 acres of floodplain" | HEC `sustainablerivers/sites/` |
| Current scale (TNC, 2026) | "grown to 65 rivers across 27 Army Corps districts" | TNC newsroom, RTI economic analysis release |
| Current scale (TNC program page) | 8 rivers in 2002 to 65 rivers in 2026, nearly 15,000 miles, more than 100 associated reservoirs and dams | TNC SRP page (`tnc_srp.png`) |
| 2019 snapshot | "66 federal dams on 16 rivers in 15 states"; 5,111 river miles (Advance 3,325 / Implement 531 / Incorporate 1,255) | TNC PDF `Sustainable_Rivers_Program_011719_V2_final.pdf` |
| 2020 snapshot | "16 rivers in 15 states by 2019 ... increased the program to almost 30 rivers in 30 states" | TNC blog 2020-06-16 |
| 2024 snapshot | "more than 50 teams across 27 USACE districts" | RTI CBA report (TNC, 2025), section 2 |
| Economic value | Portfolio NPV $243M to $265M by 2040, BCR 12.63 to 13.69; Mel Price BCR 12.43; Des Moines NPV $17.7M BCR 8.98; Caddo Lake NPV $2.86M BCR 7.89; Green River ~$20M realized since 2010 | RTI report + TNC newsroom |
| 2026 budget | "SRP budget was decreased by 56%, which reduced funding for the Program to its lowest level since 2019. 11 new rivers were proposed" | HEC `sites/emerging/` |

Growth timeline (HEC history page, "Efforts initiated"): 2002 8 rivers; 2012 Twelve Pole Creek; 2014 Upper Ohio, Des Moines, Lehigh; 2016 Barren; 2017 Kansas, Cape Fear; 2020 8 new rivers; 2021 16 new rivers (incl. 5 lock and dam systems, 3 dry dams); 2022 5 new; 2023 5 new; 2024 12 new; 2025 workshops Green, Licking, Mahoning; 2026 11 proposed. Cumulative count from these increments: 8 (2002) -> 16 (2019) -> ~24 (2020) -> ~40 (2021) -> ~45 (2022) -> ~50 (2023) -> ~62 (2024) -> 65 (2026, TNC).

Per-river list (HEC sites menu, 24 named sites): Barren, Big Cypress Bayou, Bill Williams, Cape Fear, Connecticut, Cossatot, Des Moines, Green, Iowa, Kansas, Kaskaskia, Lehigh, Mill Creek, Mississippi, Ohio, Osage, Pecos, Roanoke, Savannah, Twelve Pole Creek, Upper Ohio, White, Willamette, Yakima River Delta. Named structures on site pages: Green River Dam; Saylorville and Lake Red Rock (Des Moines); J. Strom Thurmond, Richard B. Russell, Hartwell, New Savannah Bluff L&D (Savannah); Mel Price L&D and 25 Upper Mississippi locks and dams; 13 Willamette dams incl. Lookout Point, Fall Creek; Alamo Dam (Bill Williams); Kinzua Dam, Allegheny L&D 9 (Upper Ohio); Clinton, Waconda, Wilson, Kanopolis, Harlan County (Kansas); Kaskaskia L&D. No official SRP GeoJSON/CSV was found; build the SRP map by joining these names to NID (`Dam Name`, `Latitude`, `Longitude`) and to the Locks layer. Note the IWR SRP page (`iwr.usace.army.mil/Missions/Environment/Sustainable-Rivers-Program/`) returned Access Denied from the VM; the HEC page is the live official source.

## 4. Section C: Value-to-the-public datasets (machine-readable)

1. NID full CSV (`nid.sec.usace.army.mil/api/nation/csv`): 92,766 dams, 84 fields incl. `Hazard Potential Classification`, `Condition Assessment`, `Primary Purpose`, `NID Storage (Acre-Ft)`, `Number of Locks`, `Year Completed`, lat/lon. 753 rows carry USACE in owner or federal-agency fields (`nid/nid_usace_owned.csv`). Header line 1 is "Data Last Updated: 2026-10-5"; skip it.
2. Civil Works budget J-sheets (contentdm PDFs, FY2000 to FY2026). FY26 O&M file: 75 pages, columns STATE, DIVISION, PROGRAM NAME, BUDGETED AMOUNT, BUSINESS PROGRAM, AMOUNT BY BUSINESS LINE, DESCRIPTION. Business-line codes: ENS, FDRR (FRM), HYD, NIH, NIL, REC, WTR, HMTF. Parsed totals from the PDF text (indicative, not audited): NIH $697.7M, FDRR $593.4M, REC $275.0M, HYD $196.5M, NIL $150.6M, ENS $112.9M, WTR $4.2M. Press books (xlsx-derived PDFs) give account totals, e.g. FY2018 request $5.002B. Index of every year's PDF URL is in `budget/budget_links.txt`.
3. LPMS monthly tonnage by commodity per lock (A7) and traffic counts (A5): live, JSON, no key.
4. Hydropower and recreation headline numbers (Wayback copies of usace.army.mil pages): "more than 70 billion kilowatt hours per year", "1 out of every 4 Megawatts of hydropower in the US", "5th largest electric supplier", "50 million metric tons CO2e avoided"; recreation "260 million visitors annually to its more than 400 lake and river projects in 43 states", "$14.5 billion" visitor spending. Static tiles only.
5. ArcGIS services on the same USACE org (`services7.arcgis.com/n1YM8pTrFmm7L4hs`): `usace_recreation_areas`, `Link_Tonnages`, `Waterway_Networks`, `Principal_Ports`, `corps_projects`, `usace_mil_dist`, `usace_cw_divisions`, `DQM_Current_Vessel_Status`, `USACE_Dredging_Schedule`, `Current_Ice_Jams`. Not all were queried; `Locks` verified.

Not usable from this VM: EIA API (403, proxy), data.gov CKAN API (404), corpslakes.erdc.dren.mil (no response), gao.gov (403).

## 5. Section D: Internal systems (not public) and vocabulary for synthetic data

Confirmed: no public endpoints exist for CEFMS, P2, EMS, CMP or BUILDER. `publications.usace.army.mil` and `usace.army.mil` return Akamai 403 to non-browser clients; the regulations below were retrieved from the Wayback Machine (`web.archive.org/web/2025id_/...`) and saved in `internal/`.

CEFMS (ER 37-1-30 "Financial Administration: Accounting and Reporting", Change 1 dated 28 Nov 2003, portfolio of 23 chapters). Vocabulary with frequency in the regulation text: work item (235), appropriation (246), revolving fund (268), obligation (134), expenditure (77), cost share (66), labor cost (63), reimbursable (55), disbursement (34), PR&C purchase request and commitment (29), commitment (24), labor charge (23), customer order (21), P2 (12), ENG Form 3013 (11), labor hours (10), direct charge (10), allotment (10), time and attendance (7), work allowance (5), funds control (5), funding authorization document FAD (2). Chapter 6 states labor is charged to "the benefitting project, customer, facility, overhead or leave account" and recorded via "early labor cutoff procedures in CEFMS". Example work item code format in the text: `001SZV`; revolving-fund work items `RF40 Shops and Yards Operations`, `RF41 Laboratory Operations`. Chapter 13 ties cost-shared projects to "P2 resourcing" and requires accounts "reconciled and closed (in P2 and CEFMS)"; contracts "marked complete in P2 with a Contract Status 5". Synthetic schema suggestion: `work_item_code (6 char), appropriation (96X3122 Construction / 96X3123 O&M / 96X3121 Investigations / 96X3112 MR&T / 96X4902 Revolving Fund), fiscal_year, allotment, commitment, obligation, expenditure, disbursement, cost_share_pct, customer_order_no, PR&C_no, labor_hours, labor_rate, overhead_rate (departmental, G&A)`.

P2 (ER 5-1-11 "USACE Business Process", revision memo from CECS): mandates the Project Management Business Process (PMBP) for all work; "Project Management Information System 2 (P2)" is the automated information system; key terms: project delivery team PDT (26 mentions), project management plan PMP (22), schedule, milestones, program and project, "project and non-project work ... captured in P2". Synthetic schema: `p2_project_no (6 digits), p2_program_code, project_name, district (EROC), division, business_line (NAV/FRM/HYD/REC/ENS/WTR/EMG/REG), phase (Reconnaissance, Feasibility, PED, Construction, O&M), pdt_lead, pmp_approved_date, baseline_start, baseline_finish, current_finish, pct_complete, resource_loaded_hours, funded_amount, scheduled_milestones (FCSA, Chief's Report, PPA, Construction Award, BCOES)`. Real project names, states, districts and FY26 amounts come from the J-sheets (section 4 item 2).

BUILDER SMS (ERDC-CERL; `sms.erdc.dren.mil` live, fact sheet via Wayback): component-level inventory, field assessment, Condition Index (CI) 0 to 100 per component rolled up to Building Condition Index (BCI), 10-year work plans and cost forecasts, rulesets and scenario comparison. Synthetic schema: `building_id, uniformat_section (D30 HVAC, D50 Electrical, B30 Roofing ...), component_type, install_year, service_life, last_inspection_date, ci (0-100), bci, deficiency_cost, work_plan_year`.

EMS (USACE labor and time entry feeding CEFMS; no public manual found): use CEFMS Chapter 6 terms: `employee_id, pay_period (bi-weekly), work_item_code, hours_regular, hours_overtime, labor_cost, labor_correction_flag, charge_type (project / customer order / departmental overhead / G&A / leave)`.

CMP (Civil Works construction management / contract milestones; no public source found): model on J-sheet descriptions and ER 37-1-30 contract terms: `contract_no, contractor, award_date, NTP_date, pct_complete, modifications, contract_status (1-5), BCOES_review_date`.

GAO reports on USACE P2 and CEFMS could not be fetched (gao.gov 403 to curl, Wayback 404 for GAO-23-105735); search gao.gov in a browser for "Army Corps of Engineers project management information" if deeper vocabulary is needed.

## 6. Risks, gotchas and ingestion design

Risks
- Akamai bot protection: `usace.army.mil`, `iwr.usace.army.mil`, `publications.usace.army.mil`, `erdc.usace.army.mil`, `gao.gov` return 403 to curl and to the VM browser (screenshots `iwr_srp.png`, `usace_cw_budget.png`). `ndc.ops.usace.army.mil`, `nid.sec.usace.army.mil`, `hec.usace.army.mil`, `sms.erdc.dren.mil`, contentdm, NOAA and USGS were reachable. Plan for a server-side poller with a stable UA and retries; do not fetch .mil pages from the browser.
- Malformed JSON: `lock_delay_json` is invalid (unescaped values; fixed by regex before parse). `lock_status_report` notes contain raw `\r\n`; `activeStallStoppages` and `ntniNoticesLinks` contain HTML anchors. Parse defensively, never `JSON.parse` the raw delay feed.
- Coordinates swapped in `lock_status_report` (all 77 rows). Use the GIS layer for geometry.
- Coverage gaps: status feed covers 77 of ~194 LPMS locks; delay feed covers 192; GIS has 234 chambers. Expect locks with no live hydrology; show them grey/green from delay+stoppage only.
- Staleness: `entryDatetime` is operator-entered; 6 to 10 hour lag observed. Always display "as of".
- Intermittent 5xx: `lookups/hydrology_weather_codes` returned HTTP 555 twice; `legacy lock_status_report_json` returned empty; `uscg/json` is 401. Cache last-good responses.
- ORDS session cookie `Max-Age=600`; stateless requests still worked. ORDS pagination defaults (25 rows) did not appear on these handlers, but the Swagger shows ORDS-generated services, so handle `hasMore`/`offset` if it appears.
- Rate limits: none documented; 9 calls/min succeeded. Be polite anyway (see cadence).
- Terms: US Government works, public domain; NDC asks for citation ("USACE Navigation Data Center"). NOAA/USGS data public domain; USGS IV values flagged `P` (provisional). TNC content is copyrighted; quote figures with attribution, do not redistribute PDFs.
- IL5 context: the demo backend should pull from these public endpoints only; no CAC-gated or FOUO sources were touched.

Ingestion design
- Poller (serverless or container) on a schedule: `lock_status_report?ALL` and `lock_delay_json` every 5 min; `stall_stoppage_json` every 5 min; `lock_queue_json` per lock on demand (cache 5 min); `river_at_a_glance` per river every 15 min; `monthly_tons_report` daily 11:00 ET; NOAA `gauges/{lid}` every 15 min for ~80 LIDs (NWPS is a separate host, cheap); USGS IV every 15 min batched by `sites=` (up to 100 sites per call); NID CSV weekly; GIS Locks layer weekly; J-sheets annually.
- Normalize into `lock_dim` (from GIS + lookups), `lock_status_fact` (append-only, with `as_of`, `fetched_at`, `source`), `stoppage_fact`, `gauge_fact`, `status_eval` (R/Y/G + reason + inputs). Compute status in the API, not the browser.
- Serve the UI from the app's own API with ETag and 60 s cache; mark rows `stale` when `now - as_of > 2h` and `simulated` when the fallback engine is active.
- Keep raw payload snapshots (JSON) for 30 days to replay the status rules.

## 7. Assumptions
- "~200 locks" means the 194 LPMS lock numbers; the GIS 234 count includes multiple chambers.
- The 15-minute cadence claimed on corpslocks is treated as the LPMS DB refresh, not the operator entry time.
- SRP "number of dams" uses TNC's "more than 100 associated reservoirs and dams" (2026) and "66 federal dams" (2019); USACE does not publish a dam count on the HEC page.
- Budget business-line totals were parsed from PDF text and should be re-derived from the Press Book tables before external use.
