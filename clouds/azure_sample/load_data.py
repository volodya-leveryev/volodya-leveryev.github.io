from csv import DictReader

from azure.data.tables import TableServiceClient

key = (
    "5msoAxYYDGy5E64AHWaf0lrlb777VPxqAuWw8k4jeWiL"
    "gJwWlxlPvL6IbnFNhK9A7vHB2CstNT0DACDbJ4UYEw=="
)
the_connection_string = (
    "DefaultEndpointsProtocol=https;"
    "AccountName=leverev;"
    f"AccountKey={key};"
    "TableEndpoint=https://leverev.table.cosmos.azure.com:443/;"
)
client = TableServiceClient.from_connection_string(the_connection_string)

with open("imdb_top_1000.csv", encoding="utf-8") as f:
    reader = DictReader(f)
    data = [r for r in reader]

table = client.create_table_if_not_exists("movies")
for i, d in enumerate(data, 1):
    new = d.copy()
    new["PartitionKey"] = "movie"
    new["RowKey"] = str(i)
    table.create_entity(entity=new)
