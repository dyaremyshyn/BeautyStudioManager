# Beauty Studio Manager

Beauty Studio Manager is a comprehensive application designed to help beauty studios manage their services, appointments, and finances in one place. This project aims to simplify the daily operations of a beauty studio by providing a user-friendly interface for creating and managing services, scheduling appointments, and monitoring the studio's balance.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Overview

Beauty Studio Manager is built with a focus on simplicity and efficiency. The application is structured around three core functionalities:

1. **Service Management:**  
   Create and manage the different services offered by the studio. Each service can include details like name, price, duration, and an associated icon.

2. **Appointment Scheduling:**  
   Schedule appointments based on available services. When an appointment is created, the application automatically calculates the appointment duration based on the selected service.

3. **Financial Balance:**  
   Monitor and display the studio's balance. The app provides an overview of income, expenses, and other financial metrics to help you make informed decisions.

## Features

- **Agenda:**  
  Check your appointments agenda for 'Today', 'Week', 'Month', 'All'.

- **Service Creation and Editing:**  
  Easily add, edit, or remove beauty services.

- **Appointment Booking:**  
  Schedule appointments with automatic duration calculation (e.g., adding 1 hour to a 9 AM appointment will set the end time to 10 AM). And in case you need to drive to your customer location the cost of travel is calculated for you based on Kms and cost per Km.

- **Direct Calendar Integration:**  
  Add all created appointments directly to your device’s calendar for seamless scheduling and reminders.

- **User-Friendly UI:**  
  Clean and modern design built with both SwiftUI and UIKit components.

- **Customizable Icon Picker:**  
  Choose icons for services and appointments using a custom picker that supports emojis and image resources.

- **Reactive Validation:**  
  Validate user input (e.g., service name, price, duration) in real-time using Combine.

- **Core Data Integration:**  
  Persist all data locally with Core Data for offline access and reliability.

- **Balance**
  In the Balance View, you can see which services are generating the most income, record your studio’s expenses, and have all the information automatically saved and displayed for you.

## Tech Stack

- **iOS / Swift:**  
  Developed entirely in Swift using both UIKit and SwiftUI.

- **Core Data:**  
  Local persistence solution for storing services, appointments, and balance data.

- **Combine:**  
  Used to create reactive pipelines for input validation and data binding.

- **SOLID Principles:**  
  The project is designed following SOLID principles to create robust, maintainable, and scalable code.

- **Clean Architecture:**  
  The app leverages Clean Architecture principles to separate concerns, improve testability, and facilitate easier maintenance over time.

- **Xcode:**  
  The project is built and managed using Xcode.

## Contributing

Contributions are welcome! If you have ideas for improvements, feel free to fork the repository and submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or feedback, feel free to reach out:

- **Email:** dmytroyaremyshyn@gmail.com
- **LinkedIn:** [dyaremyshyn]([https://github.com/yourusername](https://www.linkedin.com/in/dyaremyshyn/))
