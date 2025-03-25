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
    
    @State private var searchQuery = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for products...", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List {
                    ForEach(products, id: \.id) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            VStack(alignment: .leading) {
                                Text(product.name ?? "Unknown product name")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Text(product.productDescription ?? "No product description")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteProduct)                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Products List")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
            .navigationBarItems(trailing:
                                    NavigationLink(destination: AddProductView()) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
            })
        }
    }
    
    var filteredProducts: [Product] {
        if searchQuery.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.name?.lowercased().contains(searchQuery.lowercased()) ?? false) ||
                ($0.productDescription?.lowercased().contains(searchQuery.lowercased()) ?? false)
            }
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
