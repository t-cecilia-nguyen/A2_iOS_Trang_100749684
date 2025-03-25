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
        VStack(alignment: .leading, spacing: 10) {
            Text(product.name ?? "Unknown Product")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Text("Description: \(product.productDescription ?? "No description")")
            Text("Price: $\(product.price, specifier: "%.2f")")
            Text("Provider: \(product.provider ?? "No provider")")
        }
        .padding(.top, 50)
        Spacer()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Product Details")
                    .font(.largeTitle.bold())
                    .accessibilityAddTraits(.isHeader)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
        }
    }
}
