import numpy as np
import pandas as pd
import os
import json


class settings:
    DATA_DIR = 'data/raw'
    CONFIG_DIR = 'data/config'
    SEEDER_FILE = 'data/seeder/seeder.sql'
    SEED = 42


class Seeder:
    def __init__(self):
        pass

    def generate_sql(self):
        syntax = 'DROP DATABASE IF EXISTS StonksBit;\n'
        syntax += 'CREATE DATABASE IF NOT EXISTS StonksBit;\nUSE StonksBit;\n'

        listdirs = os.listdir(settings.DATA_DIR)
        listdirs = ['Users.json', 'Posts.json', 'Stocks.json', 'Live_Stock_Price_Change.json',
                    'Stock_Daily_Price.json', 'Stock_IPO.json', "Comments.json", 'Live']
        listdirs += ['Post_Likes.json', 'Post_Comments.json', 'Post_Tags.json']
        listdirs += ['Moderators.json', 'Monitoring_Posts.json']
        listdirs += ['Orders.json', 'Transactions.json', 'Portfolios.json']
        listdirs += ['Comment_Likes.json', 'Comment_Replies.json']
        listdirs += ['Predictions.json', 'Prediction_Voting.json']
        
        for filename in listdirs:
            if not filename.endswith('.json'):
                continue

            name_only = os.path.splitext(filename)[0]
            data_path = os.path.join(settings.DATA_DIR, filename)
            config_path = os.path.join(settings.CONFIG_DIR, filename)

            if not os.path.exists(config_path):
                print(f"Warning: Config for {filename} not found. Skipping.")
                continue

            with open(config_path, 'r') as f:
                config = json.load(f)
            with open(data_path, 'r') as f:
                data = json.load(f)

            table_name = config['table']
            columns = config['columns']
            primary_key = config.get('primary_key')
            foreign_keys = config.get('foreign_keys', [])

            # Start building CREATE TABLE statement
            syntax += f"CREATE TABLE {table_name} (\n"

            # Define columns
            for col_name, col_type in columns.items():
                syntax += f"    {col_name} {col_type},\n"

            # Handle primary key
            if isinstance(primary_key, list):
                syntax += f"    PRIMARY KEY ({', '.join(primary_key)})\n"
            elif isinstance(primary_key, str):
                syntax += f"    PRIMARY KEY ({primary_key})\n"
            else:
                syntax = syntax.rstrip(',\n') + '\n'

            if len(foreign_keys) > 0:
                syntax += ",\n"
            tmp = []
            for fk in foreign_keys:
                str_tmp = ""
                str_tmp += f"    FOREIGN KEY ({fk['column']}) REFERENCES {fk['references']} "
                if 'on_delete' in fk:
                    str_tmp += f"ON DELETE {fk['on_delete']} "
                if 'on_update' in fk:
                    str_tmp += f"ON UPDATE {fk['on_update']} "
                str_tmp += " \n"
                tmp.append(str_tmp)
            syntax += ",\n".join(tmp)
            syntax += ");\n"

            # Insert data
            syntax += f"INSERT INTO {table_name} ({', '.join(columns.keys())}) VALUES\n"
            rows = []
            for row in data:
                col_values = ', '.join(
                    "'" + str(v).replace("'", "''") + "'" for v in row.values())
                rows.append(f"    ({col_values})")
            syntax += ",\n".join(rows) + ";\n"

        # Write to the seed file
        with open(f'{settings.SEEDER_FILE}', 'w') as f:
            f.write(syntax)

Seeder().generate_sql()