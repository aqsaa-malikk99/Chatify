# chatify
##chat daily
This App includes
- Login Page
- User Profile
- Chat List
- Chat Screen
- Notifications
- Messages
- Online Offline
- Status Management
## Explanation
- Install Docker and Made sure it was running properly
- Install rethinkDB which is basically firebase copy
- then created two directories
  - Model
    - First Step is to register? We would need a User Model which is basically a schema of the first table in our db
    - User Model has parameters like online,id,photo,username,is active
  - Services
    - User Service Contract - An abstract class we make sure that if the backend changes for example it changes to firebase we have some ground rules
    - User Service Implementation - A service which implements the contract
    - Connect and Disconnect and isActive
    - To connect we would want a user which should like be inserted 
    - disconnect means we want it to be offline
    - isactive is to check how many users currently in the database are online
  - Then we created a test folder to implement some tests on our db
    - Helpers -  Its a class that basically implements the db helper functions like create db and clean db
    - User Service Test - first we maintained a connection and then created a db  using helper class
    - After creation of the db, we then proceed to test the service we created which obviously requires an active connection and also an instance of rThinkDB
##Episode 2 of Youtube tutorial
    -  git config --global user.email "aqsaa.malik99@gmail.com"
