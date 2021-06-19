//
//  ContentView.swift
//  news-api
//
//  Created by 萩倉丈 on 2021/06/19.
//

import SwiftUI

struct ContentView: View {
    @State var newsTitle : [String] = []
    
    var body: some View {
        NavigationView {
            List(0 ..< newsTitle.count) { i in
                Text(newsTitle[i])
            }
                
        }.onAppear(perform: fetch)
    }
    
    private func fetch() {
        let NewsURL = "https://newsapi.org/v2/top-headlines?country=jp&category=sports&q=%E3%82%B5%E3%83%83%E3%82%AB%E3%83%BC&apiKey=98d6f053dadc4fefbf963df812eebdea"

        let url = URL(string: NewsURL)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data {
                parseJSON(data: data)
            }
            
        }
        task.resume()
    }
    
    func parseJSON(data: Data) {
        do {
            let news = try JSONDecoder().decode(News.self, from: data)
            newsTitle = news.articles.map {$0.title}
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}

struct Article: Decodable {
    let title: String
    let author: String
    let description: String
    let publishedAt: String
    let url: String
}

struct News : Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
