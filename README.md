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
## Episode 2 of Youtube tutorial
### Explanation
- First we created a Message model class for the message table schema
  - The Message class represents a message sent between users in the chat application. It includes attributes such as the sender (from), recipient (to), timestamp (timestamp), and contents (contents) of the message. The toJson() method converts the message object into a JSON format for storage or transmission. The fromJson() factory method creates a Message object from a JSON map, allowing for easy serialization and deserialization.
- Then we created Message Service Contract File
  - In this file we included what we aim to do we messages like ``send``,``messages stream`` intitally 
  - we defined two methods for each feature
  - Then we created a Message Service Implementation file to define the function of these methods
  - The send method needs a connection to the db, a instance of rethinkDB, and controller to get the strema and changefeed to check the changes in the feed.
  - In the messages method, we take the activeUser we have to get the feed for and start the stream using _startReceievingMessages using the activeUser
    - The startReceivingMessages service we go inside the table messages and filter where the to is pointed to the activeUser and then check for the new messages using include_inital true and then run the connection
    -  This subscription returns a cursor, which we convert into a stream using asStream(). We then cast this stream to a Feed type, as RethinkDB streams are typically of this type. We listen to the stream for incoming events, which represent changes in the table data. When a new message is received (feedData['new_val']), we convert it into a Message object using the _messageFromFeed method and add it to the _controller stream for further processing. Additionally, we remove the delivered message from the table to ensure that it is not processed again in the future.
  - In the send method, we take a message that we need to send and insert into the messages table and return the result
- Then we updated helper class
  - we `await r.tableCreate('messages').run(connection).catchError((err) => {});` line to the createDb and cleanDB method to delete the messages
- Then we wrote tests for each method metioned in the contract `send` and `messages`
- The send message test is checked by making an instance of Messages and testing the return value
- The stream subscribe method is checked by using user2 feed and listen to its feedchanges and we expect that the stream changes will show that message.to param have user2.id and is the message id param is not empty 
- after that we send the two messages

## Episode 3 of Youtube tutorial
### Explanation
- We created a service `encryption`
- `Encryption` --> was to encrypt data incoming and outgoing just like whatsapp we encrypt our data so that it doesnt saves on the server
  - For that we created two methods`encrypt` and `decrypt`
  - Encrypt data uses base64 and implemented this method inside send 
  - Decrypt data decrypts base64 message into plain text we used it insdie the message service where we are subscribing to the stream
## Episode 3 of Youtube tutorial
### Explanation
- We created two services 1 `Receipt` 2  `Typing Notification` 
- `Receipt` --> Its status of the message whether its  sent, delivered, read 
  - we created a model class depicting the table schema and having enum to ensure the status remain constant 
  - we then created service which had the methods to insert the status for that message and check the incoming status for message
-  `Typing Notification`  --> to give out typing notiifcation for the user whether it is `started` or `stopped`
  - Similarly to receipt we created exact same notification
