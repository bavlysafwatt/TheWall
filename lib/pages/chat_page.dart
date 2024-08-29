import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/components/chat_bubble.dart';
import 'package:the_wall/models/message_model.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage(
      {super.key,
      required this.recieverUsername,
      required this.recieverEmail,
      required this.senderEmail});

  final TextEditingController controller = TextEditingController();
  final String recieverUsername;
  final String recieverEmail;
  final String senderEmail;

  final ScrollController scrollController = ScrollController();

  FirebaseFirestore database = FirebaseFirestore.instance;

  String getChatRoomId(String email, String reciever) {
    List<String> emails = [email, reciever];
    emails.sort();
    String chatRoomId = emails.join('_');
    return chatRoomId;
  }

  void sendMessage(String value, String email, String reciever) {
    String chatRoomId = getChatRoomId(email, reciever);
    database
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add({
      'message': value,
      'createdAt': DateTime.now(),
      'senderEmail': email,
      'recieverEmail': reciever,
    });
    controller.clear();
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          recieverUsername,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: database
            .collection('chat_rooms')
            .doc(getChatRoomId(senderEmail, recieverEmail))
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        bool isCurrentUser =
                            senderEmail == messagesList[index].senderEmail;
                        return ChatBubble(
                          message: messagesList[index],
                          isCurrentUser: isCurrentUser,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                sendMessage(value, senderEmail, recieverEmail);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Type a message here',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade500,
                              ),
                              contentPadding: const EdgeInsets.all(18),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                            ),
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            if (controller.text.isNotEmpty) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              sendMessage(
                                  controller.text, senderEmail, recieverEmail);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.shade800,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'There was an error, please try again later!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.grey.shade600,
                backgroundColor: Colors.grey.shade500,
              ),
            );
          }
        },
      ),
    );
  }
}
