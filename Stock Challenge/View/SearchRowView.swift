//
//  SearchRowView.swift
//  Stock Challenge
//
//  Created by MacBook Pro (Tomasz) on 11/05/2021.
//

import SwiftUI

struct SearchRowView: View {
    
    var name = "Example"
    var symbol = "EXM"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 40)
                .cornerRadius(10)
            HStack {
                Text(name)
                    .foregroundColor(.white)
                Spacer()
                Text(symbol)
                    .foregroundColor(.white)
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
