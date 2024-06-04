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
                    Text("Доставка")
                        .font(.system(size: 12, weight: .bold))
                        .padding(5)
                    Text("Сегодня 07:00-09:00")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }.padding()
                Spacer()
            }
            Spacer()
            List {
                Button{
                    print("Добавить новый адрес")
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        VStack(alignment: .leading) {
                            Text("Добавить новый адрес")
                                .font(.system(size: 12))
                            Text("Весь список адресов")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                }
                
                Button{
                    print("Выбрать другой город")
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "list.bullet")
                        VStack(alignment: .leading) {
                            Text("Выбрать другой город")
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
