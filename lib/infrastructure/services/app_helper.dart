import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../presentation/style/style.dart';
import '../../presentation/utils/change_button.dart';

abstract class AppHelpers {
  AppHelpers._();

  static showBottomChange(
      {required BuildContext context, required VoidCallback onEdit, required VoidCallback onDelete}) {
    showModalBottomSheet(
        backgroundColor: Style.transparent,
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(16.r))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Card Settings",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontSize: 20),
                ),
                18.verticalSpace,
                Divider(
                  height: 1,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                18.verticalSpace,
                ChangeButton(
                  onTap:onEdit,
                  title: 'Edit',
                  icon: Icons.edit,
                ),
                7.verticalSpace,
                ChangeButton(
                  onTap: onDelete,
                  title: 'Delate',
                  icon: Icons.delete,
                ),
                32.verticalSpace,
              ],
            ),
          );
        });
  }


  static showConfirm(BuildContext context,VoidCallback  onSummit){
    return  showDialog(
        context: context,
        builder: (_) => AlertDialog(
      title: Text('Confirm',style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),),
      content: Text(
        'Would you like to remove?',
        style: Theme.of(context)
            .textTheme
            .displaySmall?.copyWith(fontSize: 18),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(
                  context);
            },
            child: Text(
              'No',
              style: Theme.of(
                  context)
                  .textTheme
                  .displayMedium,
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(
                  context);
            },
            child: Text(
              'Yes',
              style: Theme.of(
                  context)
                  .textTheme
                  .displayMedium,
            )),
      ],
    ),
    );
  }
}
