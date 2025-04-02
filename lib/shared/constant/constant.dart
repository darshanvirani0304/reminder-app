import 'package:flutter/material.dart';
export 'app_assets.dart';

GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

void addPostFrameCallback(VoidCallback fn) {
  WidgetsBinding.instance.addPostFrameCallback((_) => fn());
}
