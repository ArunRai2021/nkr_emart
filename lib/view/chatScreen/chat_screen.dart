import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nkr_e_mart/const/consts.dart';
import 'package:nkr_e_mart/controller/chats_controller.dart';
import 'package:nkr_e_mart/services/fire_store_services.dart';

import '../../comoonWidgets/loading_indicator.dart';
import 'components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  ChatsController chatsController = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "${chatsController.friendName}",
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => chatsController.isLoading.value
                  ? Center(child: loadingIndicator())
                  : Expanded(
                      child: StreamBuilder(
                      stream: FirestoreServices.getChatMessages(
                          chatsController.chatDocId.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadingIndicator());
                        } else if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text(
                            "Send a Message",
                            style: TextStyle(color: darkFontGrey),
                          ));
                        } else {
                          return ListView(
                            children: snapshot.data!.docs.map((data) {
                              return Align(
                                  alignment: data['uid'] == currentUser!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: senderBubble(data));
                            }).toList(),
                          );
                        }
                      },
                    )),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              height: 80,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: chatsController.msgController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: textFeildGrey,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textFeildGrey)),
                        hintText: "Type a Message"),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        chatsController
                            .sendMsg(chatsController.msgController.text);
                        chatsController.msgController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.red,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
