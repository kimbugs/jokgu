import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_application_firebase/models/user_model.dart';

class GameDetailScreen extends StatefulWidget {
  const GameDetailScreen({super.key});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  int _selectedIndex = 0;
  bool isWinA = false;
  String stateA = '';
  String stateB = '';
  //final Set<UserModel> _users = users.toSet();
  final Set<UserModel> _users = <UserModel>{};
  final Set<UserModel> _userA = <UserModel>{};
  final Set<UserModel> _userB = <UserModel>{};
  final Set<UserModel> _selectedA = <UserModel>{};
  final Set<UserModel> _selectedB = <UserModel>{};

  @override
  void initState() {
    _userA.addAll(_users);
    _userB.addAll(_users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Game Set",
        style: textTheme.headlineMedium,
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restart_alt_rounded), label: 'Random'),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_1_rounded), label: 'A'),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_2_rounded), label: 'B'),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              showRandomDialog(context, _users);
              break;
            case 1:
              isWinA = true;
              setState(() {
                stateA = 'Win';
                stateB = 'Loss';
              });
              break;
            case 2:
              isWinA = false;
              setState(() {
                stateA = 'Loss';
                stateB = 'Win';
              });
              break;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: teamCard(
                  'A', stateA, _userA, _userB, _selectedA, _selectedB, _users),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              height: 20,
            ),
            Expanded(
              child: teamCard(
                  'B', stateB, _userB, _userA, _selectedB, _selectedA, _users),
            ),
          ],
        ),
      ),
    );
  }

  void showRandomDialog(BuildContext context, Set<UserModel> users) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Random'),
        content: const Text(''),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              List<UserModel> randomItem = (users.toList()..shuffle());
              int len = randomItem.length ~/ 2;
              Iterable<List<UserModel>> randomUsers = randomItem.slices(len);
              setState(() {
                _selectedA.clear();
                _selectedB.clear();
                _selectedA.addAll(randomUsers.first.toSet());
                _selectedB.addAll(randomUsers.last.toSet());
                _userA.clear();
                _userA.addAll(_selectedA);
                _userB.clear();
                _userB.addAll(_selectedB);
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Card teamCard(
      String teamName,
      String stateWin,
      Set<UserModel> userMain,
      Set<UserModel> userSub,
      Set<UserModel> selectedMain,
      Set<UserModel> selectedSub,
      Set<UserModel> users) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(teamName, style: textTheme.titleLarge),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Wrap(
                  children: userMain.map((UserModel user) {
                    return FilterChip(
                      label: Text(user.name),
                      selected: selectedMain.contains(user),
                      onSelected: (bool value) {
                        setState(() {
                          if (value) {
                            selectedMain.add(user);
                          } else {
                            selectedMain.remove(user);
                          }
                          userMain.addAll(users);
                          userSub.addAll(users);
                          userMain.removeAll(selectedSub);
                          userSub.removeAll(selectedMain);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      stateWin,
                      style: const TextStyle(fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
