import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'metronome_light_logic.dart';
import '../../lang/lang.dart';
import '../../components/fullscreen_light_page.dart';

class MetronomeLightView extends GetView<MetronomeLightLogic> {
  const MetronomeLightView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullscreenLightPage(
      title: Lang.metronomeLight,
      onBack: controller.goBack,
      lightContent: Obx(() {
        final isOn = controller.isOn.value;
        final isFlashing = controller.isFlashing.value;
        final bpm = controller.bpm.value;
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: isOn ? (isFlashing ? Colors.white : Colors.black) : Colors.black,
          child: isOn
              ? Center(
                  child: Text(
                    '$bpm ${Lang.bpm}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(64),
                      color: isFlashing ? Colors.yellow : Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: ScreenUtil().setSp(4),
                    ),
                  ),
                )
              : null,
        );
      }),
      controlPanel: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _buildBpmSelector(),
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

  Widget _buildBpmSelector() {
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
            Lang.beatsPerMinute,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(12)),
          Row(
            children: [
              Expanded(
                child: Obx(() => SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                    thumbColor: Colors.white,
                    overlayColor: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: Slider(
                    value: controller.bpm.value.toDouble(),
                    min: 40,
                    max: 200,
                    divisions: 160,
                    label: '${controller.bpm.value}',
                    onChanged: (value) => controller.setBpm(value.toInt()),
                  ),
                )),
              ),
              SizedBox(width: ScreenUtil().setWidth(16)),
              Obx(() => Container(
                width: ScreenUtil().setWidth(60),
                alignment: Alignment.center,
                child: Text(
                  '${controller.bpm.value}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(18),
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
