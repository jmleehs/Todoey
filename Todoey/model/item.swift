//
//  item.swift
//  Todoey
//
//  Created by Jae Moon Lee on 30/06/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import Foundation


class Item {
    var title: String = ""
    var done: Bool = false
    
    init(title:String){
        self.title = title
    }
}
