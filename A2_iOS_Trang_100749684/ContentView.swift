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
    
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(products, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        VStack(alignment: .leading) {
                            Text(product.name ?? "Unknown product name")
                                .font(.headline)
                            Text(product.productDescription ?? "No product description")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteProduct)
                
            }
            .navigationTitle("Product List")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: AddProductView()) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
            })
        }
    }
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter { $0.name?.contains(searchText) ?? false }
        }
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}

#Preview {
    ContentView()
}
