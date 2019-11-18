//
//  NewsResponse.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import Foundation
struct Newsresponse : Codable {
    let status : String?
    let totalResults : Int?
    let articles : [Articles]?
}
