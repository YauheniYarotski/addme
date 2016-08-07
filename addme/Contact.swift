//
//  Contact.swift
//  addme
//
//  Created by Evgeniy Demeshkevich on 07.08.16.
//  Copyright © 2016 Yauheni Yarotski. All rights reserved.
//

import Foundation

public class Contact {
    
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
    
}

