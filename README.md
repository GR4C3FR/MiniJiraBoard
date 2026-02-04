# MiniJira Board

## Group #4

### 👥 Member List
- **James Jethro Dizon**
- **Charles Daniel Garcia**
- **Ericka Mae Gavino**
- **Carla Joves**
- **Alexander Manabat**

---

### 🛠️ Assigned Roles & Tasks

#### Member 1: Charles Garcia (Leader)
**Project + Model + Sample Data**
- Core Flutter project setup and creation
- Created main.dart and screen routing architecture
- Developed Task model with enums (TaskPriority, TaskStatus)
- Implemented in-memory task list state management
- Created sample_tasks.dart with 7 initial tasks on app launch
- Created the final documentation

#### Member 2: Alexander Manabat
**Summary UI + Reusable Widgets + Pages + Sprint Summary**
- Implemented Sprint Summary Row with To Do / In Progress / Done counts
- Created Summary Card displaying Total / Done / Remaining tasks
- Developed reusable StatBox widget for summary statistics
- Built live task counting logic that updates automatically

#### Member 3: James Jethro Dizon
**Task List + Delete**
- Implemented ListView.builder for scrollable task display
- Created reusable TaskCard widget component
- Developed priority badge with color-coded containers
- Added status label display on each card
- Implemented description preview with 2-line ellipsis
- Built Edit/Delete action buttons
- Created delete task logic with confirmation dialog
- Ensured delete operations update all summary counts

#### Member 4: Ericka Gavino
**Add/Edit Form + Validation**
- Built complete Task Form screen for both add and edit modes
- Implemented text fields (Title, Description) and dropdowns (Priority, Status)
- Created live description character counter (X / 120)
- Implemented dynamic color rules (Safe: Green, Warning: Orange, Danger: Red)
- Built save/update logic for task creation and modification
- Added cancel behavior with navigation
- Implemented validation to prevent saving when exceeding 120 character limit

#### Member 5: Carla Joves
**Filters + Integration**
- Implemented Quick Filters (All / High Priority / Done)
- Created filtered task display logic
- Ensured filters work correctly after create/edit/delete operations
- Performed final integration testing
- Conducted UI cleanup and consistency checks

---

### 🚀 Instructions to Run the App
```bash


# Open cmd and clone the repository
git clone <repository-url>

# Navigate to the project folder
cd <project-folder>

# Open the project in VS Code
code .

# Open VS terminal and install dependencies
flutter pub get

# Enable Developer Mode to build with plugins
start ms-settings:developers

# Run the app
flutter run
```

---

### ✨ Feature Checklist

#### ✅ Core CRUD Operations
- ✅ **Create Task** - Add new tasks via floating action button
- ✅ **Read/View Tasks** - Display all tasks in scrollable card list
- ✅ **Update/Edit Task** - Edit existing tasks with pre-filled form
- ✅ **Delete Task** - Remove tasks with confirmation dialog

#### ✅ Required Task Fields
- ✅ Title (String)
- ✅ Description (String)
- ✅ Priority (Low / Medium / High)
- ✅ Status (To Do / In Progress / Done)

#### ✅ Screen A — Task Board Features
- ✅ **Sprint Summary Row** - 3 stat boxes showing To Do, In Progress, Done counts
- ✅ **Summary Card** - Displays total tasks, completed, and remaining
- ✅ **Quick Filters** - Filter by All, High Priority, or Done
- ✅ **Task List (ListView)** - Scrollable cards with:
  - Title (bold text)
  - Priority badge (colored container)
  - Status label
  - Description preview (2 lines max, ellipsis)
  - Edit & Delete action buttons
- ✅ **Add Task Button (FAB)** - Floating action button to create new tasks

#### ✅ Screen B — Task Form Features
- ✅ **Input Fields:**
  - Title TextField
  - Description TextField (multi-line)
  - Priority Dropdown
  - Status Dropdown
- ✅ **Text Counter with Color Change:**
  - Displays "Characters: X / 120"
  - Shows "Status: Safe / Warning / Danger"
  - Color coding:
    - 0-40 characters → Green (Safe)
    - 41-80 characters → Orange (Warning)
    - 81-120 characters → Red (Danger)
    - Over 120 → Prevents saving + disables button
- ✅ **Save/Update & Cancel Buttons** - Proper form submission and navigation

#### ✅ Advanced Features
- ✅ **Quick Filters** - 3 filter options that update the task list
- ✅ **Live Summary Updates** - All stats update after create/edit/delete
- ✅ **Sample Data** - 7 pre-loaded sample tasks on app launch
- ✅ **Form Validation** - Required field checks and character limits
- ✅ **Delete Confirmation** - Dialog to prevent accidental deletion
- ✅ **Responsive Layout** - Adapts to different screen sizes
- ✅ **Empty State Messages** - Contextual messages when no tasks match filter

#### ✅ Widget Architecture (Reusable Components)
- ✅ **StatBox Widget** - Reusable summary statistic container
- ✅ **TaskCard Widget** - Reusable task display card
- ✅ **Clean Code Structure** - Organized models, screens, widgets, and data folders

---