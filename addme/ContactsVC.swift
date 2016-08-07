//
//  ContactsVC.swift
//  addme
//
//  Created by Yauheni Yarotski on 8/7/16.
//  Copyright © 2016 Yauheni Yarotski. All rights reserved.
//

import Foundation
import UIKit

protocol ContactsVCDelegate {
    func contactsVCDidFinish(contactsVC: ContactsVC)
}

class ContactsVC: UITableViewController {
    
    var storedOffsets = [Int: CGFloat]()
    var sessionManager: SessionManager!
    var person: Person!
    var delegate: ContactsVCDelegate?
    
    let titles = [
        ("Rap Caviar", "58,211 Followers")
        , ("Dove Beauty", "Sponsered")
        , ("Weekend Buzz", "123,987 Followers")
        , ("EDC Las Vegas", "34854 Followers")
        , ("Covergirl", "Sponsered")
        , ("Teen Party", "157643 Followers")
        , ("New Noise", "33,456 Followers")
        , ("Verizon Wireless", "Sponsered")
    ]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sss", forIndexPath: indexPath) as! StartCell


            cell.name.text = person.name
            cell.avatar.image = person.image
            cell.descriptionName.text = person.descriptionName
        
        
        
        return cell

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    
    //    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        if indexPath.section == 1 {
    //            guard let tableViewCell = cell as? TableViewCellWithCollection else { return }
    //
    //            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    //            tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    //        } else if indexPath.section == 2 {
    //            cell.backgroundColor = tableView.backgroundColor
    //
    //        } else if indexPath.section == 3 {
    //            cell.backgroundColor = tableView.backgroundColor
    //
    //        }
    //    }
    //
    //    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        guard let tableViewCell = cell as? TableViewCellWithCollection else { return }
    //
    //        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    //    }
}



extension ContactsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person.contacts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath)
        
                if let contactCell = cell as? ContactCell {
                    contactCell.image.image = UIImage(named:person.contacts[indexPath.row].name)!
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        person.added = true
        delegate?.contactsVCDidFinish(self)
    }
}