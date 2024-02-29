# Offline Alarm App with Location-Based Weather Integration

## Overview
This is an offline alarm application that integrates location-based weather updates. The app allows users to set alarms with specific times and labels. It also fetches the current weather status based on the device's location and displays it on the alarm setting screen.

## Features
- **Alarm Functionality**: Users can set alarms with a specific time and label. Alarms can be edited and deleted. When an alarm triggers, a local notification with the alarm label is displayed.
- **Offline Functionality**: The app functions seamlessly without any network connection. The alarm functionality persists even if the app is in the background or terminated.
- **Location-based Weather Integration**: The app fetches the current latitude and longitude of the device and uses an open weather API (e.g., OpenWeatherMap, WeatherStack) to retrieve the current weather status based on the device's location. The weather status is displayed at the top of the alarm setting screen and is dynamically updated when the user opens the alarm setting screen.
- **Persistence**: The app implements local data persistence for storing alarms, ensuring that alarms persist across app restarts.
- **Background Execution**: The alarm app works seamlessly even if it's in the background or terminated.

## Code Structure
The code is organized in a modular and readable manner. It uses appropriate Flutter architecture patterns (e.g., Provider, Bloc, Riverpod) for state management.

## Comments and Documentation
Comments are added where necessary to explain complex logic or important decisions. A brief documentation file is provided explaining how to run and test the application.

## Architecture Used
- **Provider**: For state management.
- **MVC**: For structuring the code in a modular and readable manner.
- **SharedPreferences**: For local data persistence.
- **OpenWeatherMap**: For fetching the current weather status based on the device's location.
- **Flutter Local Notifications**: For displaying local notifications when an alarm triggers.

## How to Run and Test the Application
1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to fetch the dependencies.
4. Run `flutter run` to start the application.
5. To test the application, run `flutter test`.

Please note that you will need to have Flutter and Dart installed on your machine. Also, make sure to replace the API key in the weather service file with your own OpenWeatherMap API key.

## Disclaimer
This is a basic implementation of the application. Depending on the specific requirements and use cases, additional features and checks might be necessary for a production-ready application. Always review and test the code thoroughly before using it in a production environment.