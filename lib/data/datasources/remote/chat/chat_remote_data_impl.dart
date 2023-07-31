import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frenly/data/datasources/remote/chat/chat_remote_data.dart';
import 'package:frenly/data/models/chat_model.dart';
import 'package:frenly/domain/entities/chat_entity.dart';

class ChatRemoteDataImpl implements ChatRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ChatRemoteDataImpl({required this.auth, required this.firestore});

  @override
  Future<String> createChat(ChatEntity chat) async {
    final uid = auth.currentUser?.uid;
    final chatsCollection = firestore.collection('chats');
    final snapshot =
        await chatsCollection.where('users', arrayContains: uid).get();
    final chats = snapshot.docs
        .where((element) => element.data()['users'].contains(chat.userId));
    if (chats.isEmpty) {
      final chatSnapshot = await chatsCollection.add({
        'users': [uid, chat.userId]
      });
      return chatSnapshot.id;
    } else {
      return chats.first.id;
    }
  }

  @override
  Future<void> deleteChats(List<ChatEntity> chats) async {
    final uid = auth.currentUser?.uid;
    final chatsCollection = firestore.collection('chats');
    for (var chat in chats) {
      final messagesSnapshot =
          await chatsCollection.doc(chat.id).collection('messages').get();
      for (var snapshot in messagesSnapshot.docs) {
        if (snapshot.data()['deletedFor'].isEmpty) {
          chatsCollection
              .doc(chat.id)
              .collection('messages')
              .doc(snapshot.id)
              .update({
            'deletedFor': FieldValue.arrayUnion([uid])
          });
        } else if (!snapshot.data()['deletedFor'].contains(uid)) {
          chatsCollection
              .doc(chat.id)
              .collection('messages')
              .doc(snapshot.id)
              .delete();
        }
        chatsCollection.doc(chat.id).update({'lastUpdated': Timestamp.now()});
      }
    }
  }

  @override
  Stream<List<ChatEntity>> getChats() {
    final uid = auth.currentUser?.uid;
    final chatsCollection = firestore.collection('chats');
    final usersCollection = firestore.collection('users');
    return chatsCollection
        .where('users', arrayContains: uid)
        .snapshots()
        .asyncMap((event) async {
      final chats = event.docs.map((chatSnapshot) async {
        final messagesSnapshot = await chatsCollection
            .doc(chatSnapshot.id)
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .get();
        final messages = messagesSnapshot.docs
            .where((element) => !element.data()['deletedFor'].contains(uid))
            .toList();
        if (messages.isNotEmpty) {
          final userId = chatSnapshot
              .data()['users']
              .firstWhere((element) => element != uid);
          final userSnapshot = await usersCollection.doc(userId).get();
          return ChatModel.fromDocument(chatSnapshot, userSnapshot, messages);
        }
      });
      return (await Future.wait(chats)).whereType<ChatModel>().toList();
    });
  }
}
