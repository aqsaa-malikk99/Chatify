class User {
  String username;
  String photoUrl;
  String? _id; // You can provide a default value here
  bool active;
  DateTime lastseen;

  String? get id => _id;



  User({
    required this.username,
    required this.photoUrl,
    required this.active,
    required this.lastseen,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      photoUrl: json['photoUrl'], // Corrected typo
      active: json['active'],
      lastseen: json['lastseen'], // Assuming lastseen is a date string
    ).._id = json['id']; // Setting the private _id variable
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'photoUrl': photoUrl,
      'active': active,
      'lastseen': lastseen.toIso8601String(), // Converting DateTime to string

    };
  }
}
