//
//  HeaderUIView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import SwiftUI

struct HeaderUIView: View {
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment: .leading){
                    Text("Ваш баланс: 45 000₸")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                }
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
                    .padding()
            }.padding(.horizontal, 5)
        }
    }
}

#Preview {
    HeaderUIView()
}
