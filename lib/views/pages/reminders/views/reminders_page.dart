import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:reminder/app/routes/routing_service.dart';
import 'package:reminder/models/reminder.dart';
import 'package:reminder/shared/constant/constant.dart';
import 'package:reminder/shared/extensions/extensions.dart';
import 'package:reminder/views/pages/pages.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();

  static const String route = '/reminder';
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  void initState() {
    super.initState();

    addPostFrameCallback(() {
      RemindersController().of(context).getReminders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RemindersController>(
      builder: (context, remindersController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Reminders'),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  RoutingService.navigateToSettingPage();
                },
                icon: Icon(Icons.settings),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: remindersController.reminders.isEmpty
                ? Center(
                    child: Text(
                    'No any Reminder',
                    style: TextStyle(color: Colors.grey),
                  ))
                : ListView.builder(
                    itemCount: remindersController.reminders.length,
                    itemBuilder: (context, index) {
                      Reminder reminder = remindersController.reminders[index];
                      return Container(
                        padding: EdgeInsets.only(left: 3.w, right: 13.w),
                        margin: EdgeInsets.only(
                          bottom: 10.h,
                          top: index == 0 ? 2.w : 0,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.secondary.withValues(
                            alpha: context.isDark ? 0.14 : 0.1,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: reminder.status,
                            onChanged: (value) {
                              if (reminder.id != null) {
                                remindersController.updateReminderStatus(
                                  reminder.id!,
                                  value ?? false,
                                );
                              }
                            },
                          ),
                          title: Text(
                            reminder.title,
                            style: context.textTheme.labelSmall?.copyWith(
                              fontSize: 14.sp,
                              decoration: reminder.status
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationThickness: 1.4,
                            ),
                          ),
                          horizontalTitleGap: 0,
                          contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                          onTap: () {
                            RoutingService.navigateToViewSingleReminderPage(
                              reminder: reminder,
                            ).then(
                              (value) {
                                if (value) {
                                  remindersController.getReminders();
                                }
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              RoutingService.navigateToInsertUpdateReminderPage().then((value) {
                if (value) {
                  remindersController.getReminders();
                }
              });
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
