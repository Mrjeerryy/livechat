import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livechat/constants.dart';

final fireb = FirebaseFirestore.instance;

late User loginuser;
bool isrecording = false;

final TextEditingController contol = TextEditingController();

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isme = true;
  final auth = FirebaseAuth.instance;
  late String? message;

  getcurrentuser() async {
    loginuser = auth.currentUser!;
  }

  @override
  void initState() {
    // TODO: implement initState
    getcurrentuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                try {
                  auth.signOut();
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const stream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: contol,
                      onChanged: (value) {
                        message = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (message != null) {
                        //Implement send functionality.
                        fireb.collection("messages").add({
                          'text': message,
                          'sender': loginuser.email,
                          'datetime': Timestamp.now()
                        });
                        message = null;
                      }
                      contol.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                  RecordingButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class stream extends StatelessWidget {
  const stream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        List<messagebubble> messages = [];
        if (snapshot.hasData) {
          final message = snapshot.data!.docs.reversed;
          for (var msg in message) {
            messages.add(messagebubble(
              user: msg["sender"],
              message: msg["text"],
              isme: loginuser.email == msg["sender"],
            ));
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messages,
            ),
          );
        } else {
          return Expanded(
              child: ListView(
            // reverse: true,
            children: messages,
          ));
        }
      },
      stream: fireb.collection("messages").orderBy('datetime').snapshots(),
    );
  }
}

// ignore: must_be_immutable
class messagebubble extends StatelessWidget {
  messagebubble(
      {required this.user, required this.message, required this.isme});

  String user;
  String message;
  bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$user",
            style: const TextStyle(color: Colors.black, fontSize: 10),
          ),
          Material(
            elevation: 20,
            borderRadius: isme
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(8))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8)),
            color: isme ? Colors.lightBlueAccent : Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "$message",
                style: TextStyle(
                    fontSize: 15, color: isme ? Colors.white : Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecordingButton extends StatefulWidget {
  @override
  _RecordingButtonState createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton> {
  late bool isRecording;

  @override
  void initState() {
    super.initState();
    isRecording = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isRecording = true;
        });
      },
      onLongPressEnd: (value) {
        setState(() {
          isRecording = false;
        });
      },
      child: Icon(
        isRecording ? Icons.stop : Icons.mic,
        color: Colors.lightBlueAccent,
        size: isRecording ? 80 : 30,
      ),
    );
  }
}
