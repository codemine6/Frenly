import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frenly/data/datasources/remote/message/message_remote_data.dart';
import 'package:frenly/data/models/message_model.dart';
import 'package:frenly/domain/entities/message_entity.dart';
import 'package:frenly/domain/entities/chat_entity.dart';
import 'package:frenly/utils/notification_services.dart';

class MessageRemoteDataImpl implements MessageRemoteData {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  MessageRemoteDataImpl({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  @override
  Future<void> createMessage(MessageEntity message) async {
    final uid = auth.currentUser?.uid;
    final chatDocument = firestore.collection('chats').doc(message.chatId);
    final messagesCollection = firestore
        .collection('chats')
        .doc(message.chatId)
        .collection('messages');
    final data = MessageModel(
      authorId: uid,
      chatId: message.chatId,
      createdAt: Timestamp.now(),
      deletedFor: const [],
      readed: false,
      text: message.text,
    ).toMap();
    messagesCollection.add(data);
    chatDocument.update({'lastUpdated': Timestamp.now()});

    final userId = (await chatDocument.get())['users']
        .where((element) => element != uid)
        .first;
    final token =
        (await firestore.collection('users').doc(userId).get())['token'];
    NotificationServices().sendMessageNotification(token, message.text!);
  }

  @override
  Future<void> deleteAllMessages(ChatEntity chat) async {
    final uid = auth.currentUser?.uid;
    final chatsCollection = firestore.collection('chats');
    final chatsSnapshot =
        await chatsCollection.where('users', arrayContains: uid).get();
    final chatId = chatsSnapshot.docs
        .where((element) => element.data()['users'].contains(chat.userId))
        .first
        .id;
    final messagesSnapshot =
        await chatsCollection.doc(chatId).collection('messages').get();
    for (var snapshot in messagesSnapshot.docs) {
      if (snapshot.data()['deletedFor'].isEmpty) {
        chatsCollection
            .doc(chatId)
            .collection('messages')
            .doc(snapshot.id)
            .update({
          'deletedFor': FieldValue.arrayUnion([uid])
        });
      } else if (!snapshot.data()['deletedFor'].contains(uid)) {
        chatsCollection
            .doc(chatId)
            .collection('messages')
            .doc(snapshot.id)
            .delete();
      }
    }
  }

  @override
  Future<void> deleteMessages(List<MessageEntity> messages) async {
    final uid = auth.currentUser?.uid;
    final messagesCollection = firestore
        .collection('chats')
        .doc(messages.first.chatId)
        .collection('messages');
    for (var message in messages) {
      if (message.deletedFor!.isEmpty) {
        messagesCollection.doc(message.id).update({
          'deletedFor': FieldValue.arrayUnion([uid])
        });
      } else {
        messagesCollection.doc(message.id).delete();
      }
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(ChatEntity chat) {
    final uid = auth.currentUser?.uid;
    final chatDocument = firestore.collection('chats').doc(chat.id);
    return chatDocument
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map((event) => event.docs
                .where((element) => !element.data()['deletedFor'].contains(uid))
                .map((snapshot) {
              final authorId = snapshot.data()['authorId'];
              final readed = snapshot.data()['readed'];
              if (authorId != uid && !readed) {
                chatDocument
                    .collection('messages')
                    .doc(snapshot.id)
                    .update({'readed': true});
                chatDocument.update({'lastUpdated': Timestamp.now()});
              }
              return MessageModel.fromDocument(snapshot);
            }).toList());
  }
}
