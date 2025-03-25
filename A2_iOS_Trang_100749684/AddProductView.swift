//
//  AddProductView.swift
//  A2_iOS_Trang_100749684
//
//  Created by Trang Nguyen on 2025-03-25.
//

import Foundation
import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    @State private var provider = ""
    @State private var showConfirmation = false // confirm save
    
    var body: some View {
        // Form to add products
        Form {
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            TextField("Price", text: $price).keyboardType(.decimalPad)
            TextField("Provider", text: $provider)
            
            Button("Add Product") {
                
            }
        }
    }
    
    private func addProduct() {
        guard let priceValue = Double(price) else { return }
        
        let newProduct = Product(context: viewContext)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.productDescription = description
        newProduct.price = priceValue
        newProduct.provider = provider
        
        do {
            try viewContext.save()
            clearForm() // reset form
            showConfirmation = true // show confirmation alert
        } catch {
            print("Error saving product: \(error.localizedDescription)")
        }
    }
    
    private func clearForm() {
        name = ""
        description = ""
        price = ""
        provider = ""
    }
}
