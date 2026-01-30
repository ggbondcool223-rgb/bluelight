import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'custom_light_logic.dart';
import '../../lang/lang.dart';
import '../../components/fullscreen_light_page.dart';

class CustomLightView extends GetView<CustomLightLogic> {
  const CustomLightView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullscreenLightPage(
      title: Lang.customLight,
      onBack: controller.goBack,
      lightContent: Obx(() {
        final isOn = controller.isOn.value;
        final patternIndex = controller.patternIndex.value;
        final isFlashing = controller.isFlashing.value;
        final selectedColorIndex = controller.selectedColorIndex.value;
        Color color;
        if (!isOn) {
          color = Colors.black;
        } else if (patternIndex == 0 || isFlashing) {
          color = controller.colors[selectedColorIndex];
        } else {
          color = Colors.black;
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: color,
        );
      }),
      controlPanel: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildControlButton(),
            SizedBox(height: ScreenUtil().setHeight(20)),
            _buildColorSelector(),
            SizedBox(height: ScreenUtil().setHeight(20)),
            _buildPatternSelector(),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Obx(() => controller.patternIndex.value > 0
                ? _buildFrequencySlider()
                : const SizedBox.shrink()),
          ],
        ),
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
                      color: controller.selectedColorIndex.value == index
                          ? Colors.white
                          : Colors.transparent,
                      width: ScreenUtil().setWidth(3),
                    ),
                    boxShadow: controller.selectedColorIndex.value == index
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

  Widget _buildPatternSelector() {
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
            Lang.pattern,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(controller.patterns.length, (index) {
              return Obx(() => GestureDetector(
                onTap: () => controller.selectPattern(index),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(12),
                  ),
                  decoration: BoxDecoration(
                    color: controller.patternIndex.value == index
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                    border: Border.all(
                      color: controller.patternIndex.value == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.3),
                      width: ScreenUtil().setWidth(1),
                    ),
                  ),
                  child: Text(
                    controller.patterns[index],
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.white,
                      fontWeight: controller.patternIndex.value == index
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

  Widget _buildFrequencySlider() {
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
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Lang.frequency,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${controller.frequency.value.toStringAsFixed(1)} Hz',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          )),
          SizedBox(height: ScreenUtil().setHeight(8)),
          Obx(() => SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
              thumbColor: Colors.white,
              overlayColor: Colors.white.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: controller.frequency.value,
              min: 1.0,
              max: 10.0,
              divisions: 90,
              onChanged: controller.setFrequency,
            ),
          )),
        ],
      ),
    );
  }
}
