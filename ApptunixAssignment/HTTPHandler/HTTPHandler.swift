//
//  HTTPHandler.swift
//  ApptunixAssignment
//
//  Created by SUSHIL SHARMA on 27/07/20.
//  Copyright © 2020 com. All rights reserved.
//
import Foundation
import Alamofire

class HTTPHandler {
    static let shared = HTTPHandler()
    let authToken = "SEC eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTVjYjlmNjczZDA3MjJiOTAyMjRjODAiLCJpYXQiOjE1OTU1MDA2MTZ9.KzWFvhJWHVeVZ1D50cnF4APhojiXqg958sslm7QEAME"
    
    
    /// Post Request using URLSession to fetch data from Server
    /// - Parameters:
    ///   - url: API URL
    ///   - params: Parameters to be passed in body
    ///   - completion: callback
    func postRequest(with url: URL, params: [String: Any]?, completion: @escaping (_ response: [String: Any]?, _ error: Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authToken, forHTTPHeaderField: "authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params ?? [:], options: []) else {
            return
        }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    completion(nil, error)
                    return
            }
            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            completion(responseObject, nil)
            
        }.resume()
    }
    
    /// Post Request using Alamofire SDK to fetch data from Server
    /// - Parameters:
    ///   - url: API URL
    ///   - params: Parameters to be passed in body
    ///   - completion: callback
    func postRequestWithAlamofire(with url: URL, params: [String: Any]?, completion: @escaping (_ response: [String: Any]?, _ error: Error?) -> Void) {
        
        let headers: HTTPHeaders = [.contentType("Application/json"), .authorization(authToken)]
        AF.request(url, method: .post, parameters: params,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(nil, nil)
                    return
                }
                let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
                completion(responseObject, nil)
                break
            case .failure(let error):
                let err = error as Error
                completion(nil, err)
            }
        }
    }
}

