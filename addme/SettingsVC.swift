//
//  SettingsVC.swift
//  addme
//
//  Created by Yauheni Yarotski on 8/7/16.
//  Copyright © 2016 Yauheni Yarotski. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    

    @IBOutlet weak var row: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var sessionManager: SessionManager!

    @IBAction func done(sender: UIButton) {

    
    let person1 = Person(name: "Yauheni Yarotski", contacts: [Contact(name:"ig", url: "http://facebook.com"), Contact(name:"g+", url: "http://facebook.com"), Contact(name:"g+", url: "http://facebook.com")], image: UIImage(named: "avatar2"), descriptionName: "iOS Developre at Add Me")
    
    let person2 = Person(name: "Alex Cvirko", contacts: [Contact(name:"fb", url: "http://facebook.com"), Contact(name:"sk", url: "http://facebook.com")], image: UIImage(named: "avatar3"), descriptionName: "Designer at Add Me")
    
    let person3 = Person(name: "Olya Yackevich Cvirko", contacts: [Contact(name:"fb", url: "http://facebook.com"), Contact(name:"sk", url: "http://facebook.com")], image: UIImage(named: "avatar3"), descriptionName: "Designer at Add Me")
    
        if row.text == "1" {
    sessionManager.me = person1
        } else if row.text == "2" {
            sessionManager.me = person2
        } else {
            sessionManager.me = person3
        }
    }
}
