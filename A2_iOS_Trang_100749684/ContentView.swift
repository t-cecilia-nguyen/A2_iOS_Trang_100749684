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
                    .onChange(of: searchQuery) {
                        updateFetchRequest()
                    }
                
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
                    // swipe to delete
                    .onDelete(perform: deleteProduct)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Products List")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                        .foregroundColor(.blue)
                }
            }
            .navigationBarItems(trailing:
                                    NavigationLink(destination: AddProductView()) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
            })
        }
    }
    
    private func updateFetchRequest() {
        let predicate: NSPredicate?
        
        if searchQuery.isEmpty {
            predicate = nil // No filtering
        } else {
            // case-insensitive, diacritic insensitive comparison
            predicate = NSPredicate(format: "name CONTAINS[cd] %@ OR productDescription CONTAINS[cd] %@", searchQuery, searchQuery)
        }
        
        products.nsPredicate = predicate
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
