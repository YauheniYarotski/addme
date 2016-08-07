

import UIKit
import AVFoundation

class InformationVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var personName: UILabel!
    
    private var contacts = [Contact(name: "fb", url: "http://fb.com"), Contact(name: "vk", url: "http://new.vk.com"), Contact(name: "tw", url: "http://fb.com"), Contact(name: "sk", url: "http://in.com"), Contact(name: "g+", url: "http://fb.com"), Contact(name: "ma", url: "http://fb.com"), Contact(name: "tg", url: "http://fb.com"), Contact(name: "in", url: "http://fb.com")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2
        self.avatar.clipsToBounds = true
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Grid Size (Space between Cells)
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(80, 80)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContactCell", forIndexPath: indexPath) as? MyInfoCell {
            
            var currentContact: Contact!
            currentContact = contacts[indexPath.row]
            cell.configureCell(currentContact)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }

}
