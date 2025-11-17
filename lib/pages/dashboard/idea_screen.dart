import 'package:flutter/material.dart';
import 'package:job/components/profile_thumbnail.dart';
import 'package:job/components/rounded_rect_image.dart';
import 'package:job/components/screen_action_bar.dart';
import 'package:job/components/screen_frame.dart';
import 'package:job/constants/theme_constant.dart';
import 'package:job/constants/url_constant.dart';
import 'package:job/user/user_service.dart';
import 'package:job/utils/api_service.dart';
import 'package:job/utils/common_function.dart';

class IdeaScreen extends StatefulWidget {
  const IdeaScreen({super.key});

  @override
  State<IdeaScreen> createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  var _ideaList = [];

  @override
  void initState() {
    super.initState();
    // print('dklajfkjd');
    _initIdeas();
  }

  _initIdeas() async {
    var body = {"user_id": USER_ID};

    ApiResponse response = await postService(URL_IDEAS_LIST, body);

    if (response.isSuccess) {
      setState(() {
        _ideaList = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      titleBar: ScreenActionBar(title: 'Ideas'),
      body: Container(
        child: Column(
          children: [
            ..._ideaList.map((idea) {
              return ListTile(
                title: Row(
                  children: [
                    ProfileThumbnail(
                      width: 48,
                      height: 48,
                      radius: 24,
                      thumnail_url: idea['thumbnail'],
                    ),

                    addHorizontalSpace(),
                
                    Expanded(
                      child: Wrap(
                        children: [
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(idea['title'], style: getTextTheme().titleSmall),
                              Text('Solution: ${idea['content']}', style: getTextTheme().bodySmall, maxLines: 3,overflow: TextOverflow.ellipsis,),
                              Text(
                                'By: ${idea['username']}',
                                style: getTextTheme(color: COLOR_PRIMARY).titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
