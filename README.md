# TripPlanner iOS App

A modern iOS application for planning and managing trips, built with a hybrid approach using both SwiftUI and UIKit to demonstrate proficiency in both frameworks.

## 📱 About This Project

TripPlanner is a travel management app that allows users to create, view, edit, and delete trips. The app showcases a modern iOS development approach by combining SwiftUI for rapid UI development with programmatic UIKit for complex form handling.

### Technology Stack
- **SwiftUI**: Used for HomeView, TripListView, and TripDetailView (~70%)
- **UIKit (Programmatic)**: Used for CreateTripViewController (~30%)
- **Swift**: 5.7+
- **iOS**: 15.0+
- **API**: Beeceptor CRUD API for backend operations

## ✨ Features

- ✅ **Create Trips**: Add new trips with destination, dates, budget, and traveler information
- ✅ **View Trips**: Browse all your planned trips in a beautiful list
- ✅ **Trip Details**: View comprehensive information about each trip
- ✅ **Edit Trips**: Update trip information anytime
- ✅ **Delete Trips**: Remove trips you no longer need
- ✅ **Input Validation**: Form validation to ensure data quality
- ✅ **Error Handling**: User-friendly error messages
- ✅ **Loading States**: Visual feedback during API operations
- ✅ **Pull to Refresh**: Refresh trip list with a swipe
- ✅ **Responsive Design**: Adapts to different screen sizes

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have:
- macOS with Xcode 14.0 or later installed
- An active internet connection
- Basic familiarity with iOS development

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/TripPlanner.git
   cd TripPlanner
   ```

2. **Open in Xcode**
   ```bash
   open TripPlanner.xcodeproj
   ```
   Or double-click the `.xcodeproj` file

3. **Configure API Endpoint**
   
   Open `Services/APIService.swift` and update the base URL:
   ```swift
   private let baseURL = "https://YOUR-ENDPOINT.free.beeceptor.com"
   ```
   
   To get your Beeceptor endpoint:
   - Visit https://beeceptor.com/crud-api/
   - Create a free endpoint (e.g., "tripplanner-yourname")
   - Copy the generated URL

4. **Build and Run**
   - Select your target device or simulator (iPhone 14 Pro recommended)
   - Press `Cmd + R` or click the Run button
   - The app will build and launch

## 📡 API Integration

### API Endpoints

The app uses Beeceptor's CRUD API with the following endpoints:

#### 1. Get All Trips
```
GET /trips
```
**Response:**
```json
[
  {
    "_id": "123abc",
    "destination": "Paris",
    "startDate": "2025-10-20",
    "endDate": "2025-10-27",
    "budget": 2500.00,
    "travelers": 2,
    "description": "Romantic getaway",
    "status": "planned",
    "createdAt": "2025-10-15T10:00:00Z",
    "updatedAt": "2025-10-15T10:00:00Z"
  }
]
```

#### 2. Get Single Trip
```
GET /trips/{id}
```
**Response:** Single trip object

#### 3. Create Trip
```
POST /trips
Content-Type: application/json
```
**Request Body:**
```json
{
  "destination": "Tokyo",
  "startDate": "2025-11-05",
  "endDate": "2025-11-12",
  "budget": 3000.00,
  "travelers": 1,
  "description": "Cultural exploration",
  "status": "planned"
}
```
**Response:** Created trip object with generated ID

#### 4. Update Trip
```
PUT /trips/{id}
Content-Type: application/json
```
**Request Body:** Same as Create Trip
**Response:** Updated trip object

#### 5. Delete Trip
```
DELETE /trips/{id}
```
**Response:** 200 OK on success

### Data Model

The Trip model structure:

```swift
struct Trip: Codable {
    let id: String?              // Unique identifier (_id from API)
    let destination: String      // Trip destination (required)
    let startDate: String        // Format: "YYYY-MM-DD" (required)
    let endDate: String          // Format: "YYYY-MM-DD" (required)
    let budget: Double           // Trip budget in dollars (required)
    let travelers: Int           // Number of travelers (required)
    let description: String?     // Optional trip description
    let status: String?          // e.g., "planned", "ongoing", "completed"
    let createdAt: String?       // Timestamp
    let updatedAt: String?       // Timestamp
}
```

### Error Handling

The app handles various error scenarios:
- **Network Errors**: No internet connection
- **Server Errors**: API unavailable or returning errors
- **Validation Errors**: Invalid input data
- **Decoding Errors**: Unexpected API response format

All errors are presented to users with clear, actionable messages.

## 🏗 Project Architecture

### Hybrid SwiftUI + UIKit Approach

This project demonstrates expertise in both modern and traditional iOS development:

#### SwiftUI Components (~70%)
- **HomeView**: Welcome screen with feature overview
- **TripListView**: Displays all trips in a scrollable list
- **TripDetailView**: Shows detailed information about a trip

**Why SwiftUI?**
- Rapid development with declarative syntax
- Modern iOS development approach
- Excellent for list and detail views
- Built-in state management

#### UIKit Components (~30%)
- **CreateTripViewController**: Form for creating/editing trips (Programmatic UIKit)

**Why UIKit?**
- Complex form handling with multiple input types
- Fine-grained control over keyboard behavior
- Custom input validation and error states
- Date picker integration

### Project Structure

```
TripPlanner/
├── App/
│   ├── TripPlannerApp.swift        # SwiftUI App entry point
│   └── AppDelegate.swift           # UIKit configuration (if needed)
├── Models/
│   ├── Trip.swift                  # Trip data model
│   └── APIResponse.swift           # API response structures
├── Services/
│   └── APIService.swift            # Networking layer (works with both SwiftUI & UIKit)
├── SwiftUI Views/
│   ├── HomeView.swift              # Welcome/landing screen
│   ├── TripListView.swift          # List of all trips
│   └── TripDetailView.swift        # Individual trip details
├── UIKit ViewControllers/
│   └── CreateTripViewController.swift  # Trip creation form (Programmatic)
├── Wrappers/
│   └── CreateTripWrapper.swift     # Bridge between SwiftUI and UIKit
├── Utilities/
│   └── Constants.swift             # App-wide constants and styling
└── Resources/
    └── Assets.xcassets             # Images and colors
```

### Key Design Decisions

1. **SwiftUI for Display**: Used SwiftUI for views that primarily display data (Home, List, Detail)
2. **UIKit for Forms**: Used programmatic UIKit for the complex form screen with multiple input types
3. **Shared Services**: APIService works seamlessly with both SwiftUI and UIKit
4. **State Management**: SwiftUI's `@State` and `@StateObject` for reactive UI updates
5. **Navigation**: NavigationStack (SwiftUI) with UIViewControllerRepresentable for UIKit integration

## 🎨 UI/UX Features

### Design Principles
- **Clean & Modern**: Minimalist interface with focus on content
- **Consistent**: Unified color scheme and typography
- **Intuitive**: Clear navigation and user flows
- **Responsive**: Adapts to different device sizes
- **Feedback**: Loading states, animations, and success/error messages

### Color Palette
- **Primary**: Blue (#4A8FE2) - Actions and highlights
- **Accent**: Orange (#FA7D4A) - Budget and important info
- **Success**: Green (#34C759) - Confirmations
- **Error**: Red (#FF3B30) - Errors and deletions
- **Background**: White with subtle grays

### Typography
- **Titles**: System Bold 28-36pt
- **Body**: System Regular 16pt
- **Captions**: System Regular 14pt

## 🧪 Testing the App

### Manual Testing Checklist

#### Home Screen
- [ ] App launches without crashes
- [ ] Welcome message displays correctly
- [ ] Navigation to trip list works
- [ ] Animations are smooth

#### Trip List
- [ ] Empty state shows when no trips
- [ ] Trips load from API
- [ ] Pull to refresh works
- [ ] Tap on trip navigates to detail
- [ ] Create button opens form

#### Create/Edit Trip
- [ ] All form fields are present
- [ ] Date pickers work correctly
- [ ] Validation prevents empty submission
- [ ] Success message on creation
- [ ] Returns to list after save

#### Trip Detail
- [ ] All trip information displays
- [ ] Edit button opens form with data
- [ ] Delete shows confirmation
- [ ] Navigation works correctly

#### Error Scenarios
- [ ] Offline mode shows error message
- [ ] Invalid API response handled gracefully
- [ ] Form validation works

### Testing Different Devices

Recommended test devices:
- iPhone SE (small screen)
- iPhone 14 Pro (standard)
- iPhone 14 Pro Max (large screen)
- iPad (if supporting)

## 🐛 Troubleshooting

### Common Issues

#### App Crashes on Launch
**Problem**: Fatal error on startup
**Solution**: 
- Clean build folder (Cmd + Shift + K)
- Delete derived data
- Restart Xcode

#### API Calls Failing
**Problem**: Network requests return errors
**Solution**:
- Verify internet connection
- Check API endpoint URL in APIService.swift
- Ensure Info.plist has App Transport Security settings
- Test API endpoint in browser or Postman

#### Empty Trip List
**Problem**: Trips don't appear
**Solution**:
- Check console for error messages
- Verify API is returning data
- Test API endpoint independently
- Check data decoding logic

#### Form Validation Issues
**Problem**: Can't submit valid data
**Solution**:
- Verify all required fields are filled
- Check date format (YYYY-MM-DD)
- Ensure budget is numeric
- Travelers count must be positive

## 📦 Building for TestFlight

### Archive Steps

1. **Select Device**
   - Choose "Any iOS Device (arm64)" from device menu

2. **Archive**
   - Product > Archive
   - Wait for archive to complete

3. **Distribute**
   - Select archive in Organizer
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Upload to App Store Connect

4. **TestFlight**
   - Log in to App Store Connect
   - Navigate to TestFlight tab
   - Wait for processing (10-30 minutes)
   - Add testers and distribute

## 📋 Implementation Notes

### Trade-offs & Decisions

**SwiftUI vs UIKit Choice:**
- Used SwiftUI for 70% of views (faster development, modern approach)
- Used UIKit for complex form (better control, custom validation)
- Both approaches demonstrate versatility

**API Choice:**
- Beeceptor chosen for simplicity and no-auth setup
- Easy to switch to production API later

**State Management:**
- SwiftUI's built-in state management for simplicity
- Could scale to Combine or Redux pattern if needed

### Known Limitations

1. **No Offline Support**: Requires internet connection
2. **No Image Upload**: Text-based trips only
3. **Limited Search**: No filtering or search functionality
4. **No User Auth**: Single user application

### Future Enhancements

If I had more time, I would add:
- [ ] User authentication and profiles
- [ ] Image upload for destinations
- [ ] Map integration for locations
- [ ] Itinerary planning within trips
- [ ] Budget breakdown and tracking
- [ ] Sharing trips with others
- [ ] Offline mode with Core Data
- [ ] Push notifications for trip reminders
- [ ] Search and filter functionality

### Tools Used
- Xcode 26.0
- SwiftUI
- UIKit
- Beeceptor API
- Git/GitHub

