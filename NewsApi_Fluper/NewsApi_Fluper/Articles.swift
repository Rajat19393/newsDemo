//
//  Articles.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import Foundation
import CoreData
struct Articles : Codable {
    let source : Source?
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String?
    let content : String?
    init(_ object :NSManagedObject) {
        self.author = object.value(forKey: ArticleDataBaseKeys.author.rawValue) as? String
        self.title = object.value(forKey: ArticleDataBaseKeys.title.rawValue) as? String
        self.description = object.value(forKey: ArticleDataBaseKeys.articleDescription.rawValue) as? String
        self.url = object.value(forKey: ArticleDataBaseKeys.articleUrl.rawValue) as? String
        self.urlToImage = object.value(forKey: ArticleDataBaseKeys.imageUrl.rawValue) as? String
        self.publishedAt = object.value(forKey: ArticleDataBaseKeys.publishedTime.rawValue) as? String
        self.content = object.value(forKey: ArticleDataBaseKeys.content.rawValue) as? String
        let sourceId  = object.value(forKey: ArticleDataBaseKeys.sourceId.rawValue) as? String
        let sourceName  = object.value(forKey: ArticleDataBaseKeys.sourceName.rawValue) as? String
        self.source = Source(sourceId, sourceName)
    }
}
