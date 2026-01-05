#resource_test file 
from resource import CLICKHOUSE_TABLES
client = CLICKHOUSE_TABLES(None) #manual initialize
 
try:
    result = client.query("SELECT version()")
    print("Connected to ClickHouse! Version:", result.result_rows)
except Exception as e:
    print("Destination: ...screwed. Population: You. :( \n", e)