//
//  News.swift
//  news-api
//
//  Created by 萩倉丈 on 2021/06/19.
//

import Foundation

struct News : Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
