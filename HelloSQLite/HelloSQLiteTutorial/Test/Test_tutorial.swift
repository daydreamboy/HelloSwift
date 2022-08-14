//
//  Test_tutorial.swift
//  Test_tutorial
//
//  Created by wesley_chen on 2022/8/13.
//

import XCTest
import SQLite3

let documentDirectoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

private enum DatabaseDemo: String {
    case Example1
    case Example2
    
    var path: String? {
      return documentDirectoryUrl?.appendingPathComponent("\(self.rawValue).sqlite").relativePath
    }
}

public let DbExample1Path = DatabaseDemo.Example1.path

private func destroyDatabase(db: DatabaseDemo) {
    guard let path = db.path else { return }
    do {
        if FileManager.default.fileExists(atPath: path) {
          try FileManager.default.removeItem(atPath: path)
        }
    } catch {
        print("Could not destroy \(db) Database file.")
    }
}

class Test_tutorial: XCTestCase {
    var db: OpaquePointer?
    
    // MARK: Operate DB
    
    func openDatabase() {
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
    
    func closeDatabase() {
        if sqlite3_close(db) == SQLITE_OK {
            print("Successfully close connection to database at \(String(describing: db))")
        }
        else {
            print("Unable to close connection to database at \(String(describing: db))")
        }
    }
    
    func deleteDatabase() {
        destroyDatabase(db: .Example1)
    }
    
    func test_openDatabase() throws {
        self.deleteDatabase()
        self.openDatabase()
    }
    
    func test_closeDatabase() throws {
        self.closeDatabase()
    }
    
    // MARK: Create Table
        
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
    
    // MARK: Insert Rows
    
    func test_insert_one_rows() throws {
        let insertStatementSQL = """
        INSERT INTO Contact (Id, Name) VALUES (?, ?);
        """
        var insertStatement: OpaquePointer?
        
        self.deleteDatabase()
        self.openDatabase()
        self.createTable()
        defer {
            self.closeDatabase()
        }
        
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
    }
    
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
    
    func test_insert_multiple_rows() throws {
        self.deleteDatabase()
        self.openDatabase()
        self.createTable()
        
        self.insert_multiple_rows()
        
        self.closeDatabase()
    }
    
    // MARK: Query Rows
    
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
    
    func test_query_one_row() throws {
        self.deleteDatabase()
        self.openDatabase()
        self.createTable()
        
        // Note: try comment out this line to test no data
        self.insert_multiple_rows()
        
        self.query_one_row()
        
        self.closeDatabase()
    }
    
    func test_query_multiple_row() throws {
        self.deleteDatabase()
        self.openDatabase()
        self.createTable()
        
        // Note: try comment out this line to test no data
        self.insert_multiple_rows()
        
        defer {
            self.closeDatabase()
        }
        
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
    }
    
    // MARK: Update Rows
    
    func test_update_rows() throws {
        self.deleteDatabase()
        self.openDatabase()
        self.createTable()
        defer {
            self.closeDatabase()
        }
        
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
    }
    
    // MARK: Delete Rows
    
    func test_delete_rows() throws {
        self.deleteDatabase()
        self.openDatabase()
        self.createTable()
        
        defer {
            self.closeDatabase()
        }
        
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
    }
    
    // MARK: Handle Errors
    
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
}
