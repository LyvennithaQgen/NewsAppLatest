//
//  NetWorkLayer.swift
//  SubscriptionModule
//
//  Created by Lyvennitha on 07/12/21.
//

import Foundation

public protocol NetworkConstants{
    var baseURL: String {get set}
    var method: String {get set}
}


public class NetWorkHandler: NSObject{
    public static let shared = NetWorkHandler()
    public var delegate: NetworkConstants?
    
    public func getRequest<T: Codable>(onResponse: @escaping (Result<T, Error>) -> ()){
        var components = URLComponents(string: delegate!.baseURL)!
        let parameters = ["apiKey":"d1129ee7cc7f409eb324c6228ce11726", "sortBy":"publishedAt", "q":"iOS", "page": "2"]
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){(data, response, error) in
            do{
                //print JSON
                let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                let jsonData = try? JSONSerialization.data(withJSONObject: json!, options: [.prettyPrinted, .withoutEscapingSlashes])
                print("prettyPrint",String(decoding: jsonData!, as: UTF8.self))
                //Parse JSON
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(T.self, from: data!)
                onResponse(.success(result))
            }catch(let error){
                onResponse(.failure(error))
            }

        }.resume()

    }
    
    
}

