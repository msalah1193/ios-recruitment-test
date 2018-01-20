//
//  ItemModel.swift
//  iOSRecruitmentTest
//
//  Created by Mohamed Salah on 1/19/18.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class ItemModel: Object, Mappable{
    
    @objc dynamic var descriptionField: String!
    @objc dynamic var icon: String!
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String!
    @objc dynamic var timestamp: Int = 0
    @objc dynamic var url: String!
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        descriptionField <- map["description"]
        icon <- map["icon"]
        id <- map["id"]
        name <- map["name"]
        timestamp <- map["timestamp"]
        url <- map["url"]
    }
    
    //MARK:- DATABASE OPERATION
    static func save(array: [ItemModel]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(array)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func clear() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
