//
//  AddressUIView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import SwiftUI

struct AddressUIView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                VStack(alignment: .center){
                    Text("Баланс")
                        .font(.system(size: 12, weight: .bold))
                }.padding()
                Spacer()
            }
            Spacer()
            List {
                Button{
                    print("Пополнить баланс")
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        VStack(alignment: .leading) {
                            Text("Пополнить баланс")
                                .font(.system(size: 12))
                        }
                        Spacer()
                    }
                }
                
                Button{
                    print("Поменять способ оплаты")
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "list.bullet")
                        VStack(alignment: .leading) {
                            Text("Поменять способ оплаты")
                                .font(.system(size: 12))
                        }
                    }
                }
            }.listStyle(.inset)
            
        }
    }
}

#Preview {
    AddressUIView()
}
