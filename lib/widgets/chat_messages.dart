import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(context) {
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
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            return Text(loadedMessages[index].data()['text']);
          },
        );
      },
    );
  }
}
