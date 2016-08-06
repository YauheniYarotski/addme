import Foundation
import UIKit

class Person: NSObject, NSCoding {
    var name = ""
    var image: UIImage?
    var contacts = [String: String]()
    
    init(name: String, contacts: [String: String], image: UIImage?) {
        super.init()
        self.name = name
        self.contacts = contacts
    }
    
    //MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
            let name = aDecoder.decodeObjectForKey("name") as? String
        , let contacts = aDecoder.decodeObjectForKey("contacts") as? [String: String]
            else {
                return nil
        }
        let image = aDecoder.decodeObjectForKey("image") as? UIImage
        self.init(name: name, contacts: contacts, image: image)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(contacts, forKey: "contacts")
        aCoder.encodeObject(image, forKey: "image")
    }

    
}
