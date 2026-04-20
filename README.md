# kidsapp

kidsapp is an iOS SwiftUI application for recording and reviewing daily nursery diary updates per child.

The app is offline-first and uses SwiftData for local persistence. It includes seeded sample data so the app is usable immediately on first launch.

## Overview

This project helps early years practitioners track day-to-day child activities in a structured timeline.

Core goals:

- Keep a clear list of assigned children
- Show allergy and daily update signals at a glance
- Record diary entries quickly with type-specific input forms
- Review entries in chronological order with optional "today only" filtering

## Features

### My Children Dashboard

- Lists all children sorted by name
- Search by child name using a built-in search bar
- Shows allergy warning icon on child rows
- Shows a blue missing-entry indicator when no entry exists for today
- Opens each child profile into their diary timeline

### Child Diary Screen

- Displays child profile header (avatar, name, age)
- Shows allergy banner for children with allergies
- Supports emergency contact action via alert
- Timeline section displays entries newest-first
- Toggle to switch between "Show Today Only" and full history
- Swipe-to-delete for each diary record

### Add Entry Screen

- Activity types: Meal, Sleep, Nappy, Mood, Activity
- Dynamic form fields by type:
   - Meal: food and portion
   - Sleep: start and end time
   - Nappy: nappy type
- Optional notes field for all types
- Validation for required meal food input
- Saves to SwiftData and dismisses on success

## Technical Stack

- Language: Swift
- UI: SwiftUI
- Persistence: SwiftData
- Architecture: Lightweight MVVM with observable view models
- Target platform: iOS (SwiftData requires modern iOS; use iOS 17+)

## Architecture

### App Entry

- kidsappApp sets up the SwiftData model container with Child and DiaryEntry models
- Seeds initial sample data asynchronously on first launch

### Data Models

- Child:
   - id (unique UUID)
   - name
   - age
   - allergies [String]
   - emergencyContact
   - avatar
   - diaryEntries relationship (cascade delete)

- DiaryEntry:
   - id (unique UUID)
   - type (EntryType enum)
   - timestamp
   - note
   - Optional meal fields: food, portion
   - Optional sleep fields: startTime, endTime
   - Optional nappy field: nappyType
   - Optional child reference

- EntryType enum values:
   - meal
   - sleep
   - nappy
   - mood
   - activity

### View Models

- ChildViewModel:
   - Handles search filtering on child list
   - Computes "missing today entry" state for dashboard indicators

- DiaryViewModel:
   - Provides sorted timeline entries
   - Applies "today only" filter
   - Handles add and delete operations for entries

### Reusable Utilities

- Date extension for formatted time/date and isToday helper
- Color extension for entry-type colors
- Shake geometry effect included for potential UI feedback animation

## Seed Data Behavior

On first app launch (only if no children exist), the app inserts:

- Noah (age 3, allergy: peanuts)
- Lily (age 2, allergy: dairy)
- Oliver (age 4, no listed allergies)

It also inserts initial diary entries for Noah:

- Meal entry (Pasta, Full)
- Sleep entry (sample time range)

## Project Structure

```text
kidsapp/
   ContentView.swift
   kidsappApp.swift
   Data/
      SampleData.swift
   Models/
      Child.swift
      DiaryEntry.swift
   Utils/
      Extensions.swift
   ViewModels/
      ChildViewModel.swift
      DiaryViewModel.swift
   Views/
      AddEntryView.swift
      ChildDiaryView.swift
      MyChildrenView.swift
      Components/
         ChildRow.swift
         DiaryEntryRow.swift
```

## How To Run

1. Open kidsapp.xcodeproj in Xcode.
2. Select an iOS simulator (iOS 17 or above).
3. Build and run the app.
4. On first launch, confirm sample children and entries appear automatically.

## Typical User Flow

1. Open My Children screen.
2. Search/select a child.
3. Review diary timeline and allergy status.
4. Tap plus button to add a new entry.
5. Save and verify new entry appears in timeline.
6. Optionally use swipe-to-delete to remove an entry.

## Current Notes

- Data is stored locally using SwiftData.
- No external backend sync is currently implemented.
- Emergency action currently opens an alert with contact details.

## Future Improvements

- Add edit support for existing entries
- Add richer validation (for example sleep end time after start time)
- Add automated unit/UI tests
- Add export or sync capability
