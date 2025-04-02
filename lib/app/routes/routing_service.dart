import 'package:flutter/material.dart';
import 'package:reminder/models/reminder.dart';
import 'package:reminder/shared/constant/constant.dart';
import 'package:reminder/views/pages/pages.dart';

class RoutingService {
  static final NavigatorState _navigatorState = rootNavigatorKey.currentState!;

  static Future<T?> navigateToSplashPage<T>() {
    return _navigatorState.pushNamedAndRemoveUntil(
      SplashPage.route,
      (route) => false,
    );
  }

  static Future<T?> navigateToRemindersPage<T>() {
    return _navigatorState.pushNamedAndRemoveUntil(
      RemindersPage.route,
      (route) => false,
    );
  }

  static Future<T?> navigateToInsertUpdateReminderPage<T>({
    Reminder? reminder,
  }) {
    return _navigatorState.pushNamed(
      InsertUpdateReminderPage.route,
      arguments: reminder,
    );
  }

  static Future<T?> navigateToViewSingleReminderPage<T>({
    required Reminder reminder,
  }) {
    return _navigatorState.pushNamed(
      ViewSingleReminderPage.route,
      arguments: reminder,
    );
  }

  static Future<T?> navigateToSettingPage<T>() {
    return _navigatorState.pushNamed(SettingPage.route);
  }

  static void pop<T>({
    T? result,
    String? popTo,
  }) {
    if (popTo != null) {
      return _navigatorState.popUntil((route) => route.settings.name == popTo);
    } else {
      return _navigatorState.pop(result);
    }
  }
}
