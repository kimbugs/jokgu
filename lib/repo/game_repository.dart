import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_firebase/models/game_model.dart';

class GameRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future updateGame(GameModel game) async {
    final docGame = _db.collection('game').doc(game.id);

    await docGame.update(game.toJson());
  }

  Future deleteGame({required String id}) async {
    final docGame = _db.collection('game').doc(id);

    await docGame.delete();
  }

  Future createGame({required String day}) async {
    final docGame = _db.collection('game').doc(day);

    final game = GameModel(id: docGame.id, day: day);
    await docGame.set(game.toJson());
  }

  // Future createGameSet(
  //     {required String id, required GameSetModel gameSet}) async {
  //   final docGame = _db.collection('game').doc(id);

  //   await docGame.update({'gameSets': })
  // }

  Stream<List<GameModel>> readGames() => _db
      .collection('game')
      .orderBy("id", descending: true)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => GameModel.fromJson(e.data())).toList());
}
