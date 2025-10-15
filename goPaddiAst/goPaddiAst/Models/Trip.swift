//
//  Trip.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import Foundation


struct Trip: Codable {
    let id: String?
    let destination: String
    let startDate: String
    let endDate: String
    let budget: Double
    let travelers: Int
    let description: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case destination
        case startDate
        case endDate
        case budget
        case travelers
        case description
        case status
        case createdAt
        case updatedAt
    }
    
    init(id: String? = nil,
         destination: String,
         startDate: String,
         endDate: String,
         budget: Double,
         travelers: Int,
         description: String? = nil,
         status: String? = "planned",
         createdAt: String? = nil,
         updatedAt: String? = nil) {
        self.id = id
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.budget = budget
        self.travelers = travelers
        self.description = description
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    // Helper computed properties
    var formattedBudget: String {
        return String(format: "$%.2f", budget)
    }
    
    var travelersText: String {
        return travelers == 1 ? "1 Traveler" : "\(travelers) Travelers"
    }
    
    var dateRange: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let start = formatter.date(from: startDate),
           let end = formatter.date(from: endDate) {
            formatter.dateFormat = "MMM dd"
            let startStr = formatter.string(from: start)
            formatter.dateFormat = "MMM dd, yyyy"
            let endStr = formatter.string(from: end)
            return "\(startStr) - \(endStr)"
        }
        return "\(startDate) - \(endDate)"
    }
}

// MARK: - API Response Models
struct APIResponse<T: Codable>: Codable {
    let data: T?
    let message: String?
    let success: Bool?
}

struct TripsResponse: Codable {
    let trips: [Trip]
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case trips = "data"
        case total
    }
}

struct TripResponse: Codable {
    let trip: Trip
    
    enum CodingKeys: String, CodingKey {
        case trip = "data"
    }
}

// MARK: - Create Trip Request
struct CreateTripRequest: Codable {
    let destination: String
    let startDate: String
    let endDate: String
    let budget: Double
    let travelers: Int
    let description: String?
    let status: String?
    
    init(destination: String,
         startDate: String,
         endDate: String,
         budget: Double,
         travelers: Int,
         description: String? = nil,
         status: String? = "planned") {
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.budget = budget
        self.travelers = travelers
        self.description = description
        self.status = status
    }
}
