//
//  ProductCellUIView.swift
//  intern-graysar
//
//  Created by Dias Atudinov on 04.06.2024.
//

import SwiftUI

struct ProductCellUIView: View {
    @EnvironmentObject var basketManager: BasketManager
    @State var isFavorite: Bool = false
    @State var productCount = 0.0
    @State var item: MenuItem
    let cellWidth = UIScreen.main.bounds.width/2.1
    init(item: MenuItem) {
        self.item = item
    }
    
    var body: some View {
            VStack(alignment: .center, spacing: 0){
                ZStack {
                    Color.clear
                    Image(item.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: cellWidth)
                        .cornerRadius(15)
                        .overlay(
                            Button {
                                basketManager.favoriteItemToggle(item)
                                isFavorite.toggle()
                            } label: {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(isFavorite ? .red : .black)
                                    .frame(width: 25)
                            }.offset(x: 70, y: -70)
                            
                        )
                    
                }.padding(.bottom, 10)
                HStack(alignment: .top) {
                    Text(item.name)
                        .font(.system(size: 10))
                        .lineLimit(2)
                    Spacer()
                }.frame(width: cellWidth,height: 25)
                
                HStack(spacing: 0) {
                    Text("\(item.price) ₸\(item.minQuantityText)").font(.system(size: 10)).foregroundColor(.gray.opacity(0.6))
                    Circle().frame(width: 2, height: 2).padding(.horizontal,5).foregroundColor(.green)
                    if item.minQuantity  == 1 {
                        Text("\(item.minQuantity, specifier: "%.0f") \(item.minQuantityText)").font(.system(size: 10)).foregroundColor(.green)
                    } else {
                        Text(" \(item.minQuantityText)").font(.system(size: 10)).foregroundColor(.green)
                    }
                    Spacer()
                }.padding(.bottom, 15).frame(width: cellWidth)
                
                HStack{
                    if item.count == 0 {
                        Button{
                            productCount += item.minQuantity
                            basketManager.addItem(item)
                            
                            basketManager.addToSumma(item, summa: Double(item.price))
                            
                            print(item.count)
                        } label: {
                            
                            HStack() {
                                Text("\(item.price) ₸").font(.system(size: 12)).foregroundColor(.black).bold()
                                Spacer()
                                Image(systemName: "plus").foregroundColor(.green).font(.system(size: 17))
                                
                            }
                            .padding(.horizontal, 10)
                            .padding(7)
                            
                        }
                    } else if item.count > 0 {
                        HStack {
                            Spacer()
                            Button{
                                if item.minQuantity  == 0 {
                                    productCount = 0
                                    basketManager.removeItem(item)
                                    basketManager.subFromSumma(item, summa: Double(item.price))
                                    print(item.count)
                                } else {
                                    productCount -= item.minQuantity
                                    basketManager.removeItem(item)
                                    basketManager.subFromSumma(item, summa: Double(item.price))
                                    print(item.count)
                                }
                            } label: {
                                
                                HStack(spacing: 10) {
                                    Image(systemName: "minus").foregroundColor(.white).font(.system(size: 17))
                                }
                                .padding(7)
                                
                            }
                            Spacer()
                            VStack {
                                
                                if item.minQuantity  == 1 {
                                    Text("\(productCount, specifier: "%.0f")").font(.system(size: 15)).foregroundColor(.white).bold()
                                } else {
                                    Text("\(productCount, specifier: "%.0f")").font(.system(size: 15)).foregroundColor(.white).bold()
                                }
                            }
                            Spacer()
                            Button{
                                if item.minQuantity  == 0 {
                                    
                                } else {
                                    productCount += item.minQuantity
                                    basketManager.addItem(item)
                                    basketManager.addToSumma(item, summa: Double(item.price))
                                    
                                    print(item.count)
                                }
                            } label: {
                                if item.minQuantity  == 0 {
                                    HStack(spacing: 10) {
                                        Image(systemName: "plus").foregroundColor(Color.green).font(.system(size: 17))
                                    }
                                    .padding(7)
                                } else {
                                    HStack(spacing: 10) {
                                        Image(systemName: "plus").foregroundColor(.white).font(.system(size: 17))
                                    }
                                    .padding(7)
                                }
                            }
                            Spacer()
                        }
                        
                    }
                }.background(item.count == 0 ? Color.gray.opacity(0.2) : Color.green)
                    .frame(width: cellWidth)
                    .cornerRadius(40)
                
                
                Spacer()
            }.onAppear {
                productCount = item.count
                isFavorite = item.isFavorite
            }
            .onChange(of: item.count) { newValue in
                productCount = newValue
            }
            .onChange(of: item.isFavorite) { newValue in
                print(newValue)
                isFavorite = newValue
            }
        
    }
}
