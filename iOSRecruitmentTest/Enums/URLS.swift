//
//  URLS.swift
//  iOSRecruitmentTest
//
//  Created by Mohamed Salah on 1/20/18.
//  Copyright © 2018 Snowdog. All rights reserved.
//

import Foundation

enum URLS: String {
    case server_ip = "http://localhost:8080"
    
    enum Items: String {
        case get = "/api/items"
    }
}
