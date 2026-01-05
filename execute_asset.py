from load_query import load_query

def execute_asset(context, query_name):
    
    client = context.resources.CLICKHOUSE_TABLES

    try:
        query = load_query(query_name)        
        
        send_query = query.format()
    
        
        client.command(send_query)
        context.log.info(f"Successfully inserted {query_name}")
        

    except Exception as e:
            context.log.error(f"Error in asset.\n {e}")
    return
