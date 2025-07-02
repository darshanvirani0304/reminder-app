import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:reminder/app/routes/routing_service.dart';
import 'package:reminder/shared/extensions/build_context_ex.dart';
import 'package:reminder/views/pages/setting/controllers/theme_mode_controller.dart';
import 'package:reminder/views/pages/setting/widgets/redio_btn_card.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static const String route = '/setting-theme-mode';

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeController>(
      builder: (context, themeModeController, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Setting'),
            leading: IconButton(
              onPressed: () {
                RoutingService.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18.w,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: context.textTheme.displayMedium
                        ?.copyWith(fontSize: 20.sp),
                  ),
                  Gap(18.h),
                  RedioBtnCard<ThemeMode>(
                    themeModeName: 'Light',
                    iconData: Icons.light_mode,
                    value: ThemeMode.light,
                    groupValue: themeModeController.themeMode,
                    onChanged: (value) {
                      themeModeController.onThemeChanged(
                        context,
                        ThemeMode.light,
                      );
                    },
                  ),
                  Gap(22),
                  RedioBtnCard<ThemeMode>(
                    themeModeName: 'Dark',
                    iconData: Icons.dark_mode,
                    value: ThemeMode.dark,
                    groupValue: themeModeController.themeMode,
                    onChanged: (value) {
                      themeModeController.onThemeChanged(
                        context,
                        ThemeMode.dark,
                      );
                    },
                  ),
                  Gap(22),
                  RedioBtnCard<ThemeMode>(
                    themeModeName: 'System Theme',
                    iconData: Icons.computer,
                    value: ThemeMode.system,
                    groupValue: themeModeController.themeMode,
                    onChanged: (value) {
                      themeModeController.onThemeChanged(
                        context,
                        ThemeMode.system,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
