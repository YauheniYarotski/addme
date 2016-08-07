//
//  Contact.swift
//  addme
//
//  Created by Evgeniy Demeshkevich on 07.08.16.
//  Copyright © 2016 Yauheni Yarotski. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding {
    
    private var _name: String!
    private var _url: String!

    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var url: String {
        if _url == nil {
            _url = ""
        }
        return _url
    }
    
    //Constructor or Initializer
    init(name: String, url: String) {
        self._name = name
        self._url = url
    }
    
    
    //MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
     let name = aDecoder.decodeObjectForKey("name") as? String ,
            let url = aDecoder.decodeObjectForKey("url") as? String
            else {
                return nil
        }
        self.init(name: name, url: url)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(_name, forKey: "name")
        aCoder.encodeObject(_url, forKey: "url")
    }
    
}

