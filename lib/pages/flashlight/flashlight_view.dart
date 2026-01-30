import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'flashlight_logic.dart';
import '../../lang/lang.dart';
import '../../components/fullscreen_light_page.dart';

class FlashlightView extends GetView<FlashlightLogic> {
  const FlashlightView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullscreenLightPage(
      title: Lang.flashlight,
      onBack: controller.goBack,
      lightContent: Obx(() {
        final isOn = controller.isOn.value;
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: isOn ? Colors.white : Colors.black,
        );
      }),
      controlPanel: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _buildTimerSelector(),
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

  Widget _buildTimerSelector() {
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
            Lang.timer,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(12)),
          Wrap(
            spacing: ScreenUtil().setWidth(12),
            runSpacing: ScreenUtil().setHeight(12),
            children: List.generate(controller.timerOptions.length, (index) {
              final label = index == 6 
                  ? Lang.manualOff 
                  : '${controller.timerOptions[index]}${Lang.minute}';
              
              return Obx(() => GestureDetector(
                onTap: () => controller.selectTimer(index),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(12),
                  ),
                  decoration: BoxDecoration(
                    color: controller.selectedTimerIndex.value == index
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                    border: Border.all(
                      color: controller.selectedTimerIndex.value == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.3),
                      width: ScreenUtil().setWidth(1),
                    ),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.white,
                      fontWeight: controller.selectedTimerIndex.value == index
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ));
            }),
          ),
        ],
      ),
    );
  }
}
