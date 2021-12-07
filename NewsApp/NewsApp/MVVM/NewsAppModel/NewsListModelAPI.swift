//
//  NewsListModelAPI.swift
//  NewsApp
//
//  Created by Lyvennitha on 07/12/21.
//

import Foundation

class NewsListModelAPI{
    static let shared = NewsListModelAPI()
    
    func getNewsList(onResponse: @escaping (Result<NewsListResponse, Error>)-> ()){
        NetWorkHandler.shared.getRequest(onResponse: onResponse)
    }
}

// MARK: - NewsListResponse
public class NewsListResponse: Codable {
    public let status: String?
    public let totalResults: Int?
    public let articles: [Article]?

    public init(status: String?, totalResults: Int?, articles: [Article]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

// MARK: - Article
public class Article: Codable {
    public let source: Source?
    public let author: String?
    public let urlToImage: String?
    public let content, title: String?
    public let publishedAt: Date?
    public let articleDescription: String?
    public let url: String?

    enum CodingKeys: String, CodingKey {
        case source, author, urlToImage, content, title, publishedAt
        case articleDescription = "description"
        case url
    }

    public init(source: Source?, author: String?, urlToImage: String?, content: String?, title: String?, publishedAt: Date?, articleDescription: String?, url: String?) {
        self.source = source
        self.author = author
        self.urlToImage = urlToImage
        self.content = content
        self.title = title
        self.publishedAt = publishedAt
        self.articleDescription = articleDescription
        self.url = url
    }
}

// MARK: - Source
public class Source: Codable {
    public let id: String?
    public let name: String?

    public init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}

