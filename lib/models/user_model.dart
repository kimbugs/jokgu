class UserModel {
  final String id;
  final String name;

  UserModel({required this.id, required this.name});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
