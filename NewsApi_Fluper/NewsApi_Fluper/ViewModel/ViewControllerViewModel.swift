//
//  ViewControllerViewModel.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 18/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ViewControllerViewModel {
    private let networking = NetworkLayer()
    private var articlesArray : [Articles]?
    private let urlString = "https://newsapi.org/v2/everything?q=bitcoin&from=2019-10-19&sortBy=publishedAt&apiKey=dff75f9e7676477db967dd00dc6708ae"
    
    func getNewsData(_ view : UIViewController ,_ context : NSManagedObjectContext,_ appDelegate : AppDelegate,successHandler: @escaping (Bool) -> Void ) {
        view.showSpinner()
        self.getNewsDataFromDataBase(view, context, appDelegate) { (success) in
            if success {
                    view.removeSpinner()
                    successHandler(true)
            } else {
                self.getNewsDataFromServer(view, context, appDelegate, successHandler: { (pass) in
                    view.removeSpinner()
                    if pass {
                        successHandler(true)
                    }
                })
            }
        }
    }
    
    func getNewsDataFromDataBase(_ view : UIViewController ,_ context : NSManagedObjectContext,_ appDelegate : AppDelegate,successHandler: @escaping (Bool) -> Void ) {
        let fetchSuccessHandler : ([Articles]) -> Void = { (articlesArray) in
            if articlesArray.count > 0 {
                self.articlesArray = articlesArray
                successHandler(true)
            } else {
                successHandler(false)
            }
        }
        ArticleDataBase.fetchArticles(view, context, appDelegate, successHandler: fetchSuccessHandler)
    }
    
    func getNewsDataFromServer(_ view : UIViewController ,_ context : NSManagedObjectContext,_ appDelegate : AppDelegate,successHandler: @escaping (Bool) -> Void ) {
        let fetchSuccessHandler : ([Articles]) -> Void = { (articlesArray) in
            DispatchQueue.main.async {
                self.articlesArray = articlesArray
                successHandler(true)
            }
        }
        let saveSuccessHandler : (Bool) -> Void = { (success) in
            if success {
                ArticleDataBase.fetchArticles(view, context, appDelegate, successHandler: fetchSuccessHandler)
            }
        }
        let successHandler: (Newsresponse) -> Void = { (response) in
            print(response)
            guard let articles =  response.articles else {
                DispatchQueue.main.async {
                    view.showAlert(NetworkLayer.genericError)
                }
                return
            }
            ArticleDataBase.saveArticles(view, context, appDelegate, articles, successHandler: saveSuccessHandler)
        }
        let errorHandler: (String) -> Void = { (error) in
            print(error)
            DispatchQueue.main.async {
                view.showAlert(error)
            }
        }
        networking.get(urlString: urlString,
                           successHandler: successHandler,
                           errorHandler: errorHandler)
    }
    
     var count: Int {
        return articlesArray?.count ?? 0
    }
    public func cellArticle(index: Int) -> Articles? {
        guard let articleData = articlesArray else { return nil }
        return articleData[index]
    }
}
