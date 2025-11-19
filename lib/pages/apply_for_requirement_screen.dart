import 'package:job/components/colored_button.dart';
import 'package:job/components/floating_label_edit_box.dart';
import 'package:job/components/screen_action_bar.dart';
import 'package:job/components/screen_frame.dart';
import 'package:job/constants/theme_constant.dart';
import 'package:job/utils/common_function.dart';
import 'package:flutter/material.dart';

class ApplyForRequirementScreen extends StatefulWidget {

  final String requirementName;
  const ApplyForRequirementScreen({super.key, required this.requirementName});

  @override
  State<ApplyForRequirementScreen> createState() =>
      _ApplyForRequirementScreenState();
}

class _ApplyForRequirementScreenState extends State<ApplyForRequirementScreen> {
  TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      titleBar: ScreenActionBar(title: 'Apply here', backButtonEnabled: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('For: ${widget.requirementName}', style: getTextTheme().headlineMedium,),
          addVerticalSpace(),
          FloatingLabelEditBox(
            labelText: 'Remark...',
            maxLines: 4,
            controller: _remarkController,
          ),
          addVerticalSpace(),
          ColoredButton(
            onPressed: () {
              Navigator.pop(context, {
                "status": true,
                "remark": _remarkController.text,
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Apply',
                  style: getTextTheme(color: COLOR_BASE).titleMedium,
                ),
                addHorizontalSpace(4),
                Icon(Icons.login, color: COLOR_BASE),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
