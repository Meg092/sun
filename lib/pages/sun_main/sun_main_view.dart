import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:sun_record/main.dart';
import 'package:table_calendar/table_calendar.dart';

import 'sun_main_logic.dart';

class SunMainPage extends StatefulWidget {
  const SunMainPage({Key? key}) : super(key: key);

  @override
  State<SunMainPage> createState() => _SunMainPageState();
}

class _SunMainPageState extends State<SunMainPage> {
  SunMainLogic controller = Get.find();

  void checkNetwork() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/load_error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: const Text(
          'Sun protection',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ).marginOnly(left: 20, top: 20),
        leadingWidth: 150,
        actions: [
          <Widget>[
            <Widget>[
              Obx(() {
                return Text(
                  controller.typeStr.value,
                  style: const TextStyle(color: Colors.black87),
                );
              }),
              Obx(() {
                return Text(
                  '${controller.c.value}°C',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              }),
            ].toColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start),
            const SizedBox(
              width: 8,
            ),
            Obx(() {
              return Icon(
                controller.weatherIcon.value,
                size: 50,
                color: Colors.black54,
              );
            }),
          ].toRow().marginOnly(right: 20)
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<SunMainLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                calendarFormat: controller.calendarFormat,
                onFormatChanged: (format) {
                  if (controller.calendarFormat != format) {
                    controller.calendarFormat = format;
                    controller.update();
                  }
                },
                currentDay: controller.currentDate,
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  controller.currentDate = selectedDay;
                  controller.update();
                  controller.getData();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              <Widget>[
                const Text(
                  '''Today's sun Protection Record''',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  'assets/icon0.webp',
                  fit: BoxFit.cover,
                ).gestures(onTap: () {
                  Get.toNamed('/sun_add')?.then((_) {
                    controller.getData();
                  });
                })
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
              const SizedBox(
                height: 10,
              ),
              controller.list.isEmpty
                  ? const Center(
                      child: Text('No data'),
                    ).marginOnly(top: 50)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.list.length,
                      itemBuilder: (_, index) {
                        final entity = controller.list[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              child: <Widget>[
                                <Widget>[
                                  Expanded(
                                      child: Text(entity.title,
                                          overflow: TextOverflow.ellipsis)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 28,
                                    alignment: Alignment.center,
                                    child: Text(
                                      entity.type == 0
                                          ? 'Milk and water'
                                          : 'Spray',
                                      style: TextStyle(
                                          color: entity.type == 0
                                              ? const Color(0xff2563eb)
                                              : const Color(0xff047857)),
                                    ),
                                  ).decorated(
                                      color: entity.type == 0
                                          ? const Color(0xff2563eb)
                                              .withOpacity(0.1)
                                          : const Color(0xff047857)
                                              .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(14))
                                ].toRow(),
                                const SizedBox(
                                  height: 20,
                                ),
                                <Widget>[
                                  Expanded(
                                      child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text(entity.startEndTimeStr,
                                        style: const TextStyle(
                                            color: Colors.black45)),
                                  ).decorated(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      '2 times',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ).decorated(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                ].toRow()
                              ].toColumn(),
                            ).decorated(color: Colors.white),
                          )
                              .decorated(
                                  borderRadius: BorderRadius.circular(10),
                                  color: entity.type == 0
                                      ? const Color(0xff8b5cf6)
                                      : const Color(0xff10b981))
                              .marginOnly(bottom: 10),
                        );
                      })
            ].toColumn(),
          );
        }).marginAll(15)),
      ),
    );
  }
}
