import sqlite3


def create_tuple():
    list_tuple = []
    count = 1
    for group in range(1, 9):
        for _ in range(1, 11):
            list_tuple.append((group, count))
            count += 1
    return list_tuple


def execute_application():
    a = create_tuple()
    db_name =
    connection = sqlite3.Connection()
    cursor = connection.cursor()



if __name__ == '__main__':
    execute_application()
