from dagster import Definitions
from asset import PAY_DATE_Asset
from resource import CLICKHOUSE_TABLES

defs = Definitions(
    assets=[PAY_DATE_Asset],  
    jobs=[
    ],
    sensors=[],
    schedules=[],
    resources={
        "CLICKHOUSE_TABLES": CLICKHOUSE_TABLES
    }
)