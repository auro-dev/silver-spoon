///
/// Created by Auro on 12/12/22 at 9:35 PM
///

import 'dart:developer';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../app_configs/environment.dart';

///
/// Created by Auro on 21/11/22 at 5:13 PM
///

mixin AppSocketHelper {
  static const String SUPPORT_CHAT_CREATED = 'v1/chat/chat-message created';

  static late Socket socket;

  static initSocket() async {
    socket = io(
        Environment.baseApiUrl,
        OptionBuilder().setTransports(['websocket'])
            // .setPath('live-comment')
            .build());
    _initListeners();
    _connectToSocket();
  }

  static _connectToSocket() async {
    if (socket.connected) {
      socket.io
        ..disconnect()
        ..connect();
    }

    socket.onConnect((data) async {
      /// Authenticate event
      socket.emitWithAck("authenticate", [
        {
          "accessToken": SharedPreferenceHelper.user?.accessToken,
          "strategy": "jwt",
        }
      ], ack: (value) {
        log('------------Login----------${value}');
      });
    });
    socket.onConnectError((data) {
      log("SOCKET ERRORRRRRRRRR : $data");
    });

    socket.connect();
  }

  static _initListeners() {
    socket.on(SUPPORT_CHAT_CREATED, (data) {
      log("CHAT_CREATED ========>>> ${data["_id"]}");
      try {
        // final chatDatum = SupportChat.fromJson(data);

        // if (Get.isRegistered<AllChatsController>()) {
        //   final chatsController = Get.find<AllChatsController>();
        //   if (chatDatum.createdBy!.id !=
        //       SharedPreferenceHelper.user!.user!.id) {
        //     chatsController.addDatum(chatDatum);
        //   }
        // }
      } catch (e, s) {
        log('$e $s');
      }
    });
  }

  static disposeSocket() async {
    log("DISPOSING SOCKET xxxxxxxxx");

    _disposeListeners();
    socket.io.disconnect();
    socket.io.close();
    // socket.io.destroy(socket)
  }

  static _disposeListeners() {
    socket.off(SUPPORT_CHAT_CREATED);
  }
}
