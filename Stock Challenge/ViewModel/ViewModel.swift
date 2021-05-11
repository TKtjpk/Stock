//
//  ViewModel.swift
//  Stock Challenge
//
//  Created by MacBook Pro (Tomasz) on 11/05/2021.
//

import Foundation

class ContentModel: ObservableObject {
    
    var input = ["AAPL", "GOOG"]
    
    @Published var stock = Lookup()
    
    init() {
        
        searchData()
    }
    
    func  searchData() {
        
        var urlComponents = URLComponents(string: "\(Constant.apiAddress)/search?")
        
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: "apple"),
            URLQueryItem(name: "token", value: "\(Constant.apiKey)")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            
            // Create url request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
            request.httpMethod = "GET"
            
            // Get url session
            let session = URLSession.shared
            
            // Create data task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                if error == nil{
                    do {
                        // Parse JSON
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Lookup.self, from: data!)
                        
                        DispatchQueue.main.async {
                            self.stock = result
                        }
                        print(result)
                        
                    }
                    catch {
                        print(error)
                    }
                    
                } else {
                    print("Cannot get data")
                }
            }
            dataTask.resume()
        }
    }
}
