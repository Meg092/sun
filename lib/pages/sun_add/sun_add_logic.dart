import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:sun_record/db_sun/db_sun.dart';
import 'package:sun_record/pages/sun_add/sun_text_field.dart';

import '../../db_sun/sun_entity.dart';

class SunAddLogic extends GetxController {
  DBSun dbSun = Get.find();

  var nextRemindStr = '-';

  String title = '';
  int type = 0;
  DateTime? startTime;
  DateTime? endTime;
  String startTimeStr = '';
  String endTimeStr = '';

  editTitle() async {
    var currentTitle = title;
    Get.dialog(AlertDialog(
      title: const Text(
        'Sunscreen brand',
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SunTextField(
            maxLength: 20,
            value: currentTitle,
            onChange: (v) {
              currentTitle = v;
            }),
      ).decorated(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade100)),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        TextButton(
          onPressed: () {
            title = currentTitle;
            update();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }

  selectStartEndTime(BuildContext context) async {
    var currentStartTime = startTime;
    var currentEndTime = endTime;
    var currentStartTimeStr = startTimeStr;
    var currentEndTimeStr = endTimeStr;
    Get.dialog(AlertDialog(
      title: const Text(
        'Next reminder time',
        textAlign: TextAlign.center,
      ),
      content: GetBuilder<SunAddLogic>(
          id: 'time',
          builder: (_) {
            return SizedBox(
              height: 110,
              child: <Widget>[
                Container(
                        width: 300,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: <Widget>[
                          Expanded(
                            child: IgnorePointer(
                              child: SunTextField(
                                  hintText: 'Select start time',
                                  value: currentStartTimeStr,
                                  onChange: (_) {}),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            size: 25,
                            color: Colors.grey,
                          )
                        ].toRow())
                    .decorated(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade100))
                    .gestures(onTap: () {
                  DatePicker.showDatePicker(context, dateFormat: 'MM/dd/yyyy HH:mm',
                      onConfirm: (date, list) {
                    currentStartTime = date;
                    currentStartTimeStr =
                        DateFormat('MM/dd/yyyy HH:mm').format(date);
                    update(['time']);
                  });
                }),
                const SizedBox(
                  height: 10,
                ),
                Container(
                        width: 300,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: <Widget>[
                          Expanded(
                            child: IgnorePointer(
                              child: SunTextField(
                                  hintText: 'Select end time',
                                  value: currentEndTimeStr,
                                  onChange: (_) {}),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            size: 25,
                            color: Colors.grey,
                          )
                        ].toRow())
                    .decorated(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade100))
                    .gestures(onTap: () {
                  DatePicker.showDatePicker(context, dateFormat: 'MM/dd/yyyy HH:mm',
                      onConfirm: (date, list) {
                    currentEndTime = date;
                    currentEndTimeStr =
                        DateFormat('MM/dd/yyyy HH:mm').format(date);
                    update(['time']);
                  });
                }),
              ].toColumn(),
            );
          }),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        TextButton(
          onPressed: () {
            if (currentStartTime == null || currentEndTime == null) {
              Fluttertoast.showToast(msg: 'Please select start and end time');
              return;
            }
            if (currentStartTime!.isAfter(currentEndTime!)) {
              Fluttertoast.showToast(msg: 'Start time must be before end time');
              return;
            }
            if (currentStartTime?.year != currentEndTime?.year ||
                currentStartTime?.month != currentEndTime?.month ||
                currentStartTime?.day != currentEndTime?.day) {
              Fluttertoast.showToast(
                  msg: 'Start time and end time must be in the same day');
              return;
            }
            startTime = currentStartTime!;
            endTime = currentEndTime!;
            nextRemindStr =
                '${DateFormat('MM/dd/yyyy').format(startTime!)} • ${DateFormat('HH:mm').format(startTime!)} - ${DateFormat('HH:mm').format(endTime!)}';
            update();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }

  void addSun() async {
    if (title.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter the sunscreen brand');
      return;
    }
    if (startTime == null || endTime == null) {
      Fluttertoast.showToast(msg: 'Please select the start and end time');
      return;
    }
    await dbSun.insertSun(SunEntity(
      id: 0,
      createdTime: DateTime.now(),
      title: title,
      type: type,
      startTime: startTime!,
      endTime: endTime!,
    ));
    Fluttertoast.showToast(msg: 'Add successfully');
    Get.back();
  }
}
