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
    
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    @State private var provider = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            TextField("Price", text: $price).keyboardType(.decimalPad)
            TextField("Provider", text: $provider)
            
            Button("Save") {
                let newProduct = Product(context: viewContext)
                newProduct.id = UUID()
                newProduct.name = name
                newProduct.productDescription = description
                newProduct.price = Double(price) ?? 0.0
                newProduct.provider = provider
                
                try? viewContext.save()
            }
        }
    }
}
