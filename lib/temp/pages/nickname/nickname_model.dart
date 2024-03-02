
import 'package:flutter/material.dart';
import 'package:LuxCal/widgets/custom/model.dart';

class NicknameModel extends CustomModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  final formKey = GlobalKey<FormState>();

  late TextEditingController nicknameTextController;
  
  // State field(s) for TextField widget.
  Color? currentColor;
  String? currentColorText;

  /// Initialization and disposal methods.
  ///
  ///

  @override
  void initState(BuildContext context) {
    nicknameTextController = TextEditingController();
  }

  @override
  void dispose() {
    nicknameTextController.dispose();
  }

  /// Additional helper methods are added here.
}
