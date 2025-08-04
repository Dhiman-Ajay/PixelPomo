## Pixel Pomo - A Gamified Pomodoro Timer

Pixel Pomo is a beautiful, modern Pomodoro timer application built with Flutter. It's designed to help users stay focused and productive by gamifying the process of completing work sessions. For every Pomodoro you complete, you unlock a pixel in a collective piece of art, slowly revealing a masterpiece and adding it to your gallery.

## 📸 App Screenshots

### Images -
<img src="https://github.com/Dhiman-Ajay/PixelPomo/blob/master/timer.jpg" width="300">
<img src="https://github.com/Dhiman-Ajay/PixelPomo/blob/master/grid.jpg" width="300">
<img src="https://github.com/Dhiman-Ajay/PixelPomo/blob/master/stats.jpg" width="300">
<img src="https://github.com/Dhiman-Ajay/PixelPomo/blob/master/gallery.jpg" width="300">

## ✨ Features

- Core Pomodoro Timer: A clean timer with configurable durations for focus and break sessions.
- Automatic Transitions: The timer automatically switches from work to break and back, keeping you in the flow.
- Pixel Art Gamification: Stay motivated by collectively unlocking pixel art masterpieces. Each completed Pomodoro reveals another piece of the puzzle.
- Art Gallery: A history of all your completed masterpieces to visually track your accomplishments.
- Productivity Stats: See your total completed sessions and focus time at a glance.
- Data Persistence: Your progress is always saved! The app remembers your completed art, stats, and current grid progress even after you close it.
- Beautiful, Custom UI: A sleek, modern interface with a custom dark theme and elegant animations.
- Dynamic Color-Coding: The UI dynamically changes color to clearly distinguish between work (red) and break (teal) sessions.
- Full User Control: Pause, reset, and configure timers to fit your personal workflow. A full data-reset option is included for a fresh start.
<br>


## 🛠️ Tech Stack & Implementation
This project was built to showcase a variety of core Flutter development concepts:

Framework: Flutter
Language: Dart
State Management: Provider - For managing and distributing application state efficiently and cleanly across the widget tree.
Data Persistence: shared_preferences - For saving user progress, stats, and settings locally on the device.
UI & Animation:
Custom-themed Material Design widgets.
shimmer package for creating an elegant, rewarding animation on completed art tiles.
percent_indicator for the timer's progress bar.
Audio: audioplayers for providing satisfying audio feedback upon session completion.
App Icons: flutter_launcher_icons for generating all necessary app icon sizes for Android and iOS from a single source.
<br>

## 🚀 How to Run
To run this project locally, follow these steps:
- Clone the repository:
git clone https://github.com/YOUR_USERNAME/pixelpomo.git
- cd pixelpomo
- Install dependencies: flutter pub get
- Run the app:
- flutter run
<br>


## Future Improvements
- Implement a fully functional historical stats system to track productivity over weeks and months.
- Add a "Day Streak" feature to motivate daily use.
- Introduce an "Achievements" system for completing certain milestones.
- Add more pixel art collections and allow users to choose which one to work on.

  
