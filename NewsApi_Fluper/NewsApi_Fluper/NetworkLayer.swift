//
//  NetworkLayer.swift
//  NewsApi_Fluper
//
//  Created by Rajat on 15/11/19.
//  Copyright © 2019 Rajat. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class NetworkLayer {
    static let genericError = "Something went wrong. Please try again later"
    func get<T: Decodable>(urlString: String,
                           successHandler: @escaping (T) -> Void,
                           errorHandler: @escaping ErrorHandler) {
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(NetworkLayer.genericError)
                return
            }
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(NetworkLayer.genericError)
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            }
            errorHandler(NetworkLayer.genericError)
        }
        guard let url = URL(string: urlString) else {
            return errorHandler("Unable to create URL from given string")
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request,
                                   completionHandler: completionHandler)
            .resume()
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}
