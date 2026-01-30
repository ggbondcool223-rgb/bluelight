import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'electronic_candle_logic.dart';
import '../../lang/lang.dart';
import '../../components/fullscreen_light_page.dart';

class ElectronicCandleView extends GetView<ElectronicCandleLogic> {
  const ElectronicCandleView({super.key});

  @override
  Widget build(BuildContext context) {
    return FullscreenLightPage(
      title: Lang.electronicCandle,
      onBack: controller.goBack,
      lightContent: Obx(() {
        controller.isOn.value;
        controller.animationValue.value;
        controller.flameSize.value;
        controller.brightness.value;
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: CustomPaint(
            painter: CandlePainter(
              logic: controller,
              screenUtil: ScreenUtil(),
            ),
          ),
        );
      }),
      controlPanel: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildControlButton(),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _buildBrightnessSlider(),
          SizedBox(height: ScreenUtil().setHeight(20)),
          _buildFlameSizeSlider(),
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

  Widget _buildBrightnessSlider() {
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
                Lang.brightness,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(controller.brightness.value * 100).round()}%',
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
              value: controller.brightness.value,
              onChanged: controller.setBrightness,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFlameSizeSlider() {
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
            Lang.flameSize,
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
              value: controller.flameSize.value,
              onChanged: controller.setFlameSize,
            ),
          )),
        ],
      ),
    );
  }
}

class CandlePainter extends CustomPainter {
  final ElectronicCandleLogic logic;
  final ScreenUtil screenUtil;
  
  CandlePainter({
    required this.logic,
    required this.screenUtil,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    if (!logic.isOn.value) return;
    
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final flameHeight = size.height * logic.getFlameHeight();
    final baseWidth = screenUtil.setWidth(40);
    final topWidth = baseWidth * (1 + logic.flameSize.value * 0.4);
    final animValue = logic.animationValue.value;
    
    final baseY = centerY + flameHeight / 2;
    final topY = centerY - flameHeight / 2;
    
    final wave1 = sin(animValue * 2 * pi) * 8;
    final wave2 = sin(animValue * 2 * pi + pi / 3) * 6;
    final wave3 = sin(animValue * 2 * pi + pi * 2 / 3) * 4;
    
    _drawOuterFlame(canvas, size, centerX, baseY, topY, baseWidth, topWidth, wave1, wave2, wave3);
    _drawMiddleFlame(canvas, size, centerX, baseY, topY, baseWidth, topWidth, wave1, wave2, wave3);
    _drawInnerFlame(canvas, size, centerX, baseY, topY, baseWidth, topWidth, wave1, wave2, wave3);
    _drawCoreFlame(canvas, size, centerX, baseY, topY, baseWidth, topWidth);
    _drawGlow(canvas, size, centerX, baseY, topY, baseWidth, topWidth);
  }
  
  void _drawOuterFlame(Canvas canvas, Size size, double centerX, double baseY, double topY, 
      double baseWidth, double topWidth, double wave1, double wave2, double wave3) {
    final path = Path();
    final leftBase = centerX - baseWidth / 2;
    final rightBase = centerX + baseWidth / 2;
    final leftTop = centerX - topWidth / 2 + wave1;
    final rightTop = centerX + topWidth / 2 + wave1;
    
    path.moveTo(leftBase, baseY);
    path.quadraticBezierTo(
      centerX - topWidth / 3 + wave2,
      baseY - (baseY - topY) * 0.3,
      leftTop,
      topY,
    );
    path.quadraticBezierTo(
      centerX + wave3,
      topY - 10,
      rightTop,
      topY,
    );
    path.quadraticBezierTo(
      centerX + topWidth / 3 + wave2,
      baseY - (baseY - topY) * 0.3,
      rightBase,
      baseY,
    );
    path.close();
    
    final gradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(255, 100, 0, 0.3),
        Color.fromRGBO(255, 150, 50, 0.4),
        Color.fromRGBO(255, 200, 100, 0.2),
        Colors.transparent,
      ],
      stops: const [0.0, 0.4, 0.7, 1.0],
    );
    
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, topY - 20, size.width, baseY - topY + 40))
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, paint);
  }
  
  void _drawMiddleFlame(Canvas canvas, Size size, double centerX, double baseY, double topY,
      double baseWidth, double topWidth, double wave1, double wave2, double wave3) {
    final path = Path();
    final innerBaseWidth = baseWidth * 0.7;
    final innerTopWidth = topWidth * 0.75;
    final leftBase = centerX - innerBaseWidth / 2;
    final rightBase = centerX + innerBaseWidth / 2;
    final leftTop = centerX - innerTopWidth / 2 + wave1 * 0.7;
    final rightTop = centerX + innerTopWidth / 2 + wave1 * 0.7;
    final midY = baseY - (baseY - topY) * 0.2;
    
    path.moveTo(leftBase, baseY);
    path.quadraticBezierTo(
      centerX - innerTopWidth / 3 + wave2 * 0.7,
      midY,
      leftTop,
      topY + 5,
    );
    path.quadraticBezierTo(
      centerX + wave3 * 0.7,
      topY - 5,
      rightTop,
      topY + 5,
    );
    path.quadraticBezierTo(
      centerX + innerTopWidth / 3 + wave2 * 0.7,
      midY,
      rightBase,
      baseY,
    );
    path.close();
    
    final gradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(255, 120, 30, 0.5),
        Color.fromRGBO(255, 180, 80, 0.6),
        Color.fromRGBO(255, 220, 150, 0.3),
        Colors.transparent,
      ],
      stops: const [0.0, 0.3, 0.6, 1.0],
    );
    
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, topY - 10, size.width, baseY - topY + 20))
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, paint);
  }
  
  void _drawInnerFlame(Canvas canvas, Size size, double centerX, double baseY, double topY,
      double baseWidth, double topWidth, double wave1, double wave2, double wave3) {
    final path = Path();
    final innerBaseWidth = baseWidth * 0.5;
    final innerTopWidth = topWidth * 0.55;
    final leftBase = centerX - innerBaseWidth / 2;
    final rightBase = centerX + innerBaseWidth / 2;
    final leftTop = centerX - innerTopWidth / 2 + wave1 * 0.5;
    final rightTop = centerX + innerTopWidth / 2 + wave1 * 0.5;
    final midY = baseY - (baseY - topY) * 0.15;
    
    path.moveTo(leftBase, baseY);
    path.quadraticBezierTo(
      centerX - innerTopWidth / 3 + wave2 * 0.5,
      midY,
      leftTop,
      topY + 8,
    );
    path.quadraticBezierTo(
      centerX + wave3 * 0.5,
      topY,
      rightTop,
      topY + 8,
    );
    path.quadraticBezierTo(
      centerX + innerTopWidth / 3 + wave2 * 0.5,
      midY,
      rightBase,
      baseY,
    );
    path.close();
    
    final gradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(255, 200, 100, 0.7),
        Color.fromRGBO(255, 230, 150, 0.8),
        Color.fromRGBO(255, 250, 200, 0.4),
        Colors.transparent,
      ],
      stops: const [0.0, 0.25, 0.5, 1.0],
    );
    
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, topY, size.width, baseY - topY + 10))
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, paint);
  }
  
  void _drawCoreFlame(Canvas canvas, Size size, double centerX, double baseY, double topY,
      double baseWidth, double topWidth) {
    final path = Path();
    final coreBaseWidth = baseWidth * 0.3;
    final coreTopWidth = topWidth * 0.35;
    final leftBase = centerX - coreBaseWidth / 2;
    final rightBase = centerX + coreBaseWidth / 2;
    final leftTop = centerX - coreTopWidth / 2;
    final rightTop = centerX + coreTopWidth / 2;
    final coreTopY = topY + 10;
    
    path.moveTo(leftBase, baseY);
    path.quadraticBezierTo(
      centerX - coreTopWidth / 3,
      baseY - (baseY - coreTopY) * 0.4,
      leftTop,
      coreTopY,
    );
    path.quadraticBezierTo(
      centerX,
      coreTopY - 3,
      rightTop,
      coreTopY,
    );
    path.quadraticBezierTo(
      centerX + coreTopWidth / 3,
      baseY - (baseY - coreTopY) * 0.4,
      rightBase,
      baseY,
    );
    path.close();
    
    final gradient = RadialGradient(
      center: Alignment.topCenter,
      radius: 0.8,
      colors: [
        Colors.white.withValues(alpha: 0.9),
        Color.fromRGBO(255, 255, 200, 0.8),
        Color.fromRGBO(255, 240, 180, 0.6),
        Colors.transparent,
      ],
      stops: const [0.0, 0.3, 0.6, 1.0],
    );
    
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(
        centerX - topWidth,
        coreTopY - 20,
        topWidth * 2,
        baseY - coreTopY + 20,
      ))
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, paint);
  }
  
  void _drawGlow(Canvas canvas, Size size, double centerX, double baseY, double topY,
      double baseWidth, double topWidth) {
    final glowRadius = topWidth * 1.5;
    final glowPaint = Paint()
      ..color = Color.fromRGBO(255, 150, 50, 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    
    canvas.drawCircle(
      Offset(centerX, topY + 10),
      glowRadius,
      glowPaint,
    );
    
    final innerGlowPaint = Paint()
      ..color = Color.fromRGBO(255, 200, 100, 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    
    canvas.drawCircle(
      Offset(centerX, topY + 8),
      glowRadius * 0.6,
      innerGlowPaint,
    );
  }
  
  @override
  bool shouldRepaint(CandlePainter oldDelegate) {
    return true;
  }
}
