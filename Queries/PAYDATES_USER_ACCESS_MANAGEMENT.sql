
INSERT INTO UAT_REPLICATED_TABLES.PAYDATES_USER_ACCESS_MANAGEMENT_REPL
SELECT
REGION,
AREA,
 BRANCH, 
HIERARCHY_EMAIL,
HIERARCHY_KEY,
GROUP_BY_PARAM,
HIERARCHY,
now() AS LAST_UPDATE
FROM
(

--Loan Consultants
SELECT 
RegionName AS REGION
,AreaName AS AREA
,PastelCode AS BRANCH
,mail AS HIERARCHY_EMAIL
,'LC' AS HIERARCHY_KEY
,'branch' AS GROUP_BY_PARAM
,PastelCode AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.PastelCode = T1.officeLocation
WHERE jobTitle = 'LOAN CONSULTANT' AND officeLocation <> 'ZZOP'
AND mail IS NOT NULL
AND mail != ''
AND mail != 'Unknown' 
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL 
SELECT 
RegionName AS REGION
,AreaName AS AREA
,'-' AS BRANCH
,mail AS HIERARCHY_EMAIL
,'LC' AS HIERARCHY_KEY
,'area' AS GROUP_BY_PARAM
,PastelCode AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.PastelCode = T1.officeLocation
WHERE jobTitle = 'LOAN CONSULTANT' AND officeLocation <> 'ZZOP'
AND mail IS NOT NULL
AND mail != ''
AND mail != 'Unknown' 
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL
SELECT 
RegionName AS REGION
,'-' AS AREA
,'-' AS BRANCH
,mail AS HIERARCHY_EMAIL
,'LC' AS HIERARCHY_KEY
,'region' AS GROUP_BY_PARAM
,PastelCode AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.PastelCode = T1.officeLocation
WHERE jobTitle = 'LOAN CONSULTANT' AND officeLocation <> 'ZZOP'
AND mail IS NOT NULL
AND mail != ''
AND mail != 'Unknown' 
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL
SELECT 
'-' AS REGION
,'-' AS AREA
,'-' AS BRANCH
,mail AS HIERARCHY_EMAIL
,'LC' AS HIERARCHY_KEY
,'company' AS GROUP_BY_PARAM
,PastelCode AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.PastelCode = T1.officeLocation
WHERE jobTitle = 'LOAN CONSULTANT' AND officeLocation <> 'ZZOP'
AND mail IS NOT NULL
AND mail != ''
AND mail != 'Unknown' 
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL
--Branch Managers 
SELECT 
RegionName AS REGION
,AreaName AS AREA
,PastelCode AS BRANCH
,BranchEmail AS HIERARCHY_EMAIL
,'BRANCH' AS HIERARCHY_KEY
,'branch' AS GROUP_BY_PARAM
,PastelCode AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.PastelCode = T1.officeLocation
WHERE jobTitle = 'BRANCH MANAGER' AND officeLocation <> 'ZZOP'
AND BranchEmail IS NOT NULL
AND BranchEmail != ''
AND BranchEmail != 'Unknown' 
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL

SELECT 
RegionName AS REGION,
AreaName AS AREA,
'-' AS BRANCH,
BranchEmail AS HIERARCHY_EMAIL,
'BRANCH' AS HIERARCHY_KEY,
'area' AS GROUP_BY_PARAM,
PastelCode AS HIERARCHY,
now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.PastelCode = T1.officeLocation
WHERE jobTitle = 'BRANCH MANAGER' AND officeLocation <> 'ZZOP'
AND BranchEmail IS NOT NULL
AND BranchEmail != ''
AND BranchEmail != 'Unknown' 
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL

SELECT 
RegionName AS REGION,
'-' AS AREA,
'-' AS BRANCH,
BranchEmail AS HIERARCHY_EMAIL,
'BRANCH' AS HIERARCHY_KEY,
'region' AS GROUP_BY_PARAM,
PastelCode AS HIERARCHY,
now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.PastelCode = T1.officeLocation
WHERE jobTitle = 'BRANCH MANAGER' AND officeLocation <> 'ZZOP'
AND BranchEmail IS NOT NULL
AND BranchEmail != ''
AND BranchEmail != 'Unknown' 
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL

SELECT 
'-' AS REGION,
'-' AS AREA,
'-' AS BRANCH,
BranchEmail AS HIERARCHY_EMAIL,
'BRANCH' AS HIERARCHY_KEY,
'company' AS GROUP_BY_PARAM,
PastelCode AS HIERARCHY,
now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.PastelCode = T1.officeLocation
WHERE jobTitle = 'BRANCH MANAGER' AND officeLocation <> 'ZZOP'
AND BranchEmail IS NOT NULL
AND BranchEmail != ''
AND BranchEmail != 'Unknown' 
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL
--Area Managers 
SELECT
RegionName AS REGION,
AreaName AS AREA,
PastelCode AS BRANCH, 
AreaManagerEmail AS HIERARCHY_EMAIL
,'AREA' AS HIERARCHY_KEY
,'branch' AS GROUP_BY_PARAM
,PastelCode AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
    ON T2.AreaName = T1.officeLocation
WHERE jobTitle = 'AREA MANAGER' AND officeLocation <> 'ZZOP' AND PastelCode NOT LIKE 'AREA%'
AND AreaManagerEmail IS NOT NULL
AND AreaManagerEmail != ''
AND AreaManagerEmail != 'Unknown'
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL

SELECT
RegionName AS REGION,
AreaName AS AREA,
'-' AS BRANCH, 
AreaManagerEmail AS HIERARCHY_EMAIL
,'AREA' AS HIERARCHY_KEY
,'area' AS GROUP_BY_PARAM
,AreaName AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.AreaName = T1.officeLocation
WHERE jobTitle = 'AREA MANAGER' AND officeLocation <> 'ZZOP'
AND AreaManagerEmail IS NOT NULL
AND AreaManagerEmail != ''
AND AreaManagerEmail != 'Unknown'
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL
SELECT
RegionName AS REGION,
'-' AS AREA,
'-' AS BRANCH, 
AreaManagerEmail AS HIERARCHY_EMAIL
,'AREA' AS HIERARCHY_KEY
,'region' AS GROUP_BY_PARAM
,AreaName AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
    ON T2.AreaName = T1.officeLocation
WHERE jobTitle = 'AREA MANAGER' AND officeLocation <> 'ZZOP'
AND AreaManagerEmail IS NOT NULL
AND AreaManagerEmail != ''
AND AreaManagerEmail != 'Unknown'
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL
SELECT
'-' AS REGION,
'-' AS AREA,
'-' AS BRANCH, 
AreaManagerEmail AS HIERARCHY_EMAIL
,'AREA' AS HIERARCHY_KEY
,'company' AS GROUP_BY_PARAM
,AreaName AS HIERARCHY
,now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL 
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
ON T2.AreaName = T1.officeLocation
WHERE jobTitle = 'AREA MANAGER' AND officeLocation <> 'ZZOP'
AND AreaManagerEmail IS NOT NULL
AND AreaManagerEmail != ''
AND AreaManagerEmail != 'Unknown'
AND YEAR(Closed_Date) = 1970
AND accountEnabled = 'true'

UNION ALL
--Region Managers
SELECT
    RegionName AS REGION,
    AreaName AS AREA,
    PastelCode AS BRANCH,
    RegionManagerEmail AS HIERARCHY_EMAIL,
    'REGION' AS HIERARCHY_KEY,
    'branch' AS GROUP_BY_PARAM,
    PastelCode AS HIERARCHY,
    now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
    ON T2.RegionName = T1.officeLocation
WHERE jobTitle = 'OPERATIONAL MANAGER' AND officeLocation <> 'ZZOP'
    AND RegionManagerEmail IS NOT NULL
    AND RegionManagerEmail != ''
    AND RegionManagerEmail != 'Unknown'
    AND YEAR(Closed_Date) = 1970
    AND accountEnabled = 'true'

UNION ALL
SELECT
    RegionName AS REGION,
    AreaName AS AREA,
    '-' AS BRANCH,
    RegionManagerEmail AS HIERARCHY_EMAIL,
    'REGION' AS HIERARCHY_KEY,
    'area' AS GROUP_BY_PARAM,
    AreaName AS HIERARCHY,
    now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
    ON T2.RegionName = T1.officeLocation
WHERE jobTitle = 'OPERATIONAL MANAGER' AND officeLocation <> 'ZZOP'
    AND RegionManagerEmail IS NOT NULL
    AND RegionManagerEmail != ''
    AND RegionManagerEmail != 'Unknown'
    AND YEAR(Closed_Date) = 1970
    AND accountEnabled = 'true'

UNION ALL
SELECT
    RegionName AS REGION,
    '-' AS AREA,
    '-' AS BRANCH,
    RegionManagerEmail AS HIERARCHY_EMAIL,
    'REGION' AS HIERARCHY_KEY,
    'region' AS GROUP_BY_PARAM,
    RegionName AS HIERARCHY,
    now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
    ON T2.RegionName = T1.officeLocation
WHERE jobTitle = 'OPERATIONAL MANAGER' AND officeLocation <> 'ZZOP'
    AND RegionManagerEmail IS NOT NULL
    AND RegionManagerEmail != ''
    AND RegionManagerEmail != 'Unknown'
    AND YEAR(Closed_Date) = 1970
    AND accountEnabled = 'true'

UNION ALL
SELECT
    '-' AS REGION,
    '-' AS AREA,
    '-' AS BRANCH,
    RegionManagerEmail AS HIERARCHY_EMAIL,
    'REGION' AS HIERARCHY_KEY,
    'company' AS GROUP_BY_PARAM,
    RegionName AS HIERARCHY,
    now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T1 FINAL
INNER JOIN "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T2
    ON T2.RegionName = T1.officeLocation
WHERE jobTitle = 'OPERATIONAL MANAGER' AND officeLocation <> 'ZZOP'
    AND RegionManagerEmail IS NOT NULL
    AND RegionManagerEmail != ''
    AND RegionManagerEmail != 'Unknown'
    AND YEAR(Closed_Date) = 1970
    AND accountEnabled = 'true'

UNION ALL
-- COMPANY
SELECT  
RegionName AS REGION,
AreaName AS AREA,
PastelCode AS BRANCH,
email_lc AS HIERARCHY_EMAIL,
'COMPANY' AS HIERARCHY_KEY,
'branch' AS GROUP_BY_PARAM,
BRANCH AS HIERARCHY,
now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T1
CROSS JOIN PROD_OPS_T24.dashboardAllAccessUsers_DICT T2
WHERE YEAR(Closed_Date) = 1970 AND Active = '1' AND BranchEmail <> 'Unknown' AND Type = '0'
AND dictGet('PROD_OPS_T24.dashboardAllAccessUsers_DICT','allowed',email_lc) = '1'

UNION ALL
SELECT  
RegionName AS REGION,
AreaName AS AREA,
'-' AS BRANCH,
email_lc AS HIERARCHY_EMAIL,
'COMPANY' AS HIERARCHY_KEY,
'area' AS GROUP_BY_PARAM,
AreaName AS HIERARCHY,
now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T1
CROSS JOIN PROD_OPS_T24.dashboardAllAccessUsers_DICT T2
WHERE YEAR(Closed_Date) = 1970 AND Active = '1' AND BranchEmail <> 'Unknown' AND Type = '0'
AND dictGet('PROD_OPS_T24.dashboardAllAccessUsers_DICT','allowed',email_lc) = '1'

UNION ALL
SELECT  
RegionName AS REGION,
'-' AS AREA,
'-' AS BRANCH,
email_lc AS HIERARCHY_EMAIL,
'COMPANY' AS HIERARCHY_KEY,
'region' AS GROUP_BY_PARAM,
RegionName AS HIERARCHY,
now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T1
CROSS JOIN PROD_OPS_T24.dashboardAllAccessUsers_DICT T2
WHERE YEAR(Closed_Date) = 1970 AND Active = '1' AND BranchEmail <> 'Unknown' AND Type = '0'
AND dictGet('PROD_OPS_T24.dashboardAllAccessUsers_DICT','allowed',email_lc) = '1'

UNION ALL
SELECT  
'-' AS REGION,
'-' AS AREA,
'-' AS BRANCH,
email_lc AS HIERARCHY_EMAIL,
'COMPANY' AS HIERARCHY_KEY,
'company' AS GROUP_BY_PARAM,
'company' AS HIERARCHY,
now() AS LAST_UPDATE
FROM "REPLICATED_TABLES"."V_Detailed_BAR_Hierarchy_REPL" T1
CROSS JOIN PROD_OPS_T24.dashboardAllAccessUsers_DICT T2
WHERE YEAR(Closed_Date) = 1970 AND Active = '1' AND BranchEmail <> 'Unknown' AND Type = '0'
AND dictGet('PROD_OPS_T24.dashboardAllAccessUsers_DICT','allowed',email_lc) = '1'
)