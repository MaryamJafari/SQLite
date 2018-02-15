//
//  ViewController.swift
//  SQLiteHomework
//
//  Created by Maryam Jafari on 9/22/17.
//  Copyright © 2017 Maryam Jafari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var ContactName: UITextField!
    @IBOutlet weak var Addres: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Phone: UITextField!
    
    var name: String!
    var loc : String!
    var phoneNumb : String!
    var addressInfo : String!
    var emailAddress : String!
    var createdDB : Bool?
    var openDB : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(ContactInformation().createDatabase()){
            createdDB = ContactInformation().createDatabase()}
    }
    
    @IBAction func saveContact(_ sender: Any) {
        if let myname = ContactName.text{
            name = myname
        }
        
        if let myloc = Location.text{
            loc = myloc
        }
        
        if let address = Addres.text{
            addressInfo = address
        }
        if let phone = Phone.text{
            phoneNumb = phone
        }
        
        if let email = Email.text{
            emailAddress = email
        }
        
        let contact = ContactInformation(id : 0 ,name: name, address: addressInfo, phone: phoneNumb, email: emailAddress, location: loc)
        let contactId =  ContactInformation().insertContactData(contact: contact)
        var contactForSegue : ContactInformation!
        contactForSegue = ContactInformation().loadContact(id: contactId)
        performSegue(withIdentifier: "LoadedData", sender: contactForSegue)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoadedData"{
            if let destination = segue.destination as? LoadedDataViewController{
                
                if let contact = sender as? ContactInformation{
                    destination.loadInfo = contact
                }
            }
        }
    }
}

