import 'package:flutter/material.dart';
import 'package:job/components/progress_circular.dart';
import 'package:job/components/screen_action_bar.dart';
import 'package:job/components/screen_frame.dart';
import 'package:job/constants/theme_constant.dart';
import 'package:job/constants/url_constant.dart';
import 'package:job/user/user_service.dart';
import 'package:job/utils/api_service.dart';
import 'package:job/utils/common_function.dart';

class ReportScreen extends StatefulWidget {
  final String title;
  const ReportScreen({super.key, required this.title});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  var _reasonList = [];
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _initReasons();
  }

  _initReasons() async {

    var body = {
      "user_id" : USER_ID
    };

    setState(() {
      _isFetching = true;
    });

    ApiResponse response = await postService(URL_REASON_MASTER, body);

    setState(() {
      _isFetching = false;
    });

    if(response.isSuccess){
      setState(() {
        _reasonList = response.body;
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(titleBar: ScreenActionBar(title:widget.title ),body: Column(
      children: [

            if(_isFetching) Row(children: [
              ProgressCircular()
            ],),
        ..._reasonList.map((item){
          return ListTile(
            onTap: (){
              postReport(item);
            },
            title: Row(
            children: [
              Icon(Icons.person_2),
              addHorizontalSpace(),
              Text(item['reason'], style: getTextTheme().titleMedium,)
            ],
                    ),
          );
        }).toList(),
        
      ],
    ),);
  }
  
  void postReport(item) {
    insertScreen(USER_ID, "report_problem", item['id'], item['reason']);
    Navigator.pop(context);
  }
}