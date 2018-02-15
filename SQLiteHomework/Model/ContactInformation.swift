//
//  ContactInformation.swift
//  SQLiteHomework
//
//  Created by Maryam Jafari on 9/23/17.
//  Copyright © 2017 Maryam Jafari. All rights reserved.
//

import Foundation
import UIKit
class ContactInformation {
    
    var field_ContactID = "ID"
    var field_ContactName = "NAME"
    var field_ContactAddress = "ADDRESS"
    var field_PhoneNumber = "PHONE"
    var field_ContactEmail = "EMAIL"
    var field_ContactLocation = "LOCATION"
    
    let databaseFileName = "Contact.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    //Singltone
    //static let shared: ContactInformation = ContactInformation()
    
    init( id : Int ,name : String, address: String, phone : String, email : String, location: String) {
        self.field_ContactID = String(id)
        self.field_ContactName = name
        self.field_ContactEmail = email
        self.field_ContactAddress = address
        self.field_ContactLocation = location
        self.field_PhoneNumber = phone
    }
    
    init() {
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
        print ("Path :\(pathToDatabase!)")
    }
    
    func createDatabase() -> Bool {
        var created = false
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
        }
        if database != nil {
            // Open the database.
            if database.open() {
                let createMoviesTableQuery = "CREATE TABLE IF NOT EXISTS CONTACTS (\(field_ContactID) INTEGER PRIMARY KEY AUTOINCREMENT not null, \(field_ContactName) NVARCHAR(255), \(field_ContactAddress) NVARCHAR(255), \(field_PhoneNumber) VARCHAR(12), \(field_ContactEmail) VARCHAR(100), \(field_ContactLocation) NVARCHAR(255))"
                
                do {
                    try database.executeUpdate(createMoviesTableQuery, values: nil)
                    created = true
                }
                catch {
                    print("Could not create table.")
                    print(error.localizedDescription)
                }
                
                database.close()
            }
            else {
                print("Could not open the database.")
            }
        }
        return created
    }
    
    
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func insertContactData(contact : ContactInformation)-> Int {
        var id : Int!
        if openDatabase() {
            do {
                var query = ""
                
                query += "insert into Contacts (\(field_ContactID), \(field_ContactName), \(field_ContactEmail), \(field_ContactAddress), \(field_ContactLocation), \(field_PhoneNumber)) values (null , '\(contact.field_ContactName)', '\(contact.field_ContactEmail)', '\(contact.field_ContactAddress)', '\(contact.field_ContactLocation)', '\(contact.field_PhoneNumber)');"
                let query2 = "SELECT ID FROM CONTACTS ORDER BY ID DESC LIMIT 1"
                do {
                    
                    try database.executeQuery(query, values: nil)
                }
                catch {
                    print(error.localizedDescription)
                }
                
                if database.executeStatements(query) {
                    
                    do {
                        print(database)
                        let results = try database.executeQuery(query2, values: nil)
                        while results.next() {
                            id = Int(results.string(forColumn: field_ContactID)!)
                        }
                        
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                    
                }
                else{
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                }
            }
            
            
            database.close()
        }
        return id
    }
    
    func loadContact(id : Int) -> ContactInformation! {
        
        var contact :  ContactInformation!
        if openDatabase() {
            let query = "select * from CONTACTS where ID = \(id)"
            
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    contact = ContactInformation(id : Int(results.string(forColumn: field_ContactID)!)!,name: results.string(forColumn: field_ContactName)!, address: results.string(forColumn: field_ContactAddress)!, phone: results.string(forColumn: field_PhoneNumber)!, email: results.string(forColumn: field_ContactEmail)!, location: results.string(forColumn: field_ContactLocation)!)
                    
                }
                print("All Contacts Info : \(results)")
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return contact
    }
    
}


