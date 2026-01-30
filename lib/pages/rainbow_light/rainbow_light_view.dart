import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'rainbow_light_logic.dart';
import '../../lang/lang.dart';
import '../../components/fullscreen_light_page.dart';

class RainbowLightView extends GetView<RainbowLightLogic> {
  const RainbowLightView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullscreenLightPage(
      title: Lang.rainbowLight,
      onBack: controller.goBack,
      lightContent: Obx(() {
        final isOn = controller.isOn.value;
        final animationValue = controller.animationValue.value;
        if (!isOn) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          );
        }
        final hue0 = (animationValue + 0.0) % 1.0;
        final hue1 = (animationValue + 0.33) % 1.0;
        final hue2 = (animationValue + 0.66) % 1.0;
        final hue3 = (animationValue + 1.0) % 1.0;
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                HSVColor.fromAHSV(1.0, hue0 * 360, 1.0, 1.0).toColor(),
                HSVColor.fromAHSV(1.0, hue1 * 360, 1.0, 1.0).toColor(),
                HSVColor.fromAHSV(1.0, hue2 * 360, 1.0, 1.0).toColor(),
                HSVColor.fromAHSV(1.0, hue3 * 360, 1.0, 1.0).toColor(),
              ],
              stops: const [0.0, 0.33, 0.66, 1.0],
            ),
          ),
        );
      }),
      controlPanel: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _buildFlowSpeedSlider(),
        ],
      ),
    );
  }

  Widget _buildControlButton() {
    return Obx(() => GestureDetector(
      onTap: controller.toggleLight,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(18)),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(ScreenUtil().radius(16)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: ScreenUtil().setWidth(1),
          ),
        ),
        child: Center(
          child: Text(
            controller.isOn.value ? Lang.off : Lang.on,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(20),
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: ScreenUtil().setSp(2),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildFlowSpeedSlider() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(ScreenUtil().radius(16)),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: ScreenUtil().setWidth(1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Lang.flowSpeed,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(8)),
          Obx(() => SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
              thumbColor: Colors.white,
              overlayColor: Colors.white.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: controller.flowSpeed.value,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              onChanged: controller.setFlowSpeed,
            ),
          )),
        ],
      ),
    );
  }
}
