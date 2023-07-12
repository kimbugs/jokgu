import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/models/user_model.dart';
import 'package:flutter_application_firebase/repo/user_repository.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

enum MoreItem { edit, delete }

class _UsersScreenState extends State<UsersScreen> {
  final userRepository = UserRepository();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: controller),
        actions: [
          IconButton(
            onPressed: () {
              final name = controller.text;

              userRepository.createUser(name: name);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: userRepository.readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;

            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(UserModel user) {
    MoreItem? selectedMenu;
    final controller = TextEditingController();

    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name)),
        title: Text(user.name),
        subtitle: Text(user.id),
        subtitleTextStyle: const TextStyle(fontSize: 10),
        trailing: PopupMenuButton<MoreItem>(
          initialValue: selectedMenu,
          onSelected: (MoreItem item) {
            switch (item) {
              case MoreItem.edit:
                controller.text = user.name;
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Edit'),
                    content: TextField(controller: controller),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                          onPressed: () {
                            userRepository.updateUser(
                                id: user.id, name: controller.text);
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK')),
                    ],
                  ),
                );
                break;
              case MoreItem.delete:
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Delete'),
                    content: const Text('Are you sure?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                          onPressed: () {
                            userRepository.deleteUser(id: user.id);
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK')),
                    ],
                  ),
                );
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<MoreItem>>[
            const PopupMenuItem<MoreItem>(
              value: MoreItem.edit,
              child: Text('Edit'),
            ),
            const PopupMenuItem<MoreItem>(
              value: MoreItem.delete,
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
