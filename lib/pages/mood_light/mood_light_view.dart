import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'mood_light_logic.dart';
import '../../lang/lang.dart';
import '../../components/fullscreen_light_page.dart';

class MoodLightView extends GetView<MoodLightLogic> {
  const MoodLightView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullscreenLightPage(
      title: Lang.moodLight,
      onBack: controller.goBack,
      lightContent: Obx(() {
        final isOn = controller.isOn.value;
        final selectedMoodIndex = controller.selectedMoodIndex.value;
        final animationValue = controller.animationValue.value;
        final mood = controller.moods[selectedMoodIndex];
        final moodName = mood['name'];
        Color color;
        if (!isOn) {
          color = Colors.black;
        } else {
          final Color baseColor = mood['color'];
          final double opacity = 0.5 + (animationValue * 0.5);
          color = baseColor.withValues(alpha: opacity);
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: color,
          child: isOn
              ? Center(
                  child: Text(
                    moodName,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(48),
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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
          _buildMoodSelector(),
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

  Widget _buildMoodSelector() {
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
            'Emotional Choice',
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
            children: List.generate(controller.moods.length, (index) {
              final mood = controller.moods[index];
              return Obx(() => GestureDetector(
                onTap: () => controller.selectMood(index),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(16),
                    vertical: ScreenUtil().setHeight(12),
                  ),
                  decoration: BoxDecoration(
                    color: controller.selectedMoodIndex.value == index
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                    border: Border.all(
                      color: controller.selectedMoodIndex.value == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.3),
                      width: ScreenUtil().setWidth(1),
                    ),
                  ),
                  child: Text(
                    mood['name'],
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.white,
                      fontWeight: controller.selectedMoodIndex.value == index
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
