//
//  CreateTripSheet.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 15/10/2025.
//


import SwiftUI

struct CreateTripSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var tripName = ""
    @State private var travelStyle = ""
    @State private var tripDescription = ""
    @State private var showTravelStylePicker = false
    
    let travelStyles = ["Solo Travel", "Family Trip", "Adventure", "Relaxation", "Business", "Romantic Getaway"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.98, green: 0.98, blue: 0.98)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                // Plane icon
                                Image(systemName: "airplane")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(red: 0.0, green: 0.48, blue: 1.0))
                                    .padding(12)
                                    .background(Color(red: 0.9, green: 0.95, blue: 1.0))
                                    .cornerRadius(12)
                                
                                Spacer()
                                
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                                        .padding(8)
                                }
                            }
                            
                            Text("Create a Trip")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.top, 16)
                            
                            Text("Let's Go! Build Your Next Adventure")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            // Trip Name Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Trip Name")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                
                                TextField("Enter the trip name", text: $tripName)
                                    .font(.system(size: 15))
                                    .padding(16)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                                    )
                            }
                            
                            // Travel Style Dropdown
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Travel Style")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                
                                Button(action: {
                                    showTravelStylePicker = true
                                }) {
                                    HStack {
                                        Text(travelStyle.isEmpty ? "Select your travel style" : travelStyle)
                                            .font(.system(size: 15))
                                            .foregroundColor(travelStyle.isEmpty ? Color(red: 0.7, green: 0.7, blue: 0.7) : .black)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.47))
                                    }
                                    .padding(16)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            
                            // Trip Description
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Trip Description")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black)
                                
                                TextEditor(text: $tripDescription)
                                    .font(.system(size: 15))
                                    .frame(height: 120)
                                    .padding(12)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
                                    )
                                    .overlay(
                                        Group {
                                            if tripDescription.isEmpty {
                                                Text("Tell us more about this trip")
                                                    .font(.system(size: 15))
                                                    .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                                                    .padding(.top, 20)
                                                    .padding(.leading, 16)
                                                    .allowsHitTesting(false)
                                            }
                                        }
                                        , alignment: .topLeading
                                    )
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 40)
                        
                        // Next Button
                        Button(action: {
                            // Handle form submission
                            print("Trip Name: \(tripName)")
                            print("Travel Style: \(travelStyle)")
                            print("Description: \(tripDescription)")
                            dismiss()
                        }) {
                            Text("Next")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.0, green: 0.48, blue: 1.0))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(red: 0.85, green: 0.93, blue: 1.0))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            .confirmationDialog("Select Travel Style", isPresented: $showTravelStylePicker, titleVisibility: .visible) {
                ForEach(travelStyles, id: \.self) { style in
                    Button(style) {
                        travelStyle = style
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

#Preview {
    CreateTripSheet()
}