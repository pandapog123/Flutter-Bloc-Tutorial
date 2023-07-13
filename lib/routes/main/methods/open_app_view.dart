import 'package:code/routes/app_view/main.dart';
import 'package:code/models/app.dart';
import 'package:flutter/material.dart';

void openAppView(BuildContext context, AppModel app) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return AppViewWrapper(
          appId: app.id,
        );
      },
    ),
  );
}
