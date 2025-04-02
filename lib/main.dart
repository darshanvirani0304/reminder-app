import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reminder/app/routes/route.dart';
import 'package:reminder/app/themes/themes.dart';
import 'package:reminder/db/db_helper.dart';
import 'package:reminder/db/reminder_db.dart';
import 'package:reminder/services/services.dart';
import 'package:reminder/shared/constant/constant.dart';
import 'package:reminder/shared/extensions/extensions.dart';
import 'package:reminder/shared/utils/permission_heandler.dart';
import 'package:reminder/views/pages/pages.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ReminderDb.db = await openDb();
  tz.initializeTimeZones();
  await NotificationService().initializeNotification();
  await ThemeModePrefrence().initializeThemeModePreference();
  await PermissionHeandler().handleNotificationPermission();
  await DbHelper().createTable();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeModeController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black.withValues(alpha: 0.5),
        statusBarBrightness: context.isDark ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: context.isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Color(0xFF161A1D)
      )
    );

    return Consumer<ThemeModeController>(
      builder: (context, themeModeController, child) {
        ScreenUtil.init(
          context,
          designSize: Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
        );
        return MaterialApp(
          title: 'Reminder App',
          debugShowCheckedModeBanner: false,
          theme: ReminderThemeData.light().copyWith(
            platform: defaultTargetPlatform,
          ),
          darkTheme: ReminderThemeData.dark().copyWith(
            platform: defaultTargetPlatform,
          ),
          themeMode: themeModeController.themeMode,
          navigatorKey: rootNavigatorKey,
          initialRoute: SplashPage.route,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
