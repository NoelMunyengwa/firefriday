import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firefriday/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

successMessage(BuildContext context, String message, Widget newPage) {
  StylishDialog successShow = StylishDialog(
    context: context,
    alertType: StylishDialogType.SUCCESS,
    title: Text(message),
    dismissOnTouchOutside: true,
    confirmButton: InkWell(
      onTap: () {
        context.pushRoot(() => newPage);
      },
      child: const Text('OK'),
    ),
  );
  return successShow;
}

errorMessage(BuildContext context, String message, Widget newPage) {
  StylishDialog errorShow = StylishDialog(
    context: context,
    alertType: StylishDialogType.ERROR,
    title: Text(message),
    dismissOnTouchOutside: true,
    confirmButton: InkWell(
      onTap: () {
        context.pushRoot(() => newPage);
      },
      child: const Text('OK'),
    ),
  );

  return errorShow;
}

loadingBar(BuildContext context, String message) {
  StylishDialog loadingShow = StylishDialog(
    context: context,
    alertType: StylishDialogType.PROGRESS,
    title: Text(message),
    dismissOnTouchOutside: false,
  );
  // loadingShow.show();
  return loadingShow;
}
