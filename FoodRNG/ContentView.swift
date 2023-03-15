//
//  ContentView.swift
//  FoodRNG
//
//  Created by Christopher Yoon on 3/15/23.
//

import SwiftUI

struct Food: Identifiable {
    var id = UUID().uuidString
    let name: String
    let imageName: String
    let price: Double
    let calories: Int
}
let foods: [Food] = [
    Food(name: "Cheeseburger", imageName: "Cheeseburger", price: 1.34, calories: 200),
    Food(name: "Steak", imageName: "Steak", price: 1.34, calories: 200),
    Food(name: "Hotdog", imageName: "Hotdog", price: 1.34, calories: 200),
    Food(name: "Cake", imageName: "Cake", price: 1.34, calories: 200),
    Food(name: "Cookies", imageName: "Cookies", price: 1.34, calories: 200),
    Food(name: "Ice Cream", imageName: "Ice Cream", price: 1.34, calories: 200),
]
struct ListRowView: View {
    let food: Food
    let frameScale: CGFloat = 100
    var body: some View {
        HStack {
            Image(food.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: frameScale, height: frameScale)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(food.name)
            Spacer()
        }
    }
}
struct ContentView: View {
    @State var index = 1
    @State var isSheetOpen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(foods) { food in
                    NavigationLink {
                        DetailView(food: food)
                    } label: {
                        ListRowView(food: food)
                    }
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Recommend") {
                        index = Int.random(in: 0..<foods.count)
                        isSheetOpen = true
                    }
                    .sheet(isPresented: $isSheetOpen) {
                        NavigationStack {
                            DetailView(food: foods[index])
                        }
                    }
                }
            }
            .navigationTitle("Random Food")
        }
    }
}

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    var food: Food
    var body: some View {
        VStack {
            Spacer()
            Image(food.imageName)
                .resizable()
                .scaledToFit()
                .overlay(
                    overlayText
                )
            Spacer()
            Text(food.name)
            Text("Price: \(food.price, format: .currency(code: "USD"))")
            Text("Calories: \(food.calories)")
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("dismiss") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Random Food")
    }
    
    var overlayText: some View {
        VStack {
            HStack {
                Text(food.name)
                    .font(.title)
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.3))
                    )
                    .padding(4)
                Spacer()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
