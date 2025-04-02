import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:reminder/app/routes/routing_service.dart';
import 'package:reminder/models/reminder.dart';
import 'package:reminder/services/services.dart';
import 'package:reminder/shared/constant/constant.dart';
import 'package:reminder/shared/extensions/build_context_ex.dart';
import 'package:reminder/shared/utils/field_validator.dart';
import 'package:reminder/views/pages/insert_update_reminder/controllers/insert_update_reminder_controller.dart';
import 'package:reminder/views/widgets/widgets.dart';

class InsertUpdateReminderPage extends StatefulWidget {
  final Reminder? reminder;

  const InsertUpdateReminderPage({super.key, this.reminder});

  static const String route = 'insert-update-reminder';

  @override
  State<InsertUpdateReminderPage> createState() =>
      _InsertUpdateReminderPageState();
}

class _InsertUpdateReminderPageState extends State<InsertUpdateReminderPage> {
  @override
  void initState() {
    super.initState();
    addPostFrameCallback(() {
      InsertUpdateReminderController().of(context)
        ..onReminderInsertAndUpdate = () {
          ToastService().showToastMessage(
              msg: 'Reminder ${widget.reminder != null ? 'Updated' : 'Added'}');
          RoutingService.pop(result: true);
        }
        ..getReminderData(widget.reminder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InsertUpdateReminderController>(
      builder: (context, insertUpdateReminderController, child) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: insertUpdateReminderController.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              RoutingService.pop(result: false);
                            },
                            icon: Icon(
                              Icons.close,
                              size: 20.w,
                            ),
                          ),
                          TextButton(
                            onPressed: () => insertUpdateReminderController
                                .insertUpdateReminder(context),
                            child: Text(
                              widget.reminder == null ? 'Save' : 'Update',
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 15.sp,
                                color: context.colorScheme.secondary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Gap(14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.reminder == null
                                ? 'Add Reminder'
                                : 'Update Reminder',
                            style: context.textTheme.displayMedium,
                          ),
                          Gap(14.h),
                          ReminderTextField(
                            controller: insertUpdateReminderController.titleController,
                            validator: (value) => FieldValidator.validateTextField(value, 'Title',),
                            hintText: 'Title',
                            prefixIcon: Icon(Icons.title),
                          ),
                          Gap(14.h),
                          ReminderTextField(
                            controller: insertUpdateReminderController.descController,
                            validator: (value) => FieldValidator.validateTextField(value, 'Description'),
                            hintText: 'Description',
                            prefixIcon: Icon(Icons.description),
                            maxlines: 2,
                          ),
                          Gap(14.h),
                          DateTimeSelector(
                            selectedDay: insertUpdateReminderController.selectedDay,
                            selectedTime: insertUpdateReminderController.selectedTime,
                            onDateTimeChange: insertUpdateReminderController.updateDateTime,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
