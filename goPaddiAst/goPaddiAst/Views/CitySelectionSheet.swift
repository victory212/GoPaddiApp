//
//  City.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 15/10/2025.
//


import SwiftUI


struct CitySelectionSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCity: String
    @State private var searchText = ""
    
    // Sample cities - you can expand this list
    let cities = [
        City(name: "Laghouat", country: "Algeria", countryCode: "DZ", flagEmoji: "🇩🇿"),
        City(name: "Lagos", country: "Nigeria", countryCode: "NG", flagEmoji: "🇳🇬"),
        City(name: "Doha", country: "Qatar", countryCode: "QA", flagEmoji: "🇶🇦"),
        City(name: "London", country: "United Kingdom", countryCode: "GB", flagEmoji: "🇬🇧"),
        City(name: "Paris", country: "France", countryCode: "FR", flagEmoji: "🇫🇷"),
        City(name: "New York", country: "United States", countryCode: "US", flagEmoji: "🇺🇸"),
        City(name: "Tokyo", country: "Japan", countryCode: "JP", flagEmoji: "🇯🇵"),
        City(name: "Dubai", country: "United Arab Emirates", countryCode: "AE", flagEmoji: "🇦🇪"),
        City(name: "Singapore", country: "Singapore", countryCode: "SG", flagEmoji: "🇸🇬"),
        City(name: "Sydney", country: "Australia", countryCode: "AU", flagEmoji: "🇦🇺"),
        City(name: "Toronto", country: "Canada", countryCode: "CA", flagEmoji: "🇨🇦"),
        City(name: "Berlin", country: "Germany", countryCode: "DE", flagEmoji: "🇩🇪"),
        City(name: "Rome", country: "Italy", countryCode: "IT", flagEmoji: "🇮🇹"),
        City(name: "Madrid", country: "Spain", countryCode: "ES", flagEmoji: "🇪🇸"),
        City(name: "Amsterdam", country: "Netherlands", countryCode: "NL", flagEmoji: "🇳🇱"),
    ]
    
    var filteredCities: [City] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { city in
                city.name.localizedCaseInsensitiveContains(searchText) ||
                city.country.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                Text("Please select a city")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                
                // Search Field
                HStack {
                    TextField("Search city", text: $searchText)
                        .font(.system(size: 16))
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 0.0, green: 0.48, blue: 1.0), lineWidth: 2)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                
                Divider()
                    .padding(.horizontal, 20)
                
                // City List
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(filteredCities) { city in
                            Button(action: {
                                selectedCity = city.name
                                dismiss()
                            }) {
                                HStack(spacing: 12) {
                                    // Location Icon
                                    Image(systemName: "location.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                        .frame(width: 24, height: 24)
                                    
                                    // City Info
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(city.name)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                                        
                                        Text(city.country)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                    }
                                    
                                    Spacer()
                                    
                                    // Flag and Country Code
                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text(city.flagEmoji)
                                            .font(.system(size: 24))
                                        
                                        Text(city.countryCode)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                                    }
                                }
                                .padding(.vertical, 16)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 56)
                        }
                    }
                }
                .background(Color.white)
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    CitySelectionSheet(selectedCity: .constant(""))
}
