import 'package:flutter/material.dart';

class FormFieldFocusNode {
  static  focusField(
      BuildContext context, FocusNode currentNode, FocusNode nextNode) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }
}
