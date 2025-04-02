import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:reminder/shared/extensions/build_context_ex.dart';

class RedioBtnCard<T> extends StatelessWidget {
  final String themeModeName;
  final IconData iconData;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const RedioBtnCard({
    super.key,
    required this.themeModeName,
    required this.iconData,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(iconData, size: 20.w),
            Gap(16.w),
            Text(themeModeName, style: context.textTheme.labelSmall),
          ],
        ),
        Transform.scale(
          scale: 1.10,
          child: Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
