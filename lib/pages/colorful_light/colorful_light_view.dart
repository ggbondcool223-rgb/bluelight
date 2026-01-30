import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'colorful_light_logic.dart';
import '../../lang/lang.dart';
import '../../components/fullscreen_light_page.dart';

class ColorfulLightView extends GetView<ColorfulLightLogic> {
  const ColorfulLightView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullscreenLightPage(
      title: Lang.colorfulLight,
      onBack: controller.goBack,
      lightContent: Obx(() {
        final isOn = controller.isOn.value;
        final currentColorIndex = controller.currentColorIndex.value;
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: isOn ? controller.colors[currentColorIndex] : Colors.black,
        );
      }),
      controlPanel: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _buildColorSelector(),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _buildAutoCycleSwitch(),
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

  Widget _buildColorSelector() {
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
            Lang.color,
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
            children: List.generate(controller.colors.length, (index) {
              return Obx(() => GestureDetector(
                onTap: () => controller.selectColor(index),
                child: Container(
                  width: ScreenUtil().setWidth(50),
                  height: ScreenUtil().setWidth(50),
                  decoration: BoxDecoration(
                    color: controller.colors[index],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: controller.currentColorIndex.value == index
                          ? Colors.white
                          : Colors.transparent,
                      width: ScreenUtil().setWidth(3),
                    ),
                    boxShadow: controller.currentColorIndex.value == index
                        ? [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.5),
                              blurRadius: ScreenUtil().setWidth(8),
                              spreadRadius: ScreenUtil().setWidth(2),
                            ),
                          ]
                        : null,
                  ),
                ),
              ));
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoCycleSwitch() {
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(16),
        vertical: ScreenUtil().setHeight(12),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(ScreenUtil().radius(16)),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: ScreenUtil().setWidth(1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Lang.autoCycle,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(16),
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: controller.isAutoCycle.value,
            onChanged: (value) => controller.toggleAutoCycle(),
            activeColor: Colors.white,
            activeTrackColor: Colors.white.withValues(alpha: 0.5),
          ),
        ],
      ),
    ));
  }
}
