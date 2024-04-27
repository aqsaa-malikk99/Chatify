// for seamless connection
import '../../models/user.dart';

abstract class IUserService {
  //create a user and return a user
  Future<User> connect(User user);

//show users that are online
  Future<List<User>> online();
  Future<void> disconnect(User user);
}
