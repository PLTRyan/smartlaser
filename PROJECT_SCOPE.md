# 📘 SmartLaser Portal – Full Project Scope

## 🔍 Overview

SmartLaser Portal is a centralized, cross-platform dashboard (Flutter-based) designed for monitoring and managing industrial laser equipment. It empowers equipment owners and operators to streamline maintenance, track machine performance, access service history, and receive real-time alerts—all within a clean, user-friendly interface.

---

## 🎯 Core Objectives

- Provide real-time visibility into equipment health and performance
- Simplify maintenance and support workflows
- Enable access to historical data and documentation
- Offer seamless and secure user authentication
- Ensure scalable, maintainable, and testable code architecture

---

## ✅ In-Scope Features (MVP)

### 1. **User Authentication**
- Email-based sign-in based on API call
- Secure token storage
- Session persistence with re-authentication logic

### 2. **Dashboard Overview**
- Real-time performance metrics and system health
- Summary cards (e.g., total machines, active alerts, open tickets)
- Performance trend charts
- Alert banners and status summaries

### 3. **Company Profile Management**
- View and edit company name, address, contacts
- Upload company logo or branding asset

### 4. **Ticketing System**
- Submit new support or maintenance tickets
- List, filter, and view existing tickets
- View ticket timelines, status updates, and assigned technicians

### 5. **Machines & History**
- View all registered machines with search/filter
- View machine-specific service history
- Access downloadable warranty and service documents

### 6. **Notifications & Alerts**
- In-app alerts for:
  - Upcoming maintenance
  - New ticket responses
  - Critical performance alerts
- Future-ready for push notifications (Firebase Cloud Messaging stub)

---

## 🔧 Technical Scope

### 🧱 Tech Stack
- **Frontend:** Flutter (Web, Android, iOS)
- **State Management:** Riverpod (preferred) or Bloc
- **Routing:** GoRouter or auto_route
- **Networking:** Dio + Retrofit (REST API)
- **Testing:** Unit, Widget, and Integration Tests
- **CI/CD:** GitHub Actions + Firebase Hosting / App Distribution

### 📁 Project Structure
```

lib/
│
├── core/               # Global config, theming, utilities
├── features/           # Feature-based modules (auth, dashboard, etc.)
│   ├── auth/
│   ├── dashboard/
│   ├── company/
│   ├── tickets/
│   ├── machines/
│   └── notifications/
├── data/               # API layer, repositories, DTOs
├── shared/             # Reusable widgets, dialogs, etc.
└── main.dart

```

---

## 🚀 Phased Development Approach

### **Phase 0: Discovery & Planning**
- Finalize scope and wireframes
- Define API contracts and data models

### **Phase 1: Foundations**
- Flutter scaffold with folder structure and routing
- Theme system and dark mode
- API services and base repository patterns

### **Phase 2: Auth & Dashboard**
- Implement email login with token handling
- Build dashboard overview page with live data
- Implement UI cards and trend charts

### **Phase 3: Company & Tickets**
- CRUD for company profile
- Ticket list, filter, view, and submission flow

### **Phase 4: Machines & History**
- Machine list view with filters
- Detailed view of service history
- Warranty doc download integration

### **Phase 5: Notifications & Polish**
- In-app alerts
- Dark mode support
- Empty/error states
- UX optimizations

### **Phase 6: QA & Deployment**
- Unit and widget testing
- CI/CD pipelines for all platforms
- Staging and production deployment
- Handoff documentation

### **Phase 7: Post-Launch**
- Monitor performance & feedback
- Roadmap future features (e.g. predictive analytics, offline mode)

---

## 📌 Future Enhancements (Out-of-Scope for MVP)
- Predictive maintenance analytics
- Multi-role access control (admin, technician, viewer)
- Offline mode or data caching
- Deep-linking support for shared ticket/machine links

---

## 📄 Deliverables
- Flutter source code with clean architecture
- API integration (backend is pre-built)
- Deployment-ready build artifacts
- Project documentation and technical handover

---

## 👥 Target Users
- Laser equipment owners
- Operators and technical staff
- Service and support teams
```

