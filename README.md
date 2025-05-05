# Smart Laser

A Flutter application for managing customer information and laser equipment for Perfect Laser.

## Features

- Customer management via API integration
- View customer company details
- Track machine specifications and warranty information
- View support tickets and service history
- Display notifications and updates
- Mock data support for development

## API Integration

The application integrates with Perfect Laser's API to retrieve customer information:

```
https://csp.perfectlaser.co.za/api/clientapi/returncustomers?email={email}
```

### Authentication

The API uses Basic Authentication. For security reasons, actual credentials should be stored in environment variables or secure storage.

### CORS Handling

For web applications, CORS issues are handled by:
1. Setting appropriate headers in API requests
2. Configuring CSP in index.html
3. Using mock data for development when needed

## Mock Data Support

The application includes mock data support for development and testing purposes. When using the example email "hoedspruit@postnet.co.za", the application will use mock data to demonstrate functionality even when the API is not accessible.

## Getting Started

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone this repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

## Usage

1. Login with a customer email (e.g., hoedspruit@postnet.co.za)
2. Navigate through different sections using the sidebar menu
3. View company information, machines, tickets, and notifications

## Project Structure

The project follows a feature-based architecture:

```
lib/
  ├── core/            # Core configurations, providers, and router
  ├── data/            # Data layer with API services, repositories, and models
  ├── features/        # Feature modules (auth, dashboard, etc.)
  │   ├── auth/
  │   ├── company/
  │   ├── dashboard/
  │   ├── machines/
  │   ├── notifications/
  │   └── tickets/
  └── shared/          # Shared components and utilities
```

## Dependencies

- flutter_riverpod: State management
- go_router: Navigation
- dio: HTTP client for API calls
- shared_preferences: Local storage
