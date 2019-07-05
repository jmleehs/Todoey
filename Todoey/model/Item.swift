//
//  Item.swift
//  Todoey
//
//  Created by Jae Moon Lee on 05/07/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
