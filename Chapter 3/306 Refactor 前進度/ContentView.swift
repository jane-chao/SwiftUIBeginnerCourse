//
//  ContentView.swift
//  FoodPicker
//
//  Created by Jane Chao on 22/09/14.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFood: Food?
    @State private var shouldShowInfo: Bool = false
    
    let food = Food.examples
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                foodImage
                
                Text("今天吃什麼？").bold()
                
                selectedFoodInfoView
                
                Spacer().layoutPriority(1)
                
                selectFoodButton
                
                cancelButton
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height - 100)
            .font(.title)
            .mainButtonStyle()
            .animation(.mySpring, value: shouldShowInfo)
            .animation(.myEase, value: selectedFood)
        }.background(.bg2)
    }
}

// MARK: - Subviews
private extension ContentView {
    var foodImage: some View {
        Group {
            if let selectedFood {
                Text(selectedFood.image)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    
            } else {
                Image("dinner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }.frame(height: 250)
    }
    
    var foodNameView: some View {
        HStack {
            Text(selectedFood!.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.green)
                .id(selectedFood!.name)
                .transition(.delayInsertionOpacity)
            Button {
                shouldShowInfo.toggle()
            } label : {
                Image(systemName: "info.circle.fill").foregroundColor(.secondary)
            }.buttonStyle(.plain)
        }
    }
    
    var foodDetailView: some View {
        VStack {
            if shouldShowInfo {
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    GridRow {
                        Text("蛋白質")
                        Text("脂肪")
                        Text("碳水")
                    }.frame(minWidth: 60)
                    
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .padding(.horizontal, -10)
                    
                    GridRow {
                        Text(selectedFood!.$protein)
                        Text(selectedFood!.$fat)
                        Text(selectedFood!.$carb)
                    }
                }
                .font(.title3)
                .padding(.horizontal)
                .padding()
                .roundedRectBackground()
                .transition(.moveUpWithOpacity)
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
    
    @ViewBuilder var selectedFoodInfoView: some View {
        if let selectedFood {
            foodNameView
            
            Text("熱量 \(selectedFood.$calorie)").font(.title2)
            
            foodDetailView
        }
    }
    
    var selectFoodButton: some View {
        Button {
            selectedFood = food.shuffled().first { $0 != selectedFood }
        } label: {
            Text(selectedFood == .none ? "告訴我" : "換一個").frame(width: 200)
                .animation(.none, value: selectedFood)
                .transformEffect(.identity)
        }.padding(.bottom, -15)
    }
    
    var cancelButton: some View {
        Button {
            selectedFood = .none
            shouldShowInfo = false
        } label: {
            Text("重置").frame(width: 200)
        }.buttonStyle(.bordered)
    }
}

extension ContentView {
    init(selectedFood: Food) {
        _selectedFood = State(wrappedValue: selectedFood)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedFood: .examples.first!)
        ContentView(selectedFood: .examples.first!).previewDevice(.iPad)
        ContentView(selectedFood: .examples.first!).previewDevice(.iPhoneSE)
    }
}
