//
//  PriceCalculatorView.swift
//  PriceCalculator
//
//  Created by Merve Sena on 7.08.2024.
//

import SwiftUI

struct PriceCalculatorView: View {
    @State private var priceWithoutTax: String = ""
    @State private var selectedTaxRate: Double = 0
    @State private var priceWithTax: Double = 0

    let taxRates = [0.0, 0.01, 0.08, 0.10, 0.20]
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Price Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.top)
            
            Spacer()
            
            TextField("Enter the price without tax", text: $priceWithoutTax)
                .keyboardType(.decimalPad)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .padding(.horizontal)
                .onChange(of: priceWithoutTax, perform: { newValue in
                    priceWithoutTax = filterPriceInput(newValue)
                })
            
            Picker("Pick a Tax Rate", selection: $selectedTaxRate) {
                ForEach(taxRates, id: \.self) { rate in
                    Text("% \(rate * 100, specifier: "%.0f")")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
            .padding(.horizontal)
            
            Button(action: calculatePriceWithTax) {
                Text("Calculate Price with Tax")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(12)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 15) {
                 HStack {
                     Text("Price without Tax:")
                         .font(.headline)
                         .foregroundColor(.secondary)
                     Spacer()
                     Text("$\(priceWithoutTax)")
                         .font(.headline)
                         .foregroundColor(.primary)
                 }
                 
                 HStack {
                     Text("Tax Rate:")
                         .font(.headline)
                         .foregroundColor(.secondary)
                     Spacer()
                     Text("% \(selectedTaxRate * 100, specifier: "%.0f")")
                         .font(.headline)
                         .foregroundColor(.secondary)
                 }
                 
                 HStack {
                     Text("Price with Tax:")
                         .font(.title2)
                         .fontWeight(.bold)
                     Spacer()
                     Text(" $\(priceWithTax, specifier: "%.2f")")
                         .font(.title2)
                         .fontWeight(.bold)
                         .foregroundColor(.purple)
                 }
             }
             .padding()
             .background(Color(UIColor.secondarySystemBackground))
             .cornerRadius(12)
             .shadow(color: .gray, radius: 5, x: 0, y: 5)
             .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
    
    func calculatePriceWithTax() {
        let price = Double(priceWithoutTax.replacingOccurrences(of: ",", with: ".")) ?? 0
        priceWithTax = price * (1 + selectedTaxRate)
    }
    
    func filterPriceInput(_ input: String) -> String {
        let filtered = input.filter { "0123456789,".contains($0) }
        return filtered
    }
}

#Preview {
    PriceCalculatorView()
}
