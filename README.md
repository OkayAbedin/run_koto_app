# Run Koto - Cricket Scoring App

<p align="center">
  <img src="https://raw.githubusercontent.com/OkayAbedin/run_koto_app/main/assets/icon.png" alt="Run Koto Logo" width="150"/>
</p>

Run Koto is a modern, user-friendly cricket scoring application built with Flutter. It provides a clean, intuitive interface for tracking cricket matches, making it easy to manage scores, overs, and match statistics on the go.

## Features

- **Match Setup**: Configure teams, players per team, and overs
- **Toss Management**: Record toss results and batting order
- **Live Scoring**: Track runs, wickets, extras, and other match statistics in real-time
- **Ball-by-Ball History**: Record detailed history of each delivery
- **Innings Management**: Seamlessly switch between innings
- **Match Summary**: View comprehensive match statistics after completion
- **Dark Theme**: Enjoy a sleek, dark UI optimized for all lighting conditions
- **Cross-Platform**: Works on Android, iOS, and desktop platforms

## Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/OkayAbedin/run_koto_app/main/screenshots/match_setup.png" alt="Match Setup" width="200"/>
  <img src="https://raw.githubusercontent.com/OkayAbedin/run_koto_app/main/screenshots/scoring.png" alt="Scoring Screen" width="200"/>
  <img src="https://raw.githubusercontent.com/OkayAbedin/run_koto_app/main/screenshots/summary.png" alt="Match Summary" width="200"/>
</p>

## Installation

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio or VS Code with Flutter extensions

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/OkayAbedin/run_koto_app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd run_koto_app
   ```

3. Get dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Technical Details

### Architecture
The app follows a simple provider-based state management pattern using the Provider package. The `MatchState` class serves as the central data model, handling all match-related state management.

### Dependencies
- `flutter`: The core Flutter SDK
- `provider`: For state management
- `shared_preferences`: For local data persistence
- `url_launcher`: For launching external URLs

## Contributing

Contributions are welcome! If you'd like to contribute to the Run Koto app, please follow these steps:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

For feedback or suggestions, feel free to open an issue on the [GitHub repository](https://github.com/OkayAbedin/run_koto_app).

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Flutter team for the amazing framework
- All contributors who have helped improve this application
- Cricket enthusiasts who provided valuable feedback

---

<p align="center">
  Made with ❤️ by Minhaz
</p>
