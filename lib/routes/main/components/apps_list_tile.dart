import 'package:code/routes/main/methods/open_app_view.dart';
import 'package:code/models/app.dart';
import 'package:flutter/material.dart';

class AppsListTile extends StatelessWidget {
  final AppModel app;

  const AppsListTile({
    required this.app,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        openAppView(context, app);
      },
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: app.themeColor,
        ),
        width: 30,
        height: 30,
      ),
      title: Text(app.name),
      trailing: const Icon(
        Icons.folder,
      ),
    );
  }
}
