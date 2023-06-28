class UserModel {
  int id;
  String name;

  UserModel(this.id, this.name);
}

List<UserModel> users = [
  UserModel(1, 'a'),
  UserModel(2, 'b'),
  UserModel(3, 'c'),
  UserModel(4, 'd'),
  UserModel(5, 'e'),
  UserModel(6, 'f'),
  UserModel(7, 'g'),
  UserModel(8, 'h'),
];

// List<UserModel> teamA = [
//   UserModel(1, 'a'),
//   UserModel(2, 'b'),
//   UserModel(3, 'c'),
//   UserModel(4, 'd'),
// ];

// List<UserModel> teamB = [
//   UserModel(5, 'e'),
//   UserModel(6, 'f'),
//   UserModel(7, 'g'),
//   UserModel(8, 'h'),
// ];
