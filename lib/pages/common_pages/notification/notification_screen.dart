import 'package:job/components/notification_item.dart';
import 'package:job/components/screen_action_bar.dart';
import 'package:job/components/screen_frame.dart';
import 'package:job/constants/theme_constant.dart';
import 'package:job/constants/url_constant.dart';
import 'package:job/user/user_service.dart';
import 'package:job/utils/api_service.dart';
import 'package:job/utils/common_function.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> _notificationList = [];

  @override
  void initState() {
    super.initState();
    initNotificaitonList();
    insertScreen(USER_ID, 'notification', 0, "screen_open");
  }

  initNotificaitonList() async {
    var body = {"user_id": USER_ID};

    ApiResponse response = await postService(URL_USER_NOTIFICATION_LIST, body);

    if (response.isSuccess) {
      setState(() {
        _notificationList = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      titleBar: ScreenActionBar(title: 'Notification', backButtonEnabled: false,),
      body: Column(
        children: [

          ..._notificationList.map((notification){
            return NotificationItem(notification: notification);
          }).toList(),
          addVerticalSpace(),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: _notificationList.length,
          //     itemBuilder: (context, index) {
          //       return 
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
