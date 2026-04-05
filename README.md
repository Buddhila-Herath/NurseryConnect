# NurseryConnect MVP 🧭

**NurseryConnect** is a specialized iOS application designed for nursery keyworkers (Early Years Practitioners). It provides a seamless, offline-first experience for tracking children's daily activities, including meals, sleep, mood, and health-related events.

## 🎯 Key Features

### 👤 My Children Dashboard
- **Real-time Overview**: View a list of all assigned children (Noah, Lily, Oliver).
- **Search & Filter**: Quickly find children by name.
- **Health Alerts**: Immediate visual indicators for children with registered allergies.
- **Daily Progress**: Smart badges highlight children missing diary entries for today.

### 📅 Child Diary Timeline
- **Chronological Tracking**: A clean, color-coded timeline of all daily events.
- **Activity Types**: Specialized tracking for Meals, Sleep, Nappy, Mood, and Activities.
- **Smart Filtering**: Toggle between "Today Only" and "Full History" views.
- **Emergency Access**: Quick-action button to view emergency contact details.

### 📝 Add Diary Entry (Dynamic Form)
- **Conditional UI**: Form adapts for Meals (Food/Portion), Sleep (Times), or Nappy (Type).
- **Validation**: Alerts ensure critical data is captured before saving.

---

## 🛠 Technical Stack

- **Platform**: iOS 17.0+ (SwiftUI)
- **Database**: SwiftData (Local, Offline-first)
- **Architecture**: Lightweight MVVM
- **Testing**: XCTest with in-memory SwiftData configuration.

---

## 📁 Project Structure & Files

### 📂 App/
- **NurseryConnectApp.swift**: Entry point. Initializes SwiftData and handles seeding.

### 📂 Models/
- **Child.swift**: `Child` entity (Name, Age, Allergies, Emergency Contact).
- **DiaryEntry.swift**: `DiaryEntry` entity and `EntryType` enum.

### 📂 ViewModels/
- **ChildViewModel.swift**: Dashboard logic (Search, status computation).
- **DiaryViewModel.swift**: Timeline logic (Filtering, adding/deleting entries).

### 📂 Views/
- **MyChildrenView.swift**: Main dashboard screen.
- **ChildDiaryView.swift**: Timeline view for a specific child.
- **AddEntryView.swift**: Dynamic form for adding activities.
- **Components/**: Reusable views like `ChildRow` and `DiaryEntryRow`.

### 📂 Data/
- **SampleData.swift**: Seeding logic for initial testing.

### 📂 NurseryConnectTests/
- **DiaryViewModelTests.swift**: Unit tests for business logic.

---

## ⚙️ Setup Instructions (Xcode 15+)

1. **Create Project**: Create a new iOS App project in Xcode called `NurseryConnect`.
2. **Settings**: Set **Interface** to `SwiftUI` and **Language** to `Swift`.
3. **Minimum target**: Ensure **Minimum Deployments** is set to **iOS 17.0**.
4. **Import Files**: 
   - Delete the default `ContentView.swift` and `NurseryConnectApp.swift`.
   - Right-click your project folder and select **Add Files to "NurseryConnect"...**
   - Select all the folders (`App`, `Models`, `ViewModels`, `Views`, `Data`, `Utils`, `NurseryConnectTests`) from this directory.
5. **Run**: Select an iOS 17 Simulator and press **Cmd + R**.

---

## 🧪 Verification & Walkthrough

- [x] **Sample Data**: Noah, Lily, and Oliver appear correctly on first launch.
- [x] **Navigation**: Smooth transitions between list and diary views.
- [x] **Adding Entries**: New entries save and update the UI instantly.
- [x] **Validation**: Error alerts trigger if required fields (like Food) are missing.
- [x] **Emergency Contact**: Correct contact info shows in the emergency alert.
- [x] **Unit Tests**: Pass for entry addition, deletion, and date filtering.

---
*Built with ❤️ for Early Years Practitioners.*
