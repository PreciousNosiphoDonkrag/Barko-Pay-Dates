from dagster import asset,AssetExecutionContext
from execute_asset import execute_asset
#from datetime import datetime
#from dateutil.relativedelta import relativedelta


@asset(compute_kind = 'CLICKHOUSE', required_resource_keys = {"CLICKHOUSE_TABLES"})

def PAY_DATE_Asset(context: AssetExecutionContext):
     execute_asset(context, "Hierarchy_Update.sql")  
    # execute_asset(context, "Historic_Submissions.sql")
     # #execute_asset(context, "Submissions_Counts_Load.sql")      

