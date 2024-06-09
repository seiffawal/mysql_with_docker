import mysql.connector

def execute_query():
    try:
        # Establish a connection to the MySQL database
        conn = mysql.connector.connect(
            host="localhost",
            port=3306,
            user="root",
            password="data_sec",
            database="mydatabase"
        )

        if conn.is_connected():
            print("Connected to MySQL database")

            # Create a cursor object
            cursor = conn.cursor()

            # Your SQL query to fetch table names
            query_tables = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'mydatabase'"
            cursor.execute(query_tables)
            tables = cursor.fetchall()

            print("Tables in 'mydatabase':")
            for table in tables:
                table_name = table[0]
                print(f"\nTable: {table_name}")

                # Your SQL query to fetch column names
                query_columns = f"SELECT column_name FROM information_schema.columns WHERE table_schema = 'mydatabase' AND table_name = '{table_name}'"
                cursor.execute(query_columns)
                columns = cursor.fetchall()

                print("Columns:")
                for column in columns:
                    print(column[0])  # Printing each column name

    except mysql.connector.Error as e:
        print(f"Error connecting to MySQL: {e}")

    finally:
        # Close the connection
        if conn.is_connected():
            cursor.close()
            conn.close()
            print("MySQL connection is closed")

if __name__ == "__main__":
    execute_query()