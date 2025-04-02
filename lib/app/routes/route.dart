import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/reminder.dart';
import 'package:reminder/views/pages/pages.dart';

abstract class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SplashPage(),
        );
      case RemindersPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return ChangeNotifierProvider(
              create: (context) => RemindersController(),
              child: RemindersPage(),
            );
          },
        );
      case InsertUpdateReminderPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return ChangeNotifierProvider(
              create: (context) => InsertUpdateReminderController(),
              child: InsertUpdateReminderPage(
                reminder: settings.arguments as Reminder?,
              ),
            );
          },
        );
      case ViewSingleReminderPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return ChangeNotifierProvider(
              create: (context) => ViewSingleReminderController(),
              child: ViewSingleReminderPage(
                reminder: settings.arguments as Reminder,
              ),
            );
          },
        );
      case SettingPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SettingPage(),
        );
    }
    return null;
  }
}
