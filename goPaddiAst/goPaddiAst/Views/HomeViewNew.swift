//
//  HomeView.swift
//  goPaddiAst
//
//  Created by Victory Okoi on 15/10/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var showDatePicker = false
    @State private var isSelectingStartDate = true
    @State private var showCreateSheet = false
    @State private var showCityPicker = false  // NEW
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(red: 0.95, green: 0.96, blue: 0.97)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Header Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Plan Your Dream Trip in Minutes")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))
                        
                        Text("Build, personalize, and optimize your itineraries with our trip planner. Perfect for getaways, remote workcations, and any spontaneous escapade.")
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Image(.mainBg)
                        .resizable()
                        .frame(height: 400)
                        .clipped()
                        .overlay {
                            // Trip Planning Card
                            VStack(spacing: 16) {
                                // Destination Field
                                VStack(alignment: .leading, spacing: 8) {
                                    Button(action: {
                                        showCityPicker = true  // Show city picker
                                    }) {
                                        HStack(spacing: 12) {
                                            Image(systemName: "location")
                                                .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                                                .font(.system(size: 20))
                                            
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Where to ?")
                                                    .font(.system(size: 13))
                                                    .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                                                
                                                Text(destination.isEmpty ? "Select City" : destination)
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(destination.isEmpty ? Color(red: 0.45, green: 0.45, blue: 0.47) : .black)
                                            }
                                            
                                            Spacer()
                                        }
                                        .padding(16)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                // Date Fields
                                HStack(spacing: 12) {
                                    // Start Date
                                    Button(action: {
                                        isSelectingStartDate = true
                                        showDatePicker = true
                                    }) {
                                        HStack(spacing: 12) {
                                            Image(systemName: "calendar")
                                                .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                                                .font(.system(size: 20))
                                            
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Start Date")
                                                    .font(.system(size: 13))
                                                    .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                                                
                                                Text(formatDate(startDate))
                                                    .font(.system(size: 14, weight: .semibold))
                                                    .foregroundColor(.black)
                                            }
                                            
                                            Spacer()
                                        }
                                        .padding(16)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    // End Date
                                    Button(action: {
                                        isSelectingStartDate = false
                                        showDatePicker = true
                                    }) {
                                        HStack(spacing: 12) {
                                            Image(systemName: "calendar")
                                                .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                                                .font(.system(size: 20))
                                            
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("End Date")
                                                    .font(.system(size: 13))
                                                    .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                                                
                                                Text(formatDate(endDate))
                                                    .font(.system(size: 14, weight: .semibold))
                                                    .foregroundColor(.black)
                                            }
                                            
                                            Spacer()
                                        }
                                        .padding(16)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                
                                // Create a Trip Button
                                Button(action: {
                                    showCreateSheet = true  // Show sheet instead of navigate
                                }) {
                                    Text("Create a Trip")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(Color(red: 0.0, green: 0.48, blue: 1.0))
                                        .cornerRadius(12)
                                }
                            }
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.06), radius: 12, y: 4)
                            .padding(.horizontal, 20)
                        }
                    
                    Spacer(minLength: 40)
                }
            }
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheet(
                    selectedDate: isSelectingStartDate ? $startDate : $endDate,
                    title: isSelectingStartDate ? "Select Start Date" : "Select End Date",
                    isPresented: $showDatePicker
                )
            }
            .sheet(isPresented: $showCreateSheet) {
                CreateTripSheet()
            }
            .sheet(isPresented: $showCityPicker) {
                CitySelectionSheet(selectedCity: $destination)
            }
        }
    }
}

extension HomeView {
    private func formatDate(_ date: Date) -> String {
         let formatter = DateFormatter()
         formatter.dateFormat = "MMM dd, yyyy"
         return formatter.string(from: date)
     }
}

// Date Picker Sheet
struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    let title: String
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                
                Spacer()
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Done")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(red: 0.0, green: 0.48, blue: 1.0))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
