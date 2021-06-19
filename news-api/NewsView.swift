//
//  NewsView.swift
//  news-api
//
//  Created by 萩倉丈 on 2021/06/19.
//

import SwiftUI

struct NewsView: View {
    let url : String
    init (url: String) {
        self.url = url
    }
    var body: some View {
        WebView(loadUrl: url)
    }
}
