import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(context) {
    final currentUser =  FirebaseAuth.instance.currentUser;


    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (chatSnapshots.hasError) {
          return Center(child: Text('Something went wrong. Try again later.'));
        }

        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return Center(child: Text("No messages found."));
        }

        final loadedMessages = chatSnapshots.data!.docs;

        return ListView.builder(
          padding: EdgeInsets.only(bottom: 40, left: 13, right: 13),
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;
            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId = nextChatMessage != null
                ? nextChatMessage['userId']
                : null;
            final nextUserIsSame = currentMessageUserId == nextMessageUserId;
            if(nextUserIsSame){
              return MessageBubble.next(message: chatMessage['text'], isMe: currentUser!.uid == currentMessageUserId);
            } else{
              return MessageBubble.first(userImage: chatMessage['userImage'], username: chatMessage['username'], message: chatMessage['text'], isMe: currentUser!.uid == currentMessageUserId);
            }
          },
        );
      },
    );
  }
}
