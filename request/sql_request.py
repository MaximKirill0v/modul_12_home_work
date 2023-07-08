def create_request_people():
    sql_request = f'''CREATE TABLE IF NOT EXISTS people
                 (
                     id INTEGER PRIMARY KEY AUTOINCREMENT,
                     name TEXT NOT NULL,
                     surname TEXT NOT NULL,
                     patronymic TEXT NOT NULL,
                     birth TEXT NOT NULL,
                     gender TEXT NOT NULL,
                     phone TEXT NOT NULL UNIQUE,
                     city TEXT NOT NULL,
                     country TEXT NOT NULL,
                     house TEXT NOT NULL,
                     frame TEXT DEFAULT('отсутствует'),
                     apartment TEXT NOT NULL
                 )'''
    return sql_request


def create_request_sellers_or_buyer(name_table: str):
    sql_request = f'''CREATE TABLE IF NOT EXISTS {name_table}
                      (
                          id INTEGER PRIMARY KEY AUTOINCREMENT,
                          name TEXT NOT NULL,
                          surname TEXT NOT NULL,
                          patronymic TEXT NOT NULL,
                          email TEXT NOT NULL UNIQUE,
                          phone TEXT NOT NULL UNIQUE
                      )'''
    return sql_request


def create_request_sales(name_table: str):
    sql_request = f'''CREATE TABLE IF NOT EXISTS {name_table}
                      (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        id_sellers INTEGER NOT NULL,
                        id_buyer INTEGER NOT NULL,
                        product_name TEXT,
                        price REAL NOT NULL DEFAULT 0 CHECK(price >= 0),
                        date_of_sale TEXT,
                        FOREIGN KEY(id_sellers) REFERENCES sellers(id),
                        FOREIGN KEY(id_sellers) REFERENCES buyer(id)
                      )'''
    return sql_request


def create_request_style_or_singer(name_table: str):
    sql_request = f'''CREATE TABLE IF NOT EXISTS {name_table}
                      (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        name TEXT UNIQUE
                      )'''
    return sql_request


def create_request_publisher(name_table: str):
    sql_request = f'''CREATE TABLE IF NOT EXISTS {name_table}
                          (
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            name TEXT UNIQUE,
                            country TEXT
                          )'''
    return sql_request


def create_request_music_disc(name_table: str):
    sql_request = f'''CREATE TABLE IF NOT EXISTS {name_table}
                          (
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            name_disc TEXT UNIQUE,
                            date_of_issue TEXT CHECK(date_of_issue BETWEEN '1970:01:01' AND 'CURRENT_DAY'),
                            style_id INTEGER NOT NULL,
                            publisher_id INTEGER NOT NULL,
                            singer_id INTEGER NOT NULL,
                            FOREIGN KEY(style_id) REFERENCES style(id),
                            FOREIGN KEY(publisher_id) REFERENCES publisher(id),
                            FOREIGN KEY(singer_id) REFERENCES singer(id)
                          )'''
    return sql_request


def create_request_song(name_table: str):
    sql_request = f'''CREATE TABLE IF NOT EXISTS {name_table}
                          (
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            name_song TEXT,
                            song_duration REAL CHECK(song_duration > 0),
                            music_disk_id INTEGER NOT NULL,
                            style_id INTEGER NOT NULL,
                            singer_id INTEGER NOT NULL,
                            FOREIGN KEY(music_disk_id) REFERENCES music_disk(id),
                            FOREIGN KEY(style_id) REFERENCES style(id),
                            FOREIGN KEY(singer_id) REFERENCES singer(id)
                          )'''
    return sql_request
