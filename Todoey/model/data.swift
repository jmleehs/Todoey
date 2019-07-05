//
//  data.swift
//  Todoey
//
//  Created by Jae Moon Lee on 04/07/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object{
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0;
    
}
