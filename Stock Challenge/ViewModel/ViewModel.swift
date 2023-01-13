//
//  ViewModel.swift
//  Stock Challenge
//
//  Created by MacBook Pro (Tomasz) on 11/05/2021.
//

import Foundation

class ContentModel: ObservableObject {
    
    var search: String?
    
    @Published var company = Lookup()
    @Published var data = Data()
    @Published var listDisplay = [String]()
    @Published var value = [Double]()
    @Published var timeStamp = [Int]()
    
    init() {
        
    }
    
    func  searchData() {
        
        var urlComponents = URLComponents(string: "\(Constant.apiAddress)/search?")
        
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: search),
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
                            self.company = result
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
    
    
    func  getData(stock: String, i: Int) {
        
        var urlComponents = URLComponents(string: "\(Constant.apiAddress)/quote?")
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "symbol", value: stock),
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
                        let result = try decoder.decode(Data.self, from: data!)
                        
                        DispatchQueue.main.async { [self] in
                            self.data = result
                            if listDisplay.count != 0 {
                                if !listDisplay.contains(stock) {
                                    self.listDisplay.append(stock)
                                    self.value.append(self.data.c ?? 0)
                                    self.timeStamp.append(self.data.t ?? 0)
                                } else {
                                    if i < 0 {
                                        self.value[i] = self.data.c ?? 0
                                        self.timeStamp[i] = self.data.t ?? 0
                                    }
                                }
                            } else {
                                self.listDisplay.append(stock)
                                self.value.append(self.data.c ?? 0)
                                self.timeStamp.append(self.data.t ?? 0)
                            }
                        }
                        //print(result)
                        
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
    func removeFromList(item: Int) {
        listDisplay.remove(at: item)
        value.remove(at: item)
    }
    func reload() {
        for i in 0..<listDisplay.count {
            getData(stock: listDisplay[i], i: i)
        }
    }
}


