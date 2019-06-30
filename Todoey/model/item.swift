//
//  item.swift
//  Todoey
//
//  Created by Jae Moon Lee on 30/06/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import Foundation

//
//class Item: NSCoding{
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(title, forKey: "title")
//        aCoder.encode(done, forKey: "done")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        title = aDecoder.decodeObject(forKey: "title") as! String
//        done = aDecoder.decodeBool(forKey: "done")
//    }
//
//    var title: String = ""
//    var done: Bool = false
//
//    init(title:String){
//        self.title = title
//    }
//}

class Item : Codable{
   
    var title: String = ""
    var done: Bool = false
    
    init(title:String){
        self.title = title
    }
}
