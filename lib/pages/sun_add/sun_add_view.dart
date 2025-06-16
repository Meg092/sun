import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:sun_record/main.dart';

import 'sun_add_logic.dart';

class SunAddPage extends GetView<SunAddLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add record')),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<SunAddLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  Container(
                    color: Colors.transparent,
                    child: <Widget>[
                      <Widget>[
                        Image.asset(
                          'assets/img0.webp',
                          fit: BoxFit.cover,
                        ).marginOnly(bottom: 30),
                      ].toColumn(),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: <Widget>[
                        const Text(
                          'Sunscreen brand',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.title,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Colors.grey,
                      )
                    ].toRow(),
                  ).gestures(onTap: () {
                    controller.editTitle();
                  }),
                  Divider(
                    height: 35,
                    color: Colors.grey.shade300,
                  ),
                  <Widget>[
                    <Widget>[
                      Image.asset(
                        'assets/img1.webp',
                        fit: BoxFit.cover,
                      ).marginOnly(bottom: 30),
                    ].toColumn(),
                    const SizedBox(
                      width: 10,
                    ),
                    <Widget>[
                      const Text(
                        'Sun protection type',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 28,
                          alignment: Alignment.center,
                          child: const Text(
                            'Milk and water',
                            style: TextStyle(color: Color(0xff2563eb)),
                          ),
                        )
                            .decorated(
                                color: const Color(0xff2563eb).withOpacity(0.1),
                                border: controller.type == 0
                                    ? Border.all(color: primaryColor)
                                    : null,
                                borderRadius: BorderRadius.circular(14))
                            .gestures(onTap: () {
                          controller.type = 0;
                          controller.update();
                        }),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 28,
                          alignment: Alignment.center,
                          child: const Text(
                            'Spray',
                            style: TextStyle(color: Color(0xff047857)),
                          ),
                        )
                            .decorated(
                                color: const Color(0xff047857).withOpacity(0.1),
                                border: controller.type == 1
                                    ? Border.all(color: primaryColor)
                                    : null,
                                borderRadius: BorderRadius.circular(14))
                            .gestures(onTap: () {
                          controller.type = 1;
                          controller.update();
                        }),
                      ].toRow()
                    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                  ].toRow(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: <Widget>[
                      <Widget>[
                        Image.asset(
                          'assets/img2.webp',
                          fit: BoxFit.cover,
                        ).marginOnly(bottom: 30),
                      ].toColumn(),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: <Widget>[
                        const Text(
                          'Next reminder time',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.nextRemindStr,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Colors.grey,
                      )
                    ].toRow(),
                  ).gestures(onTap: () {
                    controller.selectStartEndTime(context);
                  }),
                ].toColumn(),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              const SizedBox(
                height: 200,
              ),
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'Add record',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
                  .decorated(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(25))
                  .gestures(onTap: () {
                controller.addSun();
              })
            ].toColumn(),
          );
        }).marginAll(15)),
      ),
    );
  }
}
