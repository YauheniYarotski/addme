import Foundation
import UIKit

class Person: NSObject, NSCoding {
    var name = ""
    var descriptionName = ""
    var image: UIImage?
    var contacts = ContactsType()
     typealias ContactsType = [Contact]
    var added = false
    
    init(name: String, contacts: ContactsType, image: UIImage?, descriptionName: String) {
        super.init()
        self.name = name
        self.contacts = contacts
        self.descriptionName = descriptionName
        self.image = image
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let newPerson = object as? Person {
            return self.name == newPerson.name
        } else {
            return false
        }
    }
    
    //MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
            let name = aDecoder.decodeObjectForKey("name") as? String
        , let contacts = aDecoder.decodeObjectForKey("contacts") as? ContactsType , let descriptionName = aDecoder.decodeObjectForKey("descriptionName") as? String
            else {
                return nil
        }
        let image = aDecoder.decodeObjectForKey("image") as? UIImage
        self.init(name: name, contacts: contacts, image: image, descriptionName: descriptionName)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(contacts, forKey: "contacts")
        aCoder.encodeObject(image, forKey: "image")
        aCoder.encodeObject(descriptionName, forKey: "descriptionName")
    }

    
}
