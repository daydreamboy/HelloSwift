/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import SQLite3
import PlaygroundSupport

destroyPart1Database()

/*:
 
 # Getting Started
 
 The first thing to do is set your playground to run manually rather than automatically. This will help ensure that your SQL commands run when you intend them to. At the bottom of the playground click and hold the Play button until the dropdown menu appears. Choose "Manually Run".
 
 You will also notice a `destroyPart1Database()` call at the top of this page. You can safely ignore this, the database file used is destroyed each time the playground is run to ensure all statements execute successfully as you iterate through the tutorial.
 
 */


//: ## Open a Connection
func openDatabase() -> OpaquePointer? {
  var db: OpaquePointer?
  if sqlite3_open(part1DbPath, &db) == SQLITE_OK {
      print("Successfully opened connection to database at \(part1DbPath ?? "nil")")
    return db
  } else {
    print("Unable to open database.")
    PlaygroundPage.current.finishExecution()
  }
}
let db = openDatabase()
//: ## Create a Table
let createTableString = """
CREATE TABLE Contact(
Id INT PRIMARY KEY NOT NULL,
Name CHAR(255));
"""

func createTable() {
  // 1
  var createTableStatement: OpaquePointer?
  // 2
  if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
    // 3
    if sqlite3_step(createTableStatement) == SQLITE_DONE {
      print("\nContact table created.")
    } else {
      print("\nContact table could not be created.")
    }
  } else {
    print("\nCREATE TABLE statement could not be prepared.")
  }
  // 4
  sqlite3_finalize(createTableStatement)
}
createTable()
//: ## Insert a Contact
let insertStatementString = "INSERT INTO Contact (Id, Name) VALUES (?, ?);"
//func insert() {
//  var insertStatement: OpaquePointer?
//  // 1
//  if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//    let id: Int32 = 1
//    let name: NSString = "Ray"
//    // 2
//    sqlite3_bind_int(insertStatement, 1, id)
//    // 3
//    sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
//    // 4
//    if sqlite3_step(insertStatement) == SQLITE_DONE {
//      print("\nSuccessfully inserted row.")
//    } else {
//      print("\nCould not insert row.")
//    }
//  } else {
//    print("\nINSERT statement could not be prepared.")
//  }
//  // 5
//  sqlite3_finalize(insertStatement)
//}

//: ## Challenge - Multiple Inserts
func insert() {
  var insertStatement: OpaquePointer?
  // 1
  let names: [NSString] = ["Ray", "Chris", "Martha", "Danielle"]
  if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
    // 2
    print("\n")
    for (index, name) in names.enumerated() {
      // 3
      let id = Int32(index + 1)
      sqlite3_bind_int(insertStatement, 1, id)
      sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
      if sqlite3_step(insertStatement) == SQLITE_DONE {
        print("Successfully inserted row.")
      } else {
        print("Could not insert row.")
      }
      // 4
      sqlite3_reset(insertStatement)
    }
    sqlite3_finalize(insertStatement)
  } else {
    print("\nINSERT statement could not be prepared.")
  }
}
insert()
//: ## Querying

//: ## Challenge - Querying multiple rows

//: ## Update

//: ## Delete

//: ## Close the database connection

//: Continue to [Making It Swift](@next)

