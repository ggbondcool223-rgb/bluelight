import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'timer_light_logic.dart';
import '../../lang/lang.dart';
import '../../components/fullscreen_light_page.dart';

class TimerLightView extends GetView<TimerLightLogic> {
  const TimerLightView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullscreenLightPage(
      title: Lang.timerLight,
      onBack: controller.goBack,
      lightContent: Obx(() {
        final isRunning = controller.isRunning.value;
        final remainingSeconds = controller.remainingSeconds.value;
        final totalSeconds = controller.totalSeconds.value;
        final isFlashing = controller.isFlashing.value;
        final minutes = remainingSeconds ~/ 60;
        final seconds = remainingSeconds % 60;
        final formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        Color color;
        if (!isRunning && remainingSeconds == totalSeconds) {
          color = Colors.black;
        } else {
          final double progress = 1.0 - (remainingSeconds / totalSeconds);
          final double intensity = progress.clamp(0.0, 1.0);
          if (isFlashing && remainingSeconds == 0) {
            color = Colors.red;
          } else {
            color = Colors.white.withValues(alpha: intensity);
          }
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: color,
          child: Center(
            child: Text(
              formattedTime,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(96),
                color: isRunning || remainingSeconds < totalSeconds
                    ? Colors.white
                    : Colors.grey,
                fontWeight: FontWeight.w900,
                fontFeatures: [const FontFeature.tabularFigures()],
                letterSpacing: ScreenUtil().setSp(8),
              ),
            ),
          ),
        );
      }),
      controlPanel: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimeSelector(),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildTimeSelector() {
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
            Lang.countdown,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimeButton(5),
              _buildTimeButton(10),
              _buildTimeButton(15),
              _buildTimeButton(30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeButton(int minutes) {
    return Obx(() => GestureDetector(
      onTap: () => controller.setTime(minutes),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(16),
          vertical: ScreenUtil().setHeight(12),
        ),
        decoration: BoxDecoration(
          color: (controller.totalSeconds.value ~/ 60) == minutes && !controller.isRunning.value
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
          border: Border.all(
            color: (controller.totalSeconds.value ~/ 60) == minutes && !controller.isRunning.value
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
            width: ScreenUtil().setWidth(1),
          ),
        ),
        child: Text(
          '${minutes}min',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(12),
            color: Colors.white,
            fontWeight: (controller.totalSeconds.value ~/ 60) == minutes && !controller.isRunning.value
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
      ),
    ));
  }

  Widget _buildControlButtons() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (!controller.isRunning.value && controller.remainingSeconds.value == controller.totalSeconds.value)
          Expanded(
            child: _buildControlButton(Lang.start, controller.startTimer, Colors.white),
          )
        else if (controller.isRunning.value)
          Expanded(
            child: _buildControlButton(Lang.pause, controller.pauseTimer, Colors.white),
          )
        else
          Expanded(
            child: _buildControlButton(Lang.start, controller.startTimer, Colors.white),
          ),
        SizedBox(width: ScreenUtil().setWidth(12)),
        Expanded(
          child: _buildControlButton(Lang.reset, controller.resetTimer, Colors.white.withValues(alpha: 0.5)),
        ),
      ],
    ));
  }

  Widget _buildControlButton(String label, VoidCallback onTap, Color backgroundColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(18)),
        decoration: BoxDecoration(
          color: backgroundColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(ScreenUtil().radius(16)),
          border: Border.all(
            color: backgroundColor.withValues(alpha: 0.3),
            width: ScreenUtil().setWidth(1),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(18),
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: ScreenUtil().setSp(2),
            ),
          ),
        ),
      ),
    );
  }
}
