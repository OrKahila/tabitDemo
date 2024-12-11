# tabit demo project

### **Setup Instructions**

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo-name/rick-and-morty-app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd rick-and-morty-app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   - For Android:
     ```bash
     flutter run -d android
     ```
   - For iOS:
     ```bash
     flutter run -d ios
     ```


### **Folder Structure**
- `lib/`
  - `models/` - Contains data models (e.g., `Character` and `Location`).
  - `providers/` - Contains state management logic using Provider.
  - `screens/` - Contains screen widgets (e.g., `HomeScreen`).
  - `widgets/` - Contains reusable UI components (e.g., `SearchBox`, `FilterDialog`).

### **Running Tests**
Unit tests are included to ensure reliable functionality for JSON parsing and error handling. To run the tests:
```bash
flutter test
```
