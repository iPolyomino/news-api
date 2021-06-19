//
//  ContentView.swift
//  news-api
//
//  Created by 萩倉丈 on 2021/06/19.
//

import SwiftUI

struct ContentView: View {
    @State var articles : [Article] = []
    
    var body: some View {
        NavigationView {
            List(articles, id: \.title) { article in
                NavigationLink(
                    destination: NewsView(url: article.url),
                    label: {
                        Text(article.title)
                    })
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.fetch()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            })
            .navigationTitle("スポーツニュース")
        }.onAppear(perform: fetch)
    }
    
    private func fetch() {
        let NewsURL = "https://newsapi.org/v2/top-headlines?country=jp&category=sports&apiKey=\(API_KEY.NEWSAPI_KEY)"

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
            articles = news.articles
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
