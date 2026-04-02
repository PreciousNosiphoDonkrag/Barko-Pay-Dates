from dagster import asset,AssetExecutionContext
from execute_asset import execute_asset
import pandas as pd
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


@asset(compute_kind='PYTHON', required_resource_keys={"CLICKHOUSE_TABLES"})
def LOAD_SQLSERVER_CSV(context: AssetExecutionContext):

    file_path = "./data/Government_PayDates_2026.csv"
    df = pd.read_csv(file_path)
    df["MOST_SELECTED_DATE"] = pd.to_datetime(df["MOST_SELECTED_DATE"]).dt.date
    df["LAST_UPDATE"] = pd.Timestamp.now()

    df = df.astype({
    "Branch_Submissions": "int",
    "NUMBER_OF_TIMES_DATE_WAS_SELECTED": "int"
     }) 

    context.log.info(f"Loaded {len(df)} rows :)! ")
    context.log.info(f"Columns: {df.columns.tolist()}")
    context.log.info(f"Columns: {df.head()}")

    client = context.resources.CLICKHOUSE_TABLES
    
    client.insert_df(
    "UAT_REPLICATED_TABLES.EMPLOYER_PAYDATES_SUBMISSION_HISTORY_REPL",
    df
     )
    
    context.log.info("Data inserted successfully")
    return df

