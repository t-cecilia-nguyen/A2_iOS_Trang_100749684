//
//  ProductDetailView.swift
//  A2_iOS_Trang_100749684
//
//  Created by Trang Nguyen on 2025-03-25.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.name ?? "Unknown Product")
                .font(.largeTitle)
            Text("Description: \(product.productDescription ?? "No description")")
            Text("Price: $\(product.price, specifier: "%.2f")")
            Text("Provider: \(product.provider ?? "No provider")")
            Spacer()
        }
        .padding()
        .navigationTitle("Product Details")
    }
}
