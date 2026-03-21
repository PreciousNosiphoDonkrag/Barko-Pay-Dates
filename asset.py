from dagster import asset,AssetExecutionContext
from execute_asset import execute_asset
#from datetime import datetime
#from dateutil.relativedelta import relativedelta


@asset(compute_kind = 'CLICKHOUSE', required_resource_keys = {"CLICKHOUSE_TABLES"})

def PAY_DATE_Asset(context: AssetExecutionContext):
     execute_asset(context, "PAYDATES_USER_ACCESS_MANAGEMENT.sql")
     execute_asset(context, "HISTORICAL_SUBMISSIONS.sql")
     #execute_asset(context, "CLEAN_EMPLOYER_AGG_DELTA_TABLE.sql")
     execute_asset(context, "EMPLOYER_PAYDATE_METRICS_MONTHLY.sql")  
     execute_asset(context, "EMPLOYER_PAYDATE_METRICS_WEEKLY.sql")
     execute_asset(context, "EMPLOYER_PAYDATE_METRICS_FORTNIGHT.sql")      

