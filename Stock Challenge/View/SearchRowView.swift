//
//  SearchRowView.swift
//  Stock Challenge
//
//  Created by MacBook Pro (Tomasz) on 11/05/2021.
//

import SwiftUI

struct SearchRowView: View {
    
    var name = "Example"
    var displaySymbol = "EXM"
    var type = "Common Stock"
    var symbol = "EXM"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 50)
                .cornerRadius(10)
                .shadow(radius: 5)
            VStack {
                HStack {
                    Text(name)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Spacer()
                    Text(symbol)
                        .foregroundColor(.white)
                }
                
                HStack {
                    Text(type)
                        .foregroundColor(.white)
                        .font(.footnote)
                    Spacer()
                    
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRowView()
    }
}


