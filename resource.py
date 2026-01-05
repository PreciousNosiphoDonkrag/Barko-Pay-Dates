from dagster import resource
import clickhouse_connect
import os
from dotenv import load_dotenv

load_dotenv()

@resource
def CLICKHOUSE_TABLES(_):
    client = clickhouse_connect.get_client(
        host=os.getenv("CLICKHOUSE_HOST"),
        port=int(os.getenv("CLICKHOUSE_PORT")),
        username=os.getenv("CLICKHOUSE_USERNAME"),
        password=os.getenv("CLICKHOUSE_PASSWORD"),
        database=os.getenv("CLICKHOUSE_DATABASE"),
    )
    return client
