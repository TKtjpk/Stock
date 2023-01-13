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
    @State var edit = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack {
                    List {
                        if list.value.count > 0 {
                            ForEach (0..<list.value.count, id: \.self) { item in
                                HStack {
                                    Text(list.listDisplay[item])
                                    VStack (alignment: .leading){
                                        Text("min \(list.listDisplay[item])")
                                            .font(.caption2)
                                        Text("max \(list.listDisplay[item])")
                                            .font(.caption2)
                                    }
                                    Spacer()
                                    edit ?  Button(action: {
                                        list.removeFromList(item: item)
                                        edit = false
                                    }, label: {
                                        Text("Delete")
                                    })
                                    .disabled(false) : Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("\(list.value[item]) $")
                                    })
                                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                }
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .bottomBar)  {
                            Button("Edit") {
                                edit = true
                            }
                            .disabled(edit ? true : false)
                        }
                        ToolbarItem(placement: .bottomBar)  {
                            Spacer()
                        }
                        ToolbarItem(placement: .bottomBar ) {
                            Button("Reload") {
                                list.reload()
                            }
                        }
                        ToolbarItem(placement: .bottomBar)  {
                            Spacer()
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button("Close") {
                                edit = false
                            }
                            .disabled(edit ? false : true)
                        }
                    }
                    .disabled(list.value.count > 0 ? false : true)
                    .listRowBackground(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .navigationTitle(Text("\(list.listDisplay.count) \(list.listDisplay.count > 1 || list.listDisplay.count == 0 ? "elements" : "element") listed"))
                    
                    ScrollView (showsIndicators: false ) {
                        
                        LazyVStack {
                            
                            if list.search != nil {
                                ForEach (0..<list.company.result!.count, id: \.self) { item in
                                    let string = list.company.result![item].symbol
                                    if (!(string!.contains("."))) {
                                        
                                        Button(
                                            action: {
                                                list.getData(stock: list.company.result![item].symbol!, i: item)
                                            }, label: {
                                                SearchRowView(name: list.company.result![item].description!, displaySymbol: list.company.result![item].displaySymbol!, type: list.company.result![item].type!, symbol: list.company.result![item].symbol!)
                                            })
                                    }
                                }
                            }
                        }
                    }
                    
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
                }
                .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
            }
        }
        .accentColor(.gray)
        .padding(.horizontal)
    }
}

struct CheckView: View {
   @State var isChecked:Bool = false
   var title:String
   func toggle(){isChecked = !isChecked}
   var body: some View {
       Button(action: toggle){
           HStack{
               Image(systemName: isChecked ? "checkmark.square": "square")
               Text(title)
           }

       }

   }
}
