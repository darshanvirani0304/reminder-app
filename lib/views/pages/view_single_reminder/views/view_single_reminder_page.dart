import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/app/routes/routing_service.dart';
import 'package:reminder/models/reminder.dart';
import 'package:reminder/services/services.dart';
import 'package:reminder/shared/extensions/build_context_ex.dart';
import 'package:reminder/views/pages/view_single_reminder/controllers/view_single_reminder_controller.dart';
import 'package:reminder/views/pages/view_single_reminder/widgets/reminder_label.dart';

class ViewSingleReminderPage extends StatefulWidget {
  final Reminder reminder;

  const ViewSingleReminderPage({super.key, required this.reminder});

  static const String route = 'view-single-reminder';

  @override
  State<ViewSingleReminderPage> createState() => _ViewSingleReminderPageState();
}

class _ViewSingleReminderPageState extends State<ViewSingleReminderPage> {

  @override
  void initState() {
    super.initState();
    ViewSingleReminderController().of(context).onDeleteReminder = () {
      ToastService().showToastMessage(msg: 'Reminder Deleted');
      RoutingService.pop(result: true);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewSingleReminderController>(
      builder: (context, viewSingleReminderController, _) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Gap(8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          RoutingService.pop(result: false);
                        },
                        icon: Icon(Icons.close, size: 20.w,),
                      ),
                      TextButton(
                        onPressed: () async {
                          await viewSingleReminderController.deleteReminder(widget.reminder.id!);
                        },
                        child: Text('Delete', style: context.textTheme.bodyMedium?.copyWith(fontSize: 15.sp, color: context.colorScheme.error,),),
                      )
                    ],
                  ),
                ),
                Gap(14.h),
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Selected Remider', style: context.textTheme.headlineMedium,),
                      TextButton(
                        onPressed: (){
                          RoutingService.navigateToInsertUpdateReminderPage(reminder: widget.reminder).then((value) {
                            if(value) {
                              RoutingService.pop(result: value);
                            }
                          });
                        },
                        child: Text('Update', style: context.textTheme.bodyMedium?.copyWith(fontSize: 15.sp, color: context.colorScheme.secondary,),),
                      )
                    ],
                  ),
                ),
                Gap(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      ReminderLabel(
                        iconData: Icons.title,
                        label: widget.reminder.title,
                      ),
                      Gap(10.h),
                      ReminderLabel(
                        iconData: Icons.description,
                        label: widget.reminder.desc,
                      ),
                      Gap(10.h),
                      Row(
                        children: [
                          Expanded(
                            child: ReminderLabel(
                              iconData: Icons.calendar_month,
                              label: DateFormat('dd/MM/yyyy').format(widget.reminder.reminderDateTime),
                            ),
                          ),
                          Gap(10.h),
                          Expanded(
                            child: ReminderLabel(
                              iconData: Icons.access_time_filled,
                              label: DateFormat('hh:mm:ss a').format(widget.reminder.reminderDateTime),
                            ),
                          ),
                        ],
                      ),
                      Gap(10.h),
                      ReminderLabel(
                        iconData: widget.reminder.status ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        label: widget.reminder.status ? 'Completed' : 'Pending',
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
