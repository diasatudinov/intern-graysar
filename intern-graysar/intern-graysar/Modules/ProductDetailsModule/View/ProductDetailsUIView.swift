//
//  ProductDetailsUIView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import SwiftUI

struct ProductDetailsUIView: View {
    @EnvironmentObject var basketManager: BasketManager

    @State var isFavorite: Bool = false
    @State var productCount = 0.0
    @State var kgPrice = 0.0
    let item: MenuItem
    
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Button {
                    TheAppRouter.shared.backFromSheet()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(width: 18)
                        .padding()
                }
                
                Spacer()
            }
            
            ScrollView {
                VStack {
                    ZStack {
                        Color.clear
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width)
                            .cornerRadius(15)
                        
                    }.padding(.bottom, 10)
                    
                    Text(item.name)
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 5)
                        .padding(.bottom, 5)
                    
                    Text("\(item.price) ₸\(item.minQuantityText)")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray.opacity(0.7))
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.bottom, 5)
                    HStack {
                        Text("Описание")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 10)
                            .padding(.bottom, 5)
                        Spacer()
                    }
                    Text(item.description)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 10)
                    
                    Divider().padding(10)
                    if item.storageConditions != "" {
                        DisclosureGroup {
                            HStack {
                                Text(item.storageConditions)
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray.opacity(0.8))
                                    .padding(.horizontal, 10)
                                Spacer()
                            }
                        } label: {
                            Text("Условия хранения")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .padding(.horizontal, 10)
                        }
                        Divider().padding(10)
                    }
                    if item.country != "" {
                        DisclosureGroup {
                            HStack {
                                Text(item.country)
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray.opacity(0.8))
                                    .padding(.horizontal, 10)
                                Spacer()
                            }
                        } label: {
                            Text("Страна")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                                .padding(.horizontal, 10)
                        }.padding(.bottom, 10)
                    }
                    
                }
                
            }
            
            
            ZStack{
                Color.green.ignoresSafeArea()
                HStack{
                    if productCount == 0 {
                        Button{
                            if item.minQuantity == 0 {
                                basketManager.addItem(item)
                                productCount = 1
                                basketManager.addToSumma(item, summa: Double(item.price))
                            } else {
                                basketManager.addItem(item)
                                productCount += item.minQuantity
                                basketManager.addToSumma(item, summa: Double(item.price))
                            }
                            
                        } label: {
                            
                            HStack(spacing: 7) {
                                VStack{
                                    Text("\(item.price) ₸").font(.system(size: 18)).foregroundColor(.white).bold()
                                    Text("за шт").font(.system(size: 10)).foregroundColor(.white).bold()
                                }
                                Image(systemName: "plus").foregroundColor(.white).font(.system(size: 25))
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            
                        }
                    } else if productCount > 0 {
                        HStack {
                            
                            Button{
                                if item.minQuantity == 0 {
                                    if productCount > 0 {
                                        basketManager.removeItem(item)
                                        productCount = 0
                                        basketManager.subFromSumma(item, summa: Double(item.price))
                                        
                                    }
                                } else {
                                    if productCount > 0 {
                                        basketManager.removeItem(item)
                                        productCount -= item.minQuantity
                                        basketManager.subFromSumma(item, summa: Double(item.price))
                                        
                                    }
                                }
                            } label: {
                                
                                HStack(spacing: 10) {
                                    Image(systemName: "minus").foregroundColor(.white).font(.system(size: 25))
                                }
                                
                            }
                            Spacer()
                            VStack {
                                Text("\(productCount*Double(item.price), specifier: "%.0f") ₸").font(.system(size: 25)).foregroundColor(.white).bold()
                                Text("\(productCount, specifier: "%.0f") шт").font(.system(size: 10)).foregroundColor(.white).bold()
                            }
                            Spacer()
                            Button{
                                if item.minQuantity == 0 {
                                    
                                } else {
                                    basketManager.addItem(item)
                                    productCount += item.minQuantity
                                    basketManager.addToSumma(item, summa: Double(item.price))
                                    
                                }
                            } label: {
                                if item.minQuantity  == 0 {
                                    HStack(spacing: 10) {
                                        Image(systemName: "plus").foregroundColor(.green).font(.system(size: 25))
                                    }
                                    
                                } else {
                                    
                                    HStack(spacing: 10) {
                                        Image(systemName: "plus").foregroundColor(.white).font(.system(size: 25))
                                    }
                                }
                                
                            }
                            
                        }.padding(.horizontal, 20)
                        
                    }
                }
            }.frame(height: UIScreen.main.bounds.height/14)
        }.onAppear {
            isFavorite = item.isFavorite
            productCount = item.count
        }
        .onChange(of: item.isFavorite) { newValue in
        
            print(item.isFavorite)
            print(newValue)
            isFavorite = newValue
            item.isFavorite = newValue
            
        }
    }
}

//#Preview {
//    ProductDetailsUIView(image: "item1", name: "Абрикосы кг", description: "Абрикос Шалах любим во многих странах, ведь его можно добавлять в любые десерты, делать коктейли, соки, варить компоты, в нем содержится большое количество микроэлементов, именно поэтому это фрукт показан при авитаминозе и анемии.", additionalDescription: "-20%", country: "Узбекистан", storageConditions: "от +4° до +8°", price: 3550, minQuantity: 0.5, minQuantityText: "кг")
//}
