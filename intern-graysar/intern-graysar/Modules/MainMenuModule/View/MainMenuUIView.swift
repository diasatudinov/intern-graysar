//
//  MainMenuUIView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import SwiftUI
import UIKit


struct MainMenuUIView: View {
    
    
    @EnvironmentObject var basketManager: BasketManager
    @State var items: [MenuItem]
    @State private var headerOffset: CGFloat = 0
    @State private var isHeaderHidden = false
    
       
    
    
    var body: some View {
        ZStack{
            VStack {
                if !isHeaderHidden {
                    Button {
                        TheAppRouter.shared.move(to: .address, type: .present(animated: true))
                        
                    } label: {
                        HeaderUIView()
                            .frame(height: 50)
                            .offset(y: headerOffset < 0 ? headerOffset : 0)
                            .animation(.easeInOut)
                    }
                }
                ScrollView(showsIndicators: false){
                    
                    VStack(alignment: .leading) {
                        Text("Products")
                            .font(.title3).bold()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(items) { item in
                                    ProductCellUIView(item: item)
                                        //.frame(height: UIScreen.main.bounds.height/3)
                                        .onTapGesture {
                                            print(item.name)
                                            print(basketManager.items)
                                            print(basketManager.items.first?.count)
                                            TheAppRouter.shared.move(
                                                to: .productDetails(item: item, basketManager: basketManager),
                                                type: .present(animated: true)
                                            )
                                        }
                                }
                            }
                        }.padding(.bottom, 100)
                        HStack {
                            Spacer()
                            Text("New products coming soon")
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal,5)
                
            }
        }
    }
}

//#Preview {
//    MainMenuUIView(items: [])
//}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
