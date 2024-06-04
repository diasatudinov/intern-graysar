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
                    Text("Алматы, завтра 07:00-09:00")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Text("улица Розыбакиева, 999, кв 11")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
                    .padding()
            }
        }
    }
}

#Preview {
    HeaderUIView()
}
