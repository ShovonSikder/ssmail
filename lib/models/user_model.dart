//fields name in database. Map's key also
const String collectionUser = 'Users';
const String collectionUserSentBox = 'Sent';
const String collectionUserInbox = 'Inbox';

const String userFieldUserFirstName = 'userFirstName';
const String userFieldUserLastName = 'userLastName';
const String userFieldUserEmail = 'userEmail';

//user model class
class UserModel {
  String userFirstName;
  String userLastName;
  String userEmail;

  //constructor to create new user object
  UserModel({
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
  });

  //method to convert an object to a map.
  //Cause we have to pass data to database as map.
  Map<String, dynamic> toMap() => {
        userFieldUserFirstName: userFirstName,
        userFieldUserLastName: userLastName,
        userFieldUserEmail: userEmail,
      };

  //factory method to convert a map to an object.
  //Cause we will use object in the whole app,
  //data returned from database is map so we have to convert it to an object
  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        userFirstName: map[userFieldUserFirstName],
        userLastName: map[userFieldUserLastName],
        userEmail: map[userFieldUserEmail],
      );
}
