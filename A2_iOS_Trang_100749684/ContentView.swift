//
//  ContentView.swift
//  A2_iOS_Trang_100749684
//
//  Created by Trang Nguyen on 2025-03-25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            List {
                ForEach(products, id: \.id) { product in
                    VStack(alignment: .leading) {
                        Text(product.name ?? "Unknown product name")
                            .font(.headline)
                        Text(product.productDescription ?? "No product description")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Product List")
        }
    }

    

    
}

#Preview {
    ContentView()
}
