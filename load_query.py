import os
from datetime import datetime

def load_query(query_file):
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    queries_dir = os.path.join(base_dir, "PAY_DATE_DEV\\Queries")

    full_path = os.path.join(queries_dir, query_file)

    if not os.path.exists(full_path):
        print (f"Query file not found: {full_path}")
   
    else:
        print(f"Loading query file: {full_path}")
        with open(full_path, 'r') as file:
            query = file.read()
        return query
#print(load_query('Historic_Submissions.sql'))