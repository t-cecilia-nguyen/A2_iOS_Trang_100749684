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
    @State private var errorMessage = ""
    @State private var showErrorAlert = false // Alerts for errors
    
    
    var body: some View {
        // Form to add products
        Form {
            Section(header: Text("Product Info")) {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                TextField("Price", text: $price).keyboardType(.decimalPad)
                TextField("Provider", text: $provider)
            }
            
            Button("Add Product") {
                validateForm()
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
               )
            }
            
        }
        .navigationTitle("Add a Product")
        .foregroundColor(.blue)
        .alert(isPresented: $showConfirmation) {
            Alert(
                title: Text("Success"),
                message: Text("Product successfully added."),
                dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss() // Navigate back to Product List(ContentView)
                })
            )
        }
    }
    
    private func validateForm() {
        guard !name.isEmpty else {
            errorMessage = "Product name is required."
            showErrorAlert = true
            return
        }
        
        guard !price.isEmpty else {
            errorMessage = "Price is required"
            showErrorAlert = true
            return
        }
        
        guard let priceValue = Double(price) else {
            errorMessage = "Price must be a valid number."
            showErrorAlert = true
            return
        }
        
        // If all validations pass, proceed to add product
        addProduct(price: priceValue)
    }
    
    private func addProduct(price: Double) {
        let newProduct = Product(context: viewContext)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.productDescription = description
        newProduct.price = price
        newProduct.provider = provider
        
        do {
            try viewContext.save()
            clearForm() // reset form
            showConfirmation = true // show success alert
        } catch {
            errorMessage = "Error saving product: \(error.localizedDescription)"
            showErrorAlert = true // show error message alert
        }
    }
    
    private func clearForm() {
        name = ""
        description = ""
        price = ""
        provider = ""
    }
}
