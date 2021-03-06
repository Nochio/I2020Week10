//
//  Note.swift
//  Week 9
//
//  Created by Thomas Hinrichs on 06/03/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation

class Note {
    
    var id: String
    var head: String
    var body: String
    var image: String
    
    init (id: String, head: String, body: String, img: String) {
        self.id = id
        self.head = head
        self.body = body
        self.image = img
    }
}
