//
//  ViewModel.swift
//  iOSRecruitmentTest
//
//  Created by Mohamed Salah on 1/19/18.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import ObjectMapper

class ViewModel {
    //MARK: - Variables
    var items: [ItemModel]
    
    //MARK:- Init
    init() {
        items = []
    }
    
    
    //MARK:- DATA OPERATIONS
    func getItems(completion: @escaping (_ error: String?)->()) {
        //CHECK LOCAL DATA BASE FIRST
        do {
            let realm = try Realm()
            let itemsResult = realm.objects(ItemModel.self)
            
            if itemsResult.count > 0 {
                items.append(contentsOf: Array(itemsResult))
                completion(nil)
            } else {
                self.getFromServer(completion)
            }
            
        } catch let error {
            print(error.localizedDescription)
            self.getFromServer(completion)
        }
    }
    
    //GET ITEMS FROM SERVER
    private func getFromServer(_ completion: @escaping (_ error: String?)->()) {
        let url = URLS.server_ip.rawValue + URLS.Items.get.rawValue
        
        Alamofire.request(url).responseJSON { responseData in
            
            switch responseData.result {
            case .success(let JSON):
                //SAVING RESPONSE
                guard let items = Mapper<ItemModel>().mapArray(JSONObject: JSON) else {
                    completion("Error Getting Data From Server")
                    return
                }
                
                //UPDATE ITEMS
                self.items = items
                
                //SAVE ITEMS TO DATABASE
                ItemModel.save(array: items)
                
                completion(nil)
                break
            case .failure(let error):
                completion(error.localizedDescription)
                break
            }
        }
    }
}
