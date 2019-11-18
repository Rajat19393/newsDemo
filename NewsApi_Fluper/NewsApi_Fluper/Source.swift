//
//  Source.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import Foundation
struct Source : Codable {
    let id : String?
    let name : String?
    init(_ sourceId : String? , _ sourceName : String?) {
        self.id = sourceId
        self.name = sourceName
    }
}
