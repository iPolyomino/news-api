//
//  Article.swift
//  news-api
//
//  Created by 萩倉丈 on 2021/06/19.
//

import Foundation

struct Article: Decodable {
    let title: String
    let author: String?
    let description: String?
    let url: String
}
