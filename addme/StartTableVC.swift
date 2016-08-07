//
//  StartTableVC.swift
//  addme
//
//  Created by Evgeniy Demeshkevich on 07.08.16.
//  Copyright © 2016 Yauheni Yarotski. All rights reserved.
//

import UIKit

class StartTableVC: UITableViewController {
    
    let sessionManager = SessionManager()
    var persons = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        sessionManager.delegate = self

        loadPersones()
    }
    
    func loadPersones() {
        let person1 = Person(name: "Yauheni Dzemiashkevich", contacts: ["fb" : "http://facebook.com"], image: UIImage(named: "avatar"), descriptionName: "iOS Developre at Add Me" )
        let person2 = Person(name: "Yauheni Yarotski", contacts: ["fb" : "http://facebook.com"], image: UIImage(named: "avatar2"), descriptionName: "iOS Developre at Add Me")
        let person3 = Person(name: "Alex Cvirko", contacts: ["fb" : "http://facebook.com"], image: UIImage(named: "avatar3"), descriptionName: "Designer at Add Me")
        let person4 = Person(name: "Vladimir Hudnitski", contacts: ["fb" : "http://facebook.com"], image: UIImage(named: "avatar4"), descriptionName: "Android Developre at RubyRoid Labs")
        persons = [person1, person2, person3, person4]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personsCell", forIndexPath: indexPath) as! StartCell

        let person = persons[indexPath.row]
        cell.name.text = person.name
        cell.avatar.image = person.image
        cell.descriptionName.text = person.descriptionName
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

extension StartTableVC : SessionManagerDelegate {
    
    func connectedDevicesChanged(manager: SessionManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
//            self.connectionsLabel.text = "Connections: \(connectedDevices)"
            if connectedDevices.count > 0 {
                self.sessionManager.sendMyContact()
            }
        }
    }
    
    func didRecivePerson(manager: SessionManager, person: Person) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            print(person.name, person.contacts)
            let url = NSURL(string: person.contacts["fb"]!)!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
}
