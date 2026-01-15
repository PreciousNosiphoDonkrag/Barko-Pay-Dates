INSERT INTO UAT_REPLICATED_TABLES.PAYDATE_HIERARCHY_LOOKUP_REPL
WITH source AS 
(
    SELECT DISTINCT CO_CODE,
        Filtered_LC,
        PastelCode AS BranchName,
        AreaName,
        RegionName,
        AreaManagerEmail,
        BranchEmail,
        RegionManagerEmail
    FROM REPLICATED_TABLES.V_Detailed_BAR_Hierarchy_REPL T1
    LEFT JOIN 
    ( SELECT * FROM 
      (
        SELECT CO_CODE,Filtered_LC, START_DATE
        FROM
        (
            SELECT CO_CODE, Filtered_LC, START_DATE,
            row_number() OVER (PARTITION BY Filtered_LC ORDER BY START_DATE DESC) AS rn
            FROM "REPLICATED_TABLES"."LENDING_TRANSACTIONS_REPL"
            WHERE YEAR(START_DATE) >= 2025
        )
        WHERE rn = 1
      )
    ) T2 
    ON T2.CO_CODE = T1.T24_Code
    WHERE lower(T24_Code) != lower('Unknown') AND Active = '1'
)

SELECT
    'LC'                                  AS HIERARCHY_KEY,
    Filtered_LC                           AS HIERARCHY,
    mail                                  AS HIERARCHY_EMAIL,
    groupArrayDistinct(RegionName)        AS REGIONS,
    groupArrayDistinct(AreaName)          AS AREAS,
    groupArrayDistinct(BranchName)        AS BRANCHES,
    now()                                 AS LAST_UPDATE
FROM source T1
LEFT JOIN "REPLICATED_TABLES"."AD_ALL_USERS_REPL" T2
ON T1.BranchName = T2.officeLocation AND T1.Filtered_LC = T2.employeeId
WHERE HIERARCHY <> '' 
GROUP BY Filtered_LC, mail


UNION ALL

SELECT
    'BRANCH'                             AS HIERARCHY_KEY,
    BranchName                           AS HIERARCHY,
    any(BranchEmail)                     AS HIERARCHY_EMAIL,
    groupArrayDistinct(RegionName)       AS REGIONS,
    groupArrayDistinct(AreaName)         AS AREAS,
    groupArrayDistinct(BranchName)       AS BRANCHES,
    now()                                AS LAST_UPDATE
FROM source
GROUP BY BranchName

UNION ALL

SELECT
    'AREA'                       AS HIERARCHY_KEY,
    AreaName  AS HIERARCHY,
    any(AreaManagerEmail)       AS HIERARCHY_EMAIL,
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

-------------------LAST WORKING VERSION------------------------------------------------------------------
/*
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
    WHERE lower(T24_Code) != lower('Unknown') AND Active = '1'
)

SELECT
    'BRANCH'           AS HIERARCHY_KEY,           
    BranchName AS HIERARCHY, --IF(Upper(RegionName) = Upper('DIGITAL'), Upper('DIGITAL'), BranchName)
    BranchEmail        AS HIERARCHY_EMAIL,
    [RegionName]                 AS REGIONS,
    [AreaName]                 AS AREAS,
    [BranchName]       AS BRANCHES,
    now()              AS LAST_UPDATE
FROM source

UNION ALL

SELECT
    'AREA'                       AS HIERARCHY_KEY,
    AreaName  AS HIERARCHY,
    any(AreaManagerEmail)       AS HIERARCHY_EMAIL,
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
*/