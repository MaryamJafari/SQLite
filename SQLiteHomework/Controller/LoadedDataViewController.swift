//
//  LoadedDataViewController.swift
//  SQLiteHomework
//
//  Created by Maryam Jafari on 9/23/17.
//  Copyright © 2017 Maryam Jafari. All rights reserved.
//

import UIKit

class LoadedDataViewController: UIViewController {
    var loadInfo: ContactInformation!
    @IBOutlet weak var loadedData: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(loadInfo)
        loadedData.text = "Contact Saved Information For Record ID : \(loadInfo.field_ContactID) \n Name : \(loadInfo.field_ContactName)\n location : \(loadInfo.field_ContactLocation)\n address :\(loadInfo.field_ContactAddress)\n email: \(loadInfo.field_ContactEmail) "
       
    }


}
