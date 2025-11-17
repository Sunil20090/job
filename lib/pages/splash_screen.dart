import 'package:job/constants/image_constant.dart';
import 'package:job/constants/theme_constant.dart';
import 'package:job/constants/url_constant.dart';
import 'package:job/pages/dashboard/dashboard_screen.dart';
import 'package:job/user/user_service.dart';
import 'package:job/utils/api_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initUser().then((value) {
      print('user id available $value');
      moveToDashBoard();
    });
  }

  initUser() async {
    var user = await loadUser();

    if (user == null || user['id'] == null) {
      ApiResponse response = await getService(URL_GUEST_USER);
      print(response.body);
      if (response.isSuccess) {
        await saveUser(response.body);
        user = response.body;
      }
    } else {
      ApiResponse response = await postService(URL_USER_DETAIL, {
        "id": USER_ID,
      });
      if (response.isSuccess) {
        await saveUser(response.body);
        user = response.body;
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: COLOR_WHITE,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(ICON_APP_ICON),
              ),
            ],
          ),
        ],
      ),
    );
  }

  moveToDashBoard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (builder) => DashboardScreen()),
    );
  }
}
