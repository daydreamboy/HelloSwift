# HelloSQLite

[TOC]

## 1、介绍SQLite3

SQLite3是轻量型的数据库，经常用于移动设备上。iOS系统默认支持SQLite3，因此不需要额外引入SQLite3库。另外，iOS的Core Data也是基于SQLite3封装ORM (Object-Relation Mapping)能力。除了SQLite3之外，还有其他方式持久化数据[^1]，如下

* Realm
* Couchbase Lite
* Firebase
* NSCoding



使用SQLite3有下面几点优势[^1]

* iOS系统默认支持，无需额外引入SQLite3库
* SQLite3是开源的
* SQLite3是跨平台



说明

> 本文不介绍SQLite3的语法，以及关系型数据库的相关知识



## 2、SQLite3入门使用

这里用Swift代码，来介绍SQLite3的基本使用方法，简单来说，有下面几个常见任务

* 打开/关闭数据库
* 创建表
* CRUD操作
* 错误处理

说明

> SQLite3提供的API都是C函数，因此无论是Swift还是Objective-C，都是调用C函数



### (1) 打开/关闭数据库

打开/关闭数据库，实际是创建一个数据库连接，后续所有对数据库的操作，都需要使用到这个数据库连接。

SQLite3提供下面2个函数，如下

* sqlite3_open，用于打开数据库

```c
int sqlite3_open(
  const char *filename,   /* Database filename (UTF-8) */
  sqlite3 **ppDb          /* OUT: SQLite db handle */
);
```

* sqlite3_close，用于关闭数据库

```c
int sqlite3_close(sqlite3*);
```



sqlite3_open的示例代码，如下

```swift
func test_openDatabase() throws {
    destroyDatabase(db: .Example1)

    guard let DbExample1Path = DbExample1Path else {
        print("DbExample1Path is nil.")
        return
    }

    if sqlite3_open(DbExample1Path, &db) == SQLITE_OK {
        print("Successfully opened connection to database at \(DbExample1Path)")
    }
    else {
        print("Unable to open database at \(DbExample1Path)")
        exit(-1)
    }
}
```



sqlite3_open函数接收2个参数

* db文件路径，文件如果不存在，则创建一个文件。此函数不会追加`.sqlite`后缀名
* 数据库连接指针。在Swift中用OpaquePointer类型代表。

sqlite3_open函数的返回值是Int32类型，这里返回SQLITE_OK，实际是0，表示创建一个数据库连接 (Database Connection)成功。

说明

> SQLITE_OK，在SQLite中称为Result Code。更多Result Code可以参考SQLite的官方文档[^2]



sqlite3_close的示例代码，如下

```swift
func test_closeDatabase() throws {
    if sqlite3_close(db) == SQLITE_OK {
        print("Successfully close connection to database at \(String(describing: db))")
    }
    else {
        print("Unable to close connection to database at \(String(describing: db))")
    }
}
```

说明

> sqlite3_close的参数，如果是NULL，也不会有问题
>
> 官方文档描述[^3]，如下
>
> Calling sqlite3_close() or sqlite3_close_v2() with a NULL pointer argument is a harmless no-op.



### (2) 创建表

以创建名为Contact的表为例，它的SQL语句，如下

```swift
let createTableSQL = """
CREATE TABLE Contact(
    Id INT PRIMARY KEY NOT NULL,
    Name CHAR(255)
);
"""
```



创建表需要三个步骤，如下

* 准备一个语句，通过sqlite3_prepare_v2函数等
* 执行这个语句，通过sqlite3_step函数
* 销毁这个语句，通过sqlite3_finalize函数



下面一一介绍这3个函数

sqlite3_prepare_v2函数

```c
int sqlite3_prepare_v2(
  sqlite3 *db,            /* Database handle */
  const char *zSql,       /* SQL statement, UTF-8 encoded */
  int nByte,              /* Maximum length of zSql in bytes. */
  sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
  const char **pzTail     /* OUT: Pointer to unused portion of zSql */
);
```

* db，数据库句柄
* zSql，SQL语句
* nByte，SQL语句的长度大小
* ppStmt，语句指针，是个出参参数
* pzTail，未使用zSql的部分，暂不详。

说明

> sqlite3_prepare_v2函数，带_v2标识，说明它是一个v2版本的函数。而不带v2的sqlite3_prepare函数，已经不推荐使用。
>
> 官方文档描述[^4]，如下
>
> The preferred routine to use is [sqlite3_prepare_v2()](https://sqlite.org/c3ref/prepare.html). The [sqlite3_prepare()](https://sqlite.org/c3ref/prepare.html) interface is legacy and should be avoided. [sqlite3_prepare_v3()](https://sqlite.org/c3ref/prepare.html) has an extra "prepFlags" option that is used for special purposes.



关于nByte的传参，有几点说明

* 传入负数，一般是-1，表示该函数读取zSql参数，从头读到第一个\0为止
* 传入正数，表示该函数读取zSql参数中nByte个字节
* 传入0，表示不生成ppStmt指针

官方文档提到，如果调用者的SQL语句以\0结尾，则nByte传入实际SQL语句长度，包括\0，会有一个小的性能提升。

官方文档描述[^4]，如下

> If the nByte argument is negative, then zSql is read up to the first zero terminator. If nByte is positive, then it is the number of bytes read from zSql. If nByte is zero, then no prepared statement is generated. If the caller knows that the supplied string is nul-terminated, then there is a small performance advantage to passing an nByte parameter that is the number of bytes in the input string *including* the nul-terminator.



sqlite3_step函数

```
int sqlite3_step(sqlite3_stmt*);
```

sqlite3_step函数用于执行语句，而且可以执行一次或者多次。这个函数的返回值，根据不同的prepare函数（即 sqlite3_prepare_xxx函数），有所不同。

官方文档描述[^5]，如下

> In the legacy interface, the return value will be either [SQLITE_BUSY](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#busy), [SQLITE_DONE](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#done), [SQLITE_ROW](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#row), [SQLITE_ERROR](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#error), or [SQLITE_MISUSE](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#misuse). With the "v2" interface, any of the other [result codes](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html) or [extended result codes](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#extrc) might be returned as well.

简单来说，sqlite3_step函数，针对历史的prepare函数，会返回[SQLITE_BUSY](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#busy), [SQLITE_DONE](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#done), [SQLITE_ROW](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#row), [SQLITE_ERROR](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#error), or [SQLITE_MISUSE](dfile:///Users/wesley_chen/Library/Application Support/Dash/DocSets/SQLite/SQLite.docset/Contents/Resources/Documents/sqlite/rescode.html#misuse)，但是对于v2的prepare函数，则不局限于这些Result Code，还有其他Result Code，以及Extended Result Codes。



sqlite3_finalize函数

```c
int sqlite3_finalize(sqlite3_stmt *pStmt);
```

sqlite3_finalize函数用于删除语句，释放语句占用的一些资源。返回SQLITE_OK，表示正确执行，其他error code，表示有错误。

官方文档描述[^6]，如下

> The sqlite3_finalize() function is called to delete a [prepared statement](https://sqlite.org/c3ref/stmt.html). If the most recent evaluation of the statement encountered no errors or if the statement is never been evaluated, then sqlite3_finalize() returns SQLITE_OK. If the most recent evaluation of statement S failed, then sqlite3_finalize(S) returns the appropriate [error code](https://sqlite.org/rescode.html) or [extended error code](https://sqlite.org/rescode.html#extrc).



上面详细介绍sqlite3_prepare_v2函数、sqlite3_step函数和sqlite3_finalize函数，那么创建表的示例代码，如下

```swift
func createTable() {
    let createTableSQL = """
    CREATE TABLE Contact(
        Id INT PRIMARY KEY NOT NULL,
        Name CHAR(255)
    );
    """
    var createTableStatement: OpaquePointer?

    guard sqlite3_prepare_v2(db, createTableSQL, -1, &createTableStatement, nil) == SQLITE_OK else {
        print("CREATE TABLE statement is not prepared.\n")
        return
    }

    guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
        print("\nContact table is not created.")
        return
    }

    print("Contact table created.")

    sqlite3_finalize(createTableStatement)
}

func test_createTable() throws {
    self.deleteDatabase()
    self.openDatabase()

    self.createTable()

    self.closeDatabase()
}
```

说明

> 1. sqlite3_finalize函数传入NULL，也是无害的。
>
> 2. 创建表是否正确，可以通过DB Browser for SQLite打开数据库文件，查看一下



### (3) CRUD操作

CRUD操作是数据库的4个常见基本操作，如下

* C(Create)，创建数据
* R(Read或者queRy)，查询数据
* U(Update )，更新数据
* D(Delete)，删除数据



上面创建表，展示了SQLite3的常见操作数据的3个步骤，这里的CRUD操作也是一样的步骤。这里再提一遍

* 创建语句(prepare)
* 执行语句(step)
* 销毁语句(finialize)



#### a. C操作 (Insert One Row)

示例代码，如下

```swift
func test_insert_one_rows() throws {
    let insertStatementSQL = """
    INSERT INTO Contact (Id, Name) VALUES (?, ?);
    """
    var insertStatement: OpaquePointer?

    self.deleteDatabase()
    self.openDatabase()
    self.createTable()

    guard sqlite3_prepare_v2(db, insertStatementSQL, -1, &insertStatement, nil) == SQLITE_OK else {
        print("INSERT statement is not prepared.")
        return
    }

    let id: Int32 = 1
    let name: String = "Ray"

    guard sqlite3_bind_int(insertStatement, 1, id) == SQLITE_OK else {
        print("bind int failed")
        return
    }
    guard sqlite3_bind_text(insertStatement, 2, name, -1, nil) == SQLITE_OK else {
        print("bind text failed")
        return
    }

    guard sqlite3_step(insertStatement) == SQLITE_DONE else {
        print("Could not insert row.")
        return
    }

    print("Successfully inserted row.")
    sqlite3_finalize(insertStatement)

    self.closeDatabase()
}
```

这里用到一个新的函数：sqlite3_bind_xxx函数。它用于绑定SQL语句的`?`占位符到具体的值。

使用`?`占位符好处是可以复用语句，当value变化时，语句是不变的。

官方文档提供一系列的sqlite3_bind_xxx函数[^8]，如下

```c
int sqlite3_bind_blob(sqlite3_stmt*, int, const void*, int n, void(*)(void*));
int sqlite3_bind_blob64(sqlite3_stmt*, int, const void*, sqlite3_uint64,
                        void(*)(void*));
int sqlite3_bind_double(sqlite3_stmt*, int, double);
int sqlite3_bind_int(sqlite3_stmt*, int, int);
int sqlite3_bind_int64(sqlite3_stmt*, int, sqlite3_int64);
int sqlite3_bind_null(sqlite3_stmt*, int);
int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
int sqlite3_bind_text16(sqlite3_stmt*, int, const void*, int, void(*)(void*));
int sqlite3_bind_text64(sqlite3_stmt*, int, const char*, sqlite3_uint64,
                         void(*)(void*), unsigned char encoding);
int sqlite3_bind_value(sqlite3_stmt*, int, const sqlite3_value*);
int sqlite3_bind_pointer(sqlite3_stmt*, int, void*, const char*,void(*)(void*));
int sqlite3_bind_zeroblob(sqlite3_stmt*, int, int n);
int sqlite3_bind_zeroblob64(sqlite3_stmt*, int, sqlite3_uint64);
```

除了`?`占位符，[sqlite3_prepare_v2()](https://www.sqlite.org/c3ref/prepare.html)以及它变体函数，还支持下面占位符

- ?NNN
- :VVV
- @VVV
- $VVV



sqlite3_bind_xxx函数，前2个参数都是一样

* 语句指针
* 绑定占位符的下标，注意从1开始



#### b. C操作 (Insert Multiple Rows)

示例代码，如下

```swift
func insert_multiple_rows() {
    let insertStatementSQL = """
    INSERT INTO Contact (Id, Name) VALUES (?, ?);
    """
    var insertStatement: OpaquePointer?

    guard sqlite3_prepare_v2(db, insertStatementSQL, -1, &insertStatement, nil) == SQLITE_OK else {
        print("INSERT statement is not prepared.")
        return
    }

    let names: [String] = ["Ray", "Chris", "Martha", "Danielle"]

    for (index, name) in names.enumerated() {
        let id: Int32 = Int32(index + 1)

        guard sqlite3_bind_int(insertStatement, 1, id) == SQLITE_OK else {
            print("bind int failed")
            return
        }
        guard sqlite3_bind_text(insertStatement, 2, name, -1, nil) == SQLITE_OK else {
            print("bind text failed")
            return
        }

        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            print("Could not insert row.")
            return
        }

        sqlite3_reset(insertStatement)
    }

    print("Successfully inserted rows.")
    sqlite3_finalize(insertStatement)
}
```

和插入单个row数据不同的是，这里需要调用sqlite3_reset函数，重置下语句。

官方文档对sqlite3_reset函数的作用[^9]，描述如下

> The sqlite3_reset() function is called to reset a [prepared statement](https://sqlite.org/c3ref/stmt.html) object back to its initial state, ready to be re-executed. Any SQL statement variables that had values bound to them using the [sqlite3_bind_*() API](https://sqlite.org/c3ref/bind_blob.html) retain their values. Use [sqlite3_clear_bindings()](https://sqlite.org/c3ref/clear_bindings.html) to reset the bindings.



#### c. R操作 (Query One Row)

示例代码，如下

```swift
func query_one_row() {
    let queryStatementSQL = """
    SELECT * FROM Contact;
    """

    var queryStatement: OpaquePointer?

    guard sqlite3_prepare_v2(db, queryStatementSQL, -1, &queryStatement, nil) == SQLITE_OK else {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Query is not prepared \(errorMessage)")
        return
    }

    guard sqlite3_step(queryStatement) == SQLITE_ROW else {
        print("\nQuery returned no results.")
        return
    }

    let id = sqlite3_column_int(queryStatement, 0)
    var name: String?
    if let text = sqlite3_column_text(queryStatement, 1) {
        name = String.init(cString: text)
    }

    print("\nQuery Result:")
    print("\(id) | \(name ?? String(describing: name))")

    sqlite3_finalize(queryStatement)
}
```

说明

> 1. sqlite3_column_xxx函数，对应的下标是从0开始的，和占位符的下标从1开始，是不同的
> 2. sqlite3_step函数执行查询语句，如果没有数据，则不会返回SQLITE_ROW



#### d. R操作 (Query Multiple Rows)

示例代码，如下

```swift
func test_query_multiple_row() throws {
    self.deleteDatabase()
    self.openDatabase()
    self.createTable()

    // Note: try comment out this line to test no data
    self.insert_multiple_rows()

    let queryStatementSQL = """
    SELECT * FROM Contact;
    """

    var queryStatement: OpaquePointer?

    guard sqlite3_prepare_v2(db, queryStatementSQL, -1, &queryStatement, nil) == SQLITE_OK else {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Query is not prepared \(errorMessage)")
        return
    }

    print("\nQuery Result:")
    var hasData: Bool = false
    while sqlite3_step(queryStatement) == SQLITE_ROW {
        hasData = true

        let id = sqlite3_column_int(queryStatement, 0)
        var name: String?
        if let text = sqlite3_column_text(queryStatement, 1) {
            name = String.init(cString: text)
        }

        print("\(id) | \(name ?? String(describing: name))")
    }

    if hasData == false {
        print("Query returned no results.")
    }

    sqlite3_finalize(queryStatement)

    self.closeDatabase()
}
```



#### e. U操作 (Update Rows)

示例代码，如下

```swift
func test_update_rows() throws {
    self.deleteDatabase()
    self.openDatabase()
    self.createTable()

    self.insert_multiple_rows()
    self.query_one_row()

    let updateStatementSQL = """
    UPDATE Contact SET Name = 'Adam' WHERE Id = 1;
    """

    var updateStatement: OpaquePointer?

    guard sqlite3_prepare_v2(db, updateStatementSQL, -1, &updateStatement, nil) == SQLITE_OK else {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Update is not prepared \(errorMessage)")
        return
    }

    guard sqlite3_step(updateStatement) == SQLITE_DONE else {
        print("Could not update row.")
        return
    }

    print("Successfully updated row.")
    sqlite3_finalize(updateStatement)

    self.query_one_row()

    self.closeDatabase()
}
```



#### f. D操作 (Delete Rows)

示例代码，如下

```swift
func test_delete_rows() throws {
    self.deleteDatabase()
    self.openDatabase()
    self.createTable()

    self.insert_multiple_rows()
    self.query_one_row()

    let deleteStatementSQL = """
    DELETE FROM Contact WHERE Id = 1;
    """

    var deleteStatement: OpaquePointer?

    guard sqlite3_prepare_v2(db, deleteStatementSQL, -1, &deleteStatement, nil) == SQLITE_OK else {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Delete is not prepared \(errorMessage)")
        return
    }

    guard sqlite3_step(deleteStatement) == SQLITE_DONE else {
        print("Could not delete row.")
        return
    }

    print("Successfully delete row.")
    sqlite3_finalize(deleteStatement)

    self.query_one_row()

    self.closeDatabase()
}
```



### (4) 处理Error

SQLite3产生Error的情况，大概有下面几种

* SQL语句的语法错误
* SQL语句的语义错误，比如查询一个不存在的表
* SQL执行错误，比如时序问题等

这里不列举SQL的语法错误。

举一个SQL语义错误的例子，介绍如何处理SQLite3产生的Error，如下

```swift
func test_SQL_semantic_error() throws {
    let semanticErrorQueryString = """
    SELECT Stuff from Things WHERE Whatever;
    """

    self.deleteDatabase()
    self.openDatabase()
    self.createTable()

    defer {
        self.closeDatabase()
    }

    var queryStatement: OpaquePointer?

    guard sqlite3_prepare_v2(db, semanticErrorQueryString, -1, &queryStatement, nil) == SQLITE_OK else {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("\nQuery is not prepared! \(errorMessage)")
        return
    }

    print("\nThis should not have happened.")

    sqlite3_finalize(queryStatement)
}
```

sqlite3_errmsg函数，用于返回错误信息字符串



## 3、SQLite3常见函数

SQLite3常见函数，归纳如下

| 函数                     | 作用                                                         | 说明                                                      |
| ------------------------ | ------------------------------------------------------------ | --------------------------------------------------------- |
|                          |                                                              |                                                           |
| `sqlite3_open`           | 打开数据库                                                   | 如果数据库不存在，则创建一个新的数据库                    |
| `sqlite3_close`          | 关闭数据库                                                   |                                                           |
|                          |                                                              |                                                           |
| `sqlite3_prepare_v2`     | 创建语句                                                     | 如果创建成功返回`SQLITE_OK`                               |
| `sqlite3_step`           | 执行语句                                                     | 执行查询语句时返回`SQLITE_ROW`，其他情况返回`SQLITE_DONE` |
| `sqlite3_finalize`       | 销毁语句                                                     | 如果语句不再使用，调用这个函数                            |
|                          |                                                              |                                                           |
| `sqlite3_bind_int`       | 查询语句中绑定int类型                                        |                                                           |
| `sqlite3_bind_text`      | 查询语句中绑定char *类型                                     |                                                           |
| `sqlite3_reset`          | 多次查询时，重置查询语句，用于重新绑定                       |                                                           |
| `sqlite3_column_int`     | 查询语句中读取某个列int值                                    |                                                           |
| `sqlite3_column_text`    | 查询语句中读取某个列char *值                                 |                                                           |
|                          |                                                              |                                                           |
| `sqlite3_errmsg`         | 返回错误信息字符串                                           |                                                           |
|                          |                                                              |                                                           |
| `sqlite3_exec`           | 便利函数，包装了`sqlite3_prepare_v2()`、`sqlite3_step()`和`sqlite3_finalize()` |                                                           |
| `sqlite3_wal_checkpoint` | 触发checkpoint，使wal文件合并到sqlite文件中                  |                                                           |
| `sqlite3_free`           | 释放特定指针指向的内存                                       |                                                           |
|                          |                                                              |                                                           |



## 4、SQLite3的Result Code和Error Code

由于SQLite3大量采用C API，因此很多函数需要提供Result Code表示成功或失败的事件。

在SQLite3中有Result Code和Error Code两种，都可用于函数的返回值等

* Error Code是Result Code的子集
* 除了`SQLITE_OK`、`SQLITE_ROW`和 `SQLITE_DONE`，其他Result Code都可以称为Error Code

官方文档描述[^2]，如下

> "Error codes" are a subset of "result codes" that indicate that something has gone wrong. There are only a few non-error result codes: [SQLITE_OK](https://www.sqlite.org/rescode.html#ok), [SQLITE_ROW](https://www.sqlite.org/rescode.html#row), and [SQLITE_DONE](https://www.sqlite.org/rescode.html#done). The term "error code" means any result code other than these three.



## 5、SQLite3 Swift Wrapper

在上面已经介绍SQLite3是基于C API的库，使用起来不是很方便。[SQLite.swift](https://github.com/stephencelis/SQLite.swift)这个库，采用面向对象的方式，封装了SQLite3。

TODO



## 6、源码使用SQLite3库

TODO



## 7、VFS

TODO：https://sqlite.org/vfs.html



## 8、SQLite3常见任务

### (1) 查询SQLite3版本

iOS系统默认带SQLite3库，但是它的版本可能是相对旧一些。为了清楚知道系统用的是哪个版本[^10]，可以使用代码查询version，如下

```swift
func test_check_SQLite3_version() throws {
    print("SQLITE_VERSION = \(SQLITE_VERSION)")
    print("SQLITE_VERSION_NUMBER = \(SQLITE_VERSION_NUMBER)")
    print("SQLITE_SOURCE_ID = \(SQLITE_SOURCE_ID)")

    print("sqlite3_libversion() = \(String.init(cString: sqlite3_libversion()))")
    print("sqlite3_sourceid() = \(String.init(cString: sqlite3_sourceid()))")
    print("sqlite3_libversion_number() = \(sqlite3_libversion_number())")
}
```

打印如下

```shell
SQLITE_VERSION = 3.37.0
SQLITE_VERSION_NUMBER = 3037000
SQLITE_SOURCE_ID = 2021-12-09 01:34:53 9ff244ce0739f8ee52a3e9671adb4ee54c83c640b02e3f9d185fd2f9a179aapl
sqlite3_libversion() = 3.37.0
sqlite3_sourceid() = 2021-12-09 01:34:53 9ff244ce0739f8ee52a3e9671adb4ee54c83c640b02e3f9d185fd2f9a179aapl
sqlite3_libversion_number() = 3037000
```



## 9、SQLite3常见术语

### (1) Checkpoint

Checkpoint是指将wal文件的内容合并到原始的数据库文件中，这个操作称为Checkpoint。

官方文档描述[^11]，如下

> Of course, one wants to eventually transfer all the transactions that are appended in the WAL file back into the original database. Moving the WAL file transactions back into the database is called a "*checkpoint*".





## 10、SQLite3常用工具

### (1) DB Browser for SQLite[^7]

GUI查询SQLite数据库，支持MacOS系统

下载地址：https://sqlitebrowser.org/dl/







## References

[^1]:https://www.raywenderlich.com/6620276-sqlite-with-swift-tutorial-getting-started
[^2]:https://www.sqlite.org/rescode.html
[^3]:https://www.sqlite.org/c3ref/close.html
[^4]:https://sqlite.org/c3ref/prepare.html
[^5]:https://sqlite.org/c3ref/step.html
[^6]:https://sqlite.org/c3ref/finalize.html
[^7]:https://sqlitebrowser.org/
[^8]:https://www.sqlite.org/c3ref/bind_blob.html
[^9]:https://sqlite.org/c3ref/reset.html
[^10]:https://stackoverflow.com/questions/14288128/what-version-of-sqlite-does-ios-provide

[^11]:https://sqlite.org/wal.html

