//
//  CoreData.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import CoreData
import UIKit

enum ArticleDataBaseKeys: String {
    case sourceName
    case sourceId
    case author
    case title
    case articleDescription
    case articleUrl
    case imageUrl
    case publishedTime
    case content
}

class ArticleDataBase {
    
   static func saveArticles(_ view : UIViewController ,_ context: NSManagedObjectContext,_ appDelegate: AppDelegate ,_ articleArray : [Articles],successHandler: @escaping (Bool) -> Void) {
        let entity = NSEntityDescription.entity(forEntityName: "ArticleObjects", in: context)
        for articleData in articleArray {
            let article = NSManagedObject(entity: entity!, insertInto: context)
            article.setValue(articleData.author, forKey: ArticleDataBaseKeys.author.rawValue)
            article.setValue(articleData.title, forKey: ArticleDataBaseKeys.title.rawValue)
            article.setValue(articleData.content, forKey: ArticleDataBaseKeys.content.rawValue)
            article.setValue(articleData.description, forKey: ArticleDataBaseKeys.articleDescription.rawValue)
            article.setValue(articleData.publishedAt, forKey: ArticleDataBaseKeys.publishedTime.rawValue)
            article.setValue(articleData.url, forKey: ArticleDataBaseKeys.articleUrl.rawValue)
            article.setValue(articleData.urlToImage, forKey: ArticleDataBaseKeys.imageUrl.rawValue)
            if let sourceData = articleData.source {
                article.setValue(sourceData.id, forKey: ArticleDataBaseKeys.sourceId.rawValue)
                article.setValue(sourceData.name, forKey: ArticleDataBaseKeys.sourceName.rawValue)
            }
        }
        do {
            try context.save()
            successHandler(true)
        } catch let error as NSError {
            view.showAlert(error.localizedDescription)
        }
    }
   static func fetchArticles(_ view : UIViewController ,_ context : NSManagedObjectContext,_ appDelegate : AppDelegate ,successHandler: @escaping ([Articles]) -> Void) {

        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleObjects")
        do {
            let result = try context.fetch(fetchrequest)
            let articleObject = result as! [NSManagedObject]
            var articleArray : [Articles] = []
            for object in articleObject {
               articleArray.append(Articles(object))
            }
            successHandler(articleArray)
        } catch let error as NSError {
            view.showAlert(error.localizedDescription)
        }
    }
}
