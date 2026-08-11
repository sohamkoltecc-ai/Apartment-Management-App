//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/database_service_admin.dart';
import '../widgets/message_tile_admin.dart';
import '../widgets/widgets_admin.dart';
import 'group_info_admin.dart';

class ChatPageAdmin extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;

  const ChatPageAdmin({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChatPageAdmin> createState() => _ChatPageAdminState();
}

class _ChatPageAdminState extends State<ChatPageAdmin> {
  Stream? chats;
  final TextEditingController messageController = TextEditingController();

  String admin = "";

  @override
  void initState() {
    super.initState();
    getChatandAdmin();
  }

  void getChatandAdmin() {
    DatabaseServiceAdmin().getChats(widget.groupId).then((val) {
      if (mounted) {
        setState(() {
          chats = val;
        });
      }
    });

    DatabaseServiceAdmin().getGroupAdmin(widget.groupId).then((val) {
      if (mounted) {
        setState(() {
          admin = val;
        });
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(
                context,
                GroupInfoAdmin(
                  groupId: widget.groupId,
                  groupName: widget.groupName,
                  adminName: admin,
                ),
              );
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),

      body: Stack(
        children: [
          chatMessages(),

          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],

              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Send a message...",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Icon(Icons.send, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 90),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTileAdmin(
              message: snapshot.data.docs[index]['message'],
              sender: snapshot.data.docs[index]['sender'],
              sentByMe: widget.userName == snapshot.data.docs[index]['sender'],
            );
          },
        );
      },
    );
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text.trim(),
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseServiceAdmin().sendMessage(widget.groupId, chatMessageMap);

      setState(() {
        messageController.clear();
      });
    }
  }
}
