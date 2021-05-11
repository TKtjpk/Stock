//
//  SearchView.swift
//  Stock Challenge
//
//  Created by MacBook Pro (Tomasz) on 11/05/2021.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var list: ContentModel
    
    @State var search: String = ""
    @State var isEditing = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack {
                    
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .frame(height: 50)
                            .padding(.horizontal, 5)
                        TextField("Stock request.: apple or AAPL", text: $search) {isEditing in
                            self.isEditing = isEditing
                        } onCommit: {
                            list.search = self.search
                            list.searchData()
                        }
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .font(.title)
                    }
                    
                    ScrollView (showsIndicators: false ) {
                        
                        LazyVStack {
                            
                            if list.search != nil {
                                ForEach (0..<list.company.result!.count, id: \.self) { item in
                                    SearchRowView(name: list.company.result![item].description!, symbol: list.company.result![item].displaySymbol!)
                                    
                                    
                                }
                            }
                        }
                        
                    }
                }
                
            }
            .navigationBarTitle(list.search != nil  ? "\(list.company.count! > 0 ? String(list.company.count!) : "") \(list.company.count! < 1 ? "no results" :  list.company.count! > 1 ? "companies found" : "company found")" : "", displayMode: .automatic)
            
            
        }
        
        .accentColor(.gray)
        .padding(.horizontal)
    }
}
