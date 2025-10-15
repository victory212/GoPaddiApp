//
//  Constants.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import Foundation
import UIKit

struct Constants {
    
    // MARK: - Colors
    struct Colors {
        static let primary = UIColor(red: 0.29, green: 0.56, blue: 0.89, alpha: 1.0) // #4A8FE2
        static let secondary = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0) // #F2F2F7
        static let accent = UIColor(red: 0.98, green: 0.49, blue: 0.29, alpha: 1.0) // #FA7D4A
        static let success = UIColor(red: 0.20, green: 0.78, blue: 0.35, alpha: 1.0) // #34C759
        static let error = UIColor(red: 1.00, green: 0.23, blue: 0.19, alpha: 1.0) // #FF3B30
        static let warning = UIColor(red: 1.00, green: 0.80, blue: 0.00, alpha: 1.0) // #FFCC00
        
        static let textPrimary = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.0) // #1C1C1E
        static let textSecondary = UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1.0) // #8E8E93
        static let background = UIColor.white
        static let cardBackground = UIColor.white
        static let border = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0) // #E0E0E0
    }
    
    // MARK: - Fonts
    struct Fonts {
        static func bold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
        
        static func semibold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        
        static func regular(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        static func medium(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .medium)
        }
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let button: CGFloat = 12
        static let card: CGFloat = 16
    }
    
    // MARK: - Animation
    struct Animation {
        static let short: TimeInterval = 0.2
        static let medium: TimeInterval = 0.3
        static let long: TimeInterval = 0.5
    }
    
    // MARK: - Strings
    struct Strings {
        static let appName = "TripPlanner"
        
        // Buttons
        static let save = "Save"
        static let cancel = "Cancel"
        static let delete = "Delete"
        static let edit = "Edit"
        static let create = "Create Trip"
        static let update = "Update Trip"
        
        // Placeholders
        static let destinationPlaceholder = "Enter destination"
        static let budgetPlaceholder = "Enter budget"
        static let travelersPlaceholder = "Number of travelers"
        static let descriptionPlaceholder = "Trip description (optional)"
        
        // Errors
        static let errorTitle = "Error"
        static let successTitle = "Success"
        static let networkError = "Network error occurred"
        static let validationError = "Please fill all required fields"
        
        // Success Messages
        static let tripCreated = "Trip created successfully!"
        static let tripUpdated = "Trip updated successfully!"
        static let tripDeleted = "Trip deleted successfully!"
    }
    
    // MARK: - Identifiers
    struct Identifiers {
        static let tripCell = "TripTableViewCell"
        static let homeToList = "showTripList"
        static let listToDetail = "showTripDetail"
        static let listToCreate = "showCreateTrip"
    }
}

// MARK: - UIColor Extension
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
