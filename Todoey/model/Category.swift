//
//  Category.swift
//  Todoey
//
//  Created by Jae Moon Lee on 05/07/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
