import mysql.connector
import os
import pandas as pd

def connect_to_database(host='127.0.0.1', port=3306, user='root', password='Xhypp*426118', database='proj'):
    """
        Connect to a MySQL database and return the connection and cursor.
        :param host: The host IP address or domain name.
        :param port: The port number.
        :param user: The username.
        :param password: The password.
        :param database: The database name.
        :return: The connection and cursor.
    """
    conn = mysql.connector.connect(
        host=host,
        port=port,
        user=user,
        password=password,
        database=database
    )
    cursor = conn.cursor()
    return conn, cursor

def create_table(cursor, sql):
    """
        Create a table.
        :param cursor: The cursor object.
        :param sql: The SQL statement.
    """
    cursor.execute(sql)

def insert_data(cursor, sql, data):
    """
        Insert data into a table.
        :param cursor: The cursor object.
        :param sql: The SQL statement.
        :param data: The data to be inserted.
    """
    cursor.execute(sql, data)

def query_data(cursor, sql):
    """
        Query data from a table.
        :param cursor: The cursor object.
        :param sql: The SQL statement.
        :return: The query results.
    """
    cursor.execute(sql)
    return cursor.fetchall()

def customer_order(cursor, id):
    op = f"""WITH tmp AS (SELECT * FROM `order` WHERE customer_id = {id})
    SELECT * FROM tmp, customer
    WHERE tmp.customer_id = customer.customer_id"""
    cursor.execute(op)
    return cursor.fetchall()

def execute_query_from_file(cursor, file_path, params=None):
    '''
        Execute SQL commands from a file
        :param cursor: The cursor object.
        :param file_path: The path of the SQL file.
        :param params: The parameters to be passed to the SQL file.
    '''

    with open(file_path, 'r') as file:
        sql_script = file.read()
    
    if params:
        sql_script = sql_script % params
    sql_commands = sql_script.split(';')
    for command in sql_commands:
        if command.strip():
            try:
                cursor.execute(command)
            except mysql.connector.Error as e:
                print(f"An error occurred: {e}")

    
    results = cursor.fetchall()  
    return results


def close_connection(conn):
    """
        Close the connection.
        :param conn: The connection object.
    """
    conn.commit()
    conn.close()

def run_sql_file(filename, conn):
    """
        Run an SQL file.
        :param filename: The filename of the SQL file.
        :param conn: The connection object.
    """
    with open(filename, 'r', encoding='utf8') as file:
        sql_script = file.read()
    
    sql_commands = sql_script.split(';')

    for command in sql_commands:
        if command.strip():
            cursor = conn.cursor()  
            try:
                cursor.execute(command)
                conn.commit()  
            except mysql.connector.Error as e:
                print(f"An error occurred: {e}")
            finally:
                cursor.close()  

def excel_to_sql_query(filename, table_name):
    '''
        Convert an Excel file to an SQL query.
        :param filename: The filename of the Excel file.
        :param table_name: The name of the table.
        :return: The SQL query.
    '''
    data = pd.read_excel(filename)
    columns = ', '.join(data.columns)
    if table_name == 'order':
        sql_query = f"INSERT INTO `order` ({columns}) VALUES "
    else:
        sql_query = f"INSERT INTO {table_name} ({columns}) VALUES "
    for ite, row in data.iterrows():
        row = tuple(row)
        sql_query += str(row) + ','
    sql_query = sql_query[:-1] + ';'
    return sql_query
        

# Database configuration parameters
host = '127.0.0.1'
port = 3306
user = 'youmeng'
password = '123456'   
database = 'proj'
buffered = True

# Connect to the database
conn, cursor = connect_to_database(host, port, user, password, database)
current_directory = os.getcwd()

# # Create table
# filename = os.path.join(current_directory, 'second_ed/data', 'Create.sql')
# run_sql_file(filename, conn)

# # Insert data
# for table_name in ['sign_up_records','customer', 'store', 'item', 'order', 'order_item']:
#     filename = os.path.join(current_directory, 'second_ed/data', f'{table_name}.xlsx')
#     sql_query = excel_to_sql_query(filename, table_name)
#     cursor.execute(sql_query)



# Query item_detail test
# filename = os.path.join(current_directory, 'second_ed/query', 'item_detail.sql')
# res = execute_query_from_file(cursor, filename,('Coffee Jelly',))
# df = pd.DataFrame(res)
# df.columns = ["item_name", "store_name", "store_id", "store_address", "item_id", "item_price", "item_type", "item_inventory"]
# print(df)

# TODO: dataframe rename
# Query customer_order test
# filename = os.path.join(current_directory, 'second_ed/query', 'customer_order.sql')
# res = execute_query_from_file(cursor, filename,(1,))
# df = pd.DataFrame(res)
# df.columns = ['customer_id', 'order_id', 'store_name', 'order_time', 'order_status']
# print(df)

# TODO: dataframe rename
# Query order_detail test
# filename = os.path.join(current_directory, 'second_ed/query', 'order_detail.sql')
# res = execute_query_from_file(cursor, filename,(1,))
# df = pd.DataFrame(res)
# df.columns = ["order_id", "item_name", "item_id", "store_id", "quantity", "customer_id", "order_time", "order_status", "item_price", "item_type", "item_inventory"]
# print(res)

# TODO: dataframe rename
# Query store_detail test
# filename = os.path.join(current_directory, 'second_ed/query', 'store_detail.sql')
# res = execute_query_from_file(cursor, filename,(1,))
# df = pd.DataFrame(res)
# df.columns = ['item_id', 'item_name','item-price','item_type','item_inventory']
# print(res)

# TODO: dataframe rename
# Registration test
# filename = os.path.join(current_directory, 'second_ed/query', 'registration.sql')
# try:
#     execute_query_from_file(cursor,filename,('xingxing','yang','niyhulu','female','2001-12-29','123445','1234556'))
#     print("Registrate successfually!")
# except mysql.connector.Error as e:
#     print(f"An error occurred: {e}")

# Close the connection
close_connection(conn)
