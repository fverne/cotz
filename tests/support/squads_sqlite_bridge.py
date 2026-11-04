"""Execute SQL emitted by the squad Lua implementation against a real SQLite database."""
import json
import sqlite3
import sys
from pathlib import Path


def lua(value):
    if value is None:
        return 'nil'
    return json.dumps(str(value), ensure_ascii=False)


statement_path, database_path, result_path = sys.argv[1:]
with sqlite3.connect(database_path) as connection:
    connection.row_factory = sqlite3.Row
    try:
        cursor = connection.execute(Path(statement_path).read_text())
        rows = cursor.fetchall() if cursor.description else []
        result = '{' + ','.join('{' + ','.join(
            '[' + lua(key) + ']=' + lua(row[key]) for key in row.keys()
        ) + '}' for row in rows) + '}'
    except sqlite3.Error as error:
        result = 'false,' + lua(str(error))
Path(result_path).write_text('return ' + result)
