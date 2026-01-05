INSERT INTO UAT_REPLICATED_TABLES.PAYDATE_HIERARCHY_LOOKUP_REPL
WITH source AS 
(
    SELECT DISTINCT
        PastelCode AS BranchName,
        AreaName,
        RegionName,
        AreaManagerEmail,
        BranchEmail,
        RegionManagerEmail
    FROM REPLICATED_TABLES.V_Detailed_BAR_Hierarchy_REPL
    WHERE lower(T24_Code) != lower('Unknown')
)

SELECT
    'BRANCH'           AS HIERARCHY_KEY,
    BranchName         AS HIERARCHY,
    BranchEmail        AS HIERARCHY_EMAIL,
    [RegionName]                 AS REGIONS,
    [AreaName]                 AS AREAS,
    [BranchName]       AS BRANCHES,
    now()              AS LAST_UPDATE
FROM source

UNION ALL

SELECT
    'AREA'                       AS HIERARCHY_KEY,
    AreaName                     AS HIERARCHY,
    any(AreaManagerEmail)        AS HIERARCHY_EMAIL,
    [RegionName]                 AS REGIONS,
    [AreaName]                   AS AREAS,
    groupArrayDistinct(BranchName)  AS BRANCHES,
    now()                        AS LAST_UPDATE
FROM source
GROUP BY RegionName, AreaName

UNION ALL

SELECT
    'REGION'                      AS HIERARCHY_KEY,
    RegionName                    AS HIERARCHY,
    any(RegionManagerEmail)       AS HIERARCHY_EMAIL,
    [RegionName]                 AS REGIONS,
    groupArrayDistinct(AreaName)  AS AREAS,
    groupArrayDistinct(BranchName) AS BRANCHES,
    now()                         AS LAST_UPDATE
FROM source
GROUP BY RegionName

UNION ALL

SELECT
    'COMPANY'                      AS HIERARCHY_KEY,
    'COMPANY'                    AS HIERARCHY,
    any('www.barko.co.za')       AS HIERARCHY_EMAIL,
    groupArrayDistinct(RegionName)  AS REGIONS,    
    groupArrayDistinct(AreaName)  AS AREAS,
    groupArrayDistinct(BranchName) AS BRANCHES,
    now()                         AS LAST_UPDATE
FROM source
GROUP BY HIERARCHY