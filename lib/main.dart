import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';
import '../pages/toolbox/toolbox_binding.dart';
import '../pages/toolbox/toolbox_view.dart';
import '../pages/colorful_light/colorful_light_binding.dart';
import '../pages/colorful_light/colorful_light_view.dart';
import '../pages/police_light/police_light_binding.dart';
import '../pages/police_light/police_light_view.dart';
import '../pages/incandescent_light/incandescent_light_binding.dart';
import '../pages/incandescent_light/incandescent_light_view.dart';
import '../pages/electronic_candle/electronic_candle_binding.dart';
import '../pages/electronic_candle/electronic_candle_view.dart';
import '../pages/traffic_light/traffic_light_binding.dart';
import '../pages/traffic_light/traffic_light_view.dart';
import '../pages/fault_light/fault_light_binding.dart';
import '../pages/fault_light/fault_light_view.dart';
import '../pages/sos_light/sos_light_binding.dart';
import '../pages/sos_light/sos_light_view.dart';
import '../pages/strobe_light/strobe_light_binding.dart';
import '../pages/strobe_light/strobe_light_view.dart';
import '../pages/breathing_light/breathing_light_binding.dart';
import '../pages/breathing_light/breathing_light_view.dart';
import '../pages/rainbow_light/rainbow_light_binding.dart';
import '../pages/rainbow_light/rainbow_light_view.dart';
import '../pages/custom_light/custom_light_binding.dart';
import '../pages/custom_light/custom_light_view.dart';
import '../pages/metronome_light/metronome_light_binding.dart';
import '../pages/metronome_light/metronome_light_view.dart';
import '../pages/mood_light/mood_light_binding.dart';
import '../pages/mood_light/mood_light_view.dart';
import '../pages/timer_light/timer_light_binding.dart';
import '../pages/timer_light/timer_light_view.dart';
import '../pages/flashlight/flashlight_binding.dart';
import '../pages/flashlight/flashlight_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Tools',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFFF8FAFC),
            fontFamily: '.SF Pro Text',
          ),
          initialRoute: '/light_home',
          getPages: LightsTool,
        );
      },
    );
  }
}
List<GetPage<dynamic>> LightsTool = [
  GetPage(
    name: '/light_home',
    page: () => const HomeView(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: '/toolbox',
    page: () => const ToolboxView(),
    binding: ToolboxBinding(),
  ),
  GetPage(
    name: '/colorful_light',
    page: () => const ColorfulLightView(),
    binding: ColorfulLightBinding(),
  ),
  GetPage(
    name: '/police_light',
    page: () => const PoliceLightView(),
    binding: PoliceLightBinding(),
  ),
  GetPage(
    name: '/incandescent_light',
    page: () => const IncandescentLightView(),
    binding: IncandescentLightBinding(),
  ),
  GetPage(
    name: '/electronic_candle',
    page: () => const ElectronicCandleView(),
    binding: ElectronicCandleBinding(),
  ),
  GetPage(
    name: '/traffic_light',
    page: () => const TrafficLightView(),
    binding: TrafficLightBinding(),
  ),
  GetPage(
    name: '/fault_light',
    page: () => const FaultLightView(),
    binding: FaultLightBinding(),
  ),
  GetPage(
    name: '/sos_light',
    page: () => const SosLightView(),
    binding: SosLightBinding(),
  ),
  GetPage(
    name: '/strobe_light',
    page: () => const StrobeLightView(),
    binding: StrobeLightBinding(),
  ),
  GetPage(
    name: '/breathing_light',
    page: () => const BreathingLightView(),
    binding: BreathingLightBinding(),
  ),
  GetPage(
    name: '/rainbow_light',
    page: () => const RainbowLightView(),
    binding: RainbowLightBinding(),
  ),
  GetPage(
    name: '/custom_light',
    page: () => const CustomLightView(),
    binding: CustomLightBinding(),
  ),
  GetPage(
    name: '/metronome_light',
    page: () => const MetronomeLightView(),
    binding: MetronomeLightBinding(),
  ),
  GetPage(
    name: '/mood_light',
    page: () => const MoodLightView(),
    binding: MoodLightBinding(),
  ),
  GetPage(
    name: '/timer_light',
    page: () => const TimerLightView(),
    binding: TimerLightBinding(),
  ),
  GetPage(
    name: '/flash_light',
    page: () => const FlashlightView(),
    binding: FlashlightBinding(),
  ),
];