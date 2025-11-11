# EventEase App Structure - Visual Guide

## Application Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                        EventEaseApp                              │
│                      (main() entry point)                        │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                    MaterialApp                                   │
│  - Primary Color: emerald600                                     │
│  - Theme: Custom with AppBar styling                             │
│  - Home: MainAppShell()                                          │
│  - Routes: /home, /login, /register, /dashboard, /events        │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│              MainAppShell (NEW - Main Container)                │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              AppBar (Header)                             │  │
│  │    🏠 EventEase                                     ✕    │  │
│  │  (Branding - always visible)                             │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │         _pages()[_selectedIndex]                         │  │
│  │    (Current Tab Content - switches based on selection)   │  │
│  │                                                          │  │
│  │   ┌─ Tab 0: HomePage                                   │  │
│  │   │   - Hero Section                                   │  │
│  │   │   - Upcoming Events                                │  │
│  │   │   - Custom Footer                                  │  │
│  │   │                                                    │  │
│  │   ├─ Tab 1: EventsPage                                 │  │
│  │   │   - Search & Filter Bar                            │  │
│  │   │   - Events List                                    │  │
│  │   │   - Custom Footer                                  │  │
│  │   │                                                    │  │
│  │   └─ Tab 2: DashboardPage                              │  │
│  │       - Statistics Cards (4 grid)                      │  │
│  │       - Your Events Section                            │  │
│  │       - Custom Footer                                  │  │
│  │                                                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │    BottomNavigationBar (Tab Selector)                   │  │
│  │  🏠      🔍      📊                                      │  │
│  │  Home   Browse  Dashboard                               │  │
│  │ (Selected: Emerald Color)                               │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│           ⊕ Create Event (FloatingActionButton)                │
│         (Centered Docked Position)                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
         │                      │                      │
         │                      │                      │
    Push Navigator          Push Navigator         Push Navigator
         │                      │                      │
         ▼                      ▼                      ▼
    ┌────────────┐          ┌────────────┐        ┌────────────┐
    │   CreateEvent          │   Login    │        │  Register  │
    │   Page                 │   Page     │        │   Page     │
    │ (Full Modal)           │ (Full Modal)        │(Full Modal)│
    └────────────┘          └────────────┘        └────────────┘
         │
    Push Navigator
         │
         ▼
    ┌──────────────────┐
    │ EventDetailsPage │
    │  (Full Modal)    │
    └──────────────────┘
```

## State Management

```
MainAppShell State:
│
├── _selectedIndex: int
│   └── Determines which tab is displayed
│       (0 = Home, 1 = Events, 2 = Dashboard)
│
└── _onItemTapped(index: int)
    └── Called when user taps navigation item
        └── Updates _selectedIndex
            └── setState() rebuilds with new tab
```

## Component Hierarchy

```
Widget Tree:
├── Scaffold
│   ├── appBar
│   │   └── AppBar (branding header)
│   ├── body
│   │   └── Current Page (_pages()[_selectedIndex])
│   │       ├── HomePage
│   │       │   ├── SingleChildScrollView
│   │       │   ├── Hero Container
│   │       │   ├── Events Section
│   │       │   └── CustomFooter
│   │       ├── EventsPage
│   │       │   ├── SingleChildScrollView
│   │       │   ├── Search TextField
│   │       │   ├── Filter Dropdown
│   │       │   ├── Events ListView
│   │       │   └── CustomFooter
│   │       └── DashboardPage
│   │           ├── SingleChildScrollView
│   │           ├── Stats GridView (2x2)
│   │           ├── Your Events Card
│   │           └── CustomFooter
│   ├── bottomNavigationBar
│   │   └── BottomNavigationBar (3 items)
│   └── floatingActionButton
│       └── FloatingActionButton.extended
```

## Data & Services

```
EventService (Singleton)
├── mockEvents: List<Event>
│   └── Sample event data for display
├── getEventById(id): Event
│   └── Fetch event details
└── formatDate(date): String
    └── Format date display

AppColors (Constants)
├── emerald600: Color (Primary)
├── blue600, purple600, yellow600: Colors
├── gray800, gray600, gray400, gray200: Grays
└── emerald100, etc.: Light variants
```

## Navigation Routes

```
Named Routes:
│
├── /home
│   └── MainAppShell(initialTab: 0)
│
├── /events
│   └── MainAppShell(initialTab: 1)
│
├── /dashboard
│   └── MainAppShell(initialTab: 2)
│
├── /login
│   └── LoginPage() [Full Screen]
│
├── /register
│   └── RegisterPage() [Full Screen]
│
└── /create-event
    └── CreateEventPage() [Full Screen]
```

## Color Scheme

```
Primary: AppColors.emerald600 (#059669)
├── Used for: Selected nav items, CTA buttons, links
└── Contrast: Good on white backgrounds

Secondary: AppColors.blue600 (#2563eb)
├── Used for: Alternative CTAs, social buttons
└── Found in: Hero gradient

Neutral: AppColors.gray600 (#4b5563)
├── Used for: Unselected nav items, helper text
└── Hierarchy: gray800 (dark) → gray50 (light)

Accent Colors:
├── purple600: Dashboard stats
├── yellow600: Performance metrics
└── Others: Various highlights
```

## Responsive Behavior

```
All Sizes (Mobile Priority):
├── Bottom Navigation always fixed
├── AppBar always visible
├── FloatingActionButton always accessible
└── Content scrollable with SingleChildScrollView

Tablets/Large Screens:
├── Same layout (bottom nav still optimal)
├── More whitespace in content
├── Same usability advantage
```

## Performance Optimizations

```
Current Approach:
├── Pages rebuild on tab switch (can be optimized)
├── No state persistence between tabs
└── [Future] Add AutomaticKeepAliveClientMixin

Potential Improvements:
├── Cache pages to preserve scroll position
├── Add page transitions animations
└── Implement lazy loading for events
```

## Event Flow Example

```
User taps "Events" tab:
1. User taps Events icon (🔍) in BottomNavigationBar
2. _onItemTapped(1) is called
3. _selectedIndex changes from 0 to 1
4. setState() triggers rebuild
5. _pages()[1] returns EventsPage widget
6. EventsPage displays with search and events list
7. AppBar stays visible with branding
8. FAB ready for Create Event action
```

## Error Handling

```
Pages gracefully handle:
├── No events (show empty state)
├── Network errors (show fallback UI)
├── Missing event data (use defaults)
└── Navigation errors (proper error boundaries)
```

This architecture provides:
✓ Clean separation of concerns
✓ Easy to maintain and extend
✓ Mobile-first design
✓ Scalable structure
✓ Good user experience
