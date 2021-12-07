//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Lyvennitha on 07/12/21.
//

import Foundation
class NewsListViewModel{
    static let shared = NewsListViewModel()
    
    func getLatestNewsData(onResponse: @escaping(Result<NewsListResponse, Error>)->()){
        NewsListModelAPI.shared.getNewsList(onResponse: {(result) in
            switch result{
            case .success(let data):
                onResponse(.success(data))
            case .failure(let error):
                onResponse(.failure(error))
            }
            
        })
        
    }
}
