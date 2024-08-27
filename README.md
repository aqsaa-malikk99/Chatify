# Chatify

**Chatify** is a comprehensive chat application developed as a learning project to explore the fundamentals of building a real-time messaging platform. The application features various components typical of a modern chat app, including user authentication, chat interfaces, status management, notifications, and more. This project aims to demonstrate how to create a robust backend using Docker, RethinkDB, and structured service implementation patterns, while also covering aspects such as encryption and typing notifications.

## Features

- **User Authentication**: A secure login page allowing users to authenticate and gain access to the application.
- **User Profile**: Each user has a customizable profile, including an avatar, username, and online status.
- **Chat List**: A list displaying all available chats for the authenticated user.
- **Chat Screen**: A dynamic screen for active conversations, supporting real-time messaging.
- **Notifications**: Notifications for incoming messages and user activities.
- **Status Management**: Tracks users' online/offline status.
- **Messages**: Real-time messaging with encryption for secure communication.
- **Typing Notifications**: Indicators showing when users are typing.

## Project Structure and Development Phases

### Phase 1: Initial Setup and User Management

1. **Docker and RethinkDB Setup**
   - Installed Docker and ensured it was running correctly to provide an isolated environment for development.
   - Installed RethinkDB, an open-source NoSQL database similar to Firebase, to manage real-time data.

2. **Directory Structure Creation**
   - **Model Directory**:
     - Developed the `User` model representing the schema for the users' table in RethinkDB, with attributes such as `online`, `id`, `photo`, `username`, and `isActive`.
   - **Services Directory**:
     - Created a `UserServiceContract`, an abstract class defining the rules and behaviors for user-related services, ensuring flexibility in backend changes (e.g., switching from RethinkDB to Firebase).
     - Implemented `UserServiceImplementation`, which provides concrete methods for user-related operations such as `connect`, `disconnect`, and `isActive`. These methods manage user connections, handle disconnections, and check the number of online users.

3. **Testing Infrastructure**
   - Developed a test folder to validate database operations.
   - **Helpers Class**: Contains utility functions for database operations, such as creating and cleaning up the database.
   - **User Service Test**: Established a connection to RethinkDB, created a test database using the helper class, and tested the user service implementation to ensure robust functionality.

### Phase 2: Messaging Functionality

1. **Message Model and Services**
   - Created a `Message` model class to define the schema for the messages table, including attributes like `from`, `to`, `timestamp`, and `contents`.
   - Designed the `MessageServiceContract` to outline functionalities like sending messages and streaming message feeds.
   - Implemented `MessageServiceImplementation`:
     - **Send Method**: Inserts messages into the messages table and manages real-time notifications for the recipients.
     - **Messages Stream**: Initiates a stream of messages for the active user using a change feed to monitor updates in real-time.
     - **Start Receiving Messages**: Filters messages directed to the active user and streams them, handling new messages and marking them as delivered.

2. **Testing Messaging Services**
   - Updated the helpers class to manage the messages table, including creation and cleanup methods.
   - Wrote tests for both the `send` and `messages` methods:
     - **Send Message Test**: Verifies that messages are correctly inserted into the database.
     - **Stream Subscribe Test**: Ensures that the message stream correctly updates based on changes in the database, confirming real-time functionality.

### Phase 3: Advanced Features

1. **Encryption Service**
   - Developed an `Encryption` service to secure data communication, similar to WhatsApp's encryption:
     - **Encrypt Method**: Utilizes base64 encoding to encrypt outgoing messages.
     - **Decrypt Method**: Decodes incoming messages back to plaintext, ensuring data integrity and security during transmission.

2. **Receipt and Typing Notification Services**
   - **Receipt Service**: Tracks the status of messages (sent, delivered, read) with a model class defining the schema and an enumeration for status consistency.
   - **Typing Notification Service**: Manages typing indicators (started, stopped), alerting users when others are typing in the chat.

## Getting Started

To get started with Chatify, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/chatify.git
   cd chatify
   ```

2. **Install Dependencies**:
   Make sure Docker is installed and running. Set up RethinkDB following the installation instructions on the official site.

3. **Run the Application**:
   Start the Docker containers and initialize the backend services as per the Docker and RethinkDB setup.

4. **Run Tests**:
   To ensure everything is set up correctly, run the tests provided in the `test` folder.

## Conclusion

Chatify is designed as an educational project to explore real-time chat application development using modern technologies. By implementing various features and services, this project demonstrates the process of building a robust and scalable application, focusing on secure communication, real-time data handling, and a modular architecture.

Feel free to explore, contribute, and adapt Chatify for your needs!
