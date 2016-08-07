
import UIKit

class MyInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var contactImg: UIImageView!
    
    //Create an instance of Contact
    var contact: Contact!
    
    //Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Set Round Corners
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(contact: Contact) {
        self.contact = contact
        contactImg.image = UIImage(named: "\(contact.name)")
    }
    
}
