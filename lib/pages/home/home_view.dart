import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'home_logic.dart';
import '../../lang/lang.dart';

class HomeView extends GetView<HomeLogic> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF667EEA),
              const Color(0xFF764BA2),
              const Color(0xFFF093FB),
              const Color(0xFF4FACFE),
            ],
            stops: const [0.0, 0.3, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBatteryInfo(),
                      SizedBox(
                        height: constraints.maxHeight * 0.5,
                        child: Center(
                          child: _buildControlDial(),
                        ),
                      ),
                      _buildToolboxButton(),
                      SizedBox(height: ScreenUtil().setHeight(40)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBatteryInfo() {
    return Obx(() => Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30),
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(ScreenUtil().radius(20)),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: ScreenUtil().setWidth(1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: ScreenUtil().setWidth(20),
            offset: Offset(0, ScreenUtil().setHeight(8)),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.battery_charging_full,
              color: Colors.white,
              size: ScreenUtil().setSp(24),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(16)),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${controller.batteryLevel.value.toInt()}%',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: ScreenUtil().setSp(1),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ScreenUtil().setHeight(4)),
                Flexible(
                  child: Text(
                    '${Lang.remainingBatteryTime} ${controller.remainingTime.value}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildControlDial() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildTimerDial(),
        _buildPowerButton(),
      ],
    );
  }

  Widget _buildTimerDial() {
    return Obx(() => Container(
      width: ScreenUtil().setWidth(340),
      height: ScreenUtil().setWidth(340),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.15),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: ScreenUtil().setWidth(2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: ScreenUtil().setWidth(40),
            offset: Offset(0, ScreenUtil().setHeight(10)),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          ...List.generate(7, (index) {
            final angle = (index * 360 / 7 - 90) * 3.14159 / 180;
            final radius = ScreenUtil().setWidth(120);
            final x = radius * cos(angle);
            final y = radius * sin(angle);
            
            final isSelected = controller.selectedTimerIndex.value == index;
            String label;
            if (index == 6) {
              label = Lang.manualOff;
            } else {
              final minutes = controller.timerOptions[index];
              label = minutes == 1 ? '1 ${Lang.minute}' : '$minutes ${Lang.minute}';
            }
            
            final buttonWidth = ScreenUtil().setWidth(85);
            final buttonHeight = ScreenUtil().setHeight(38);
            
            return Positioned(
              left: ScreenUtil().setWidth(170) + x - buttonWidth / 2,
              top: ScreenUtil().setWidth(170) + y - buttonHeight / 2,
              child: GestureDetector(
                onTap: () => controller.selectTimer(index),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: buttonWidth,
                    maxWidth: buttonWidth,
                    minHeight: buttonHeight,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(8),
                    vertical: ScreenUtil().setHeight(6),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Colors.white.withValues(alpha: 0.35)
                        : Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(16)),
                    border: Border.all(
                      color: isSelected 
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.4),
                      width: ScreenUtil().setWidth(isSelected ? 2 : 1),
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        blurRadius: ScreenUtil().setWidth(12),
                        spreadRadius: ScreenUtil().setWidth(2),
                      ),
                    ] : null,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(5),
                        height: ScreenUtil().setHeight(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected 
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(5)),
                      Flexible(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            color: Colors.white,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            letterSpacing: ScreenUtil().setSp(0.3),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    ));
  }

  Widget _buildPowerButton() {
    return Obx(() {
      final isOn = controller.isFlashlightOn.value;
      return GestureDetector(
        onTap: controller.toggleFlashlight,
        child: AnimatedBuilder(
          animation: controller.breathingAnimation,
          builder: (context, child) {
            final scale = isOn ? controller.breathingAnimation.value : 1.0;
            final opacity = isOn 
                ? (0.4 + (controller.breathingAnimation.value - 0.95) * 2.0)
                : 0.5;
            
            return Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: ScreenUtil().setWidth(140),
                height: ScreenUtil().setWidth(140),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isOn
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Colors.white.withValues(alpha: 0.9),
                          ],
                        )
                      : LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.1),
                          ],
                        ),
                  border: Border.all(
                    color: isOn
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.4),
                    width: ScreenUtil().setWidth(3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isOn
                          ? Colors.white.withValues(alpha: opacity.clamp(0.4, 0.5))
                          : Colors.black.withValues(alpha: 0.2),
                      blurRadius: isOn
                          ? ScreenUtil().setWidth(28 + (scale - 0.95) * 40)
                          : ScreenUtil().setWidth(15),
                      spreadRadius: isOn
                          ? ScreenUtil().setWidth(4 + (scale - 0.95) * 20)
                          : 0,
                      offset: Offset(0, ScreenUtil().setHeight(8)),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.flash_on,
                  size: ScreenUtil().setSp(60),
                  color: isOn
                      ? const Color(0xFF667EEA)
                      : Colors.white.withValues(alpha: 0.7),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildToolboxButton() {
    return GestureDetector(
      onTap: controller.navigateToToolbox,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(24),
          vertical: ScreenUtil().setHeight(18),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.25),
              Colors.white.withValues(alpha: 0.15),
            ],
          ),
          borderRadius: BorderRadius.circular(ScreenUtil().radius(20)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: ScreenUtil().setWidth(1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: ScreenUtil().setWidth(20),
              offset: Offset(0, ScreenUtil().setHeight(8)),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.apps,
              color: Colors.white,
              size: ScreenUtil().setSp(24),
            ),
            SizedBox(width: ScreenUtil().setWidth(12)),
            Text(
              Lang.toolboxButton,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: ScreenUtil().setSp(1),
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(8)),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withValues(alpha: 0.8),
              size: ScreenUtil().setSp(16),
            ),
          ],
        ),
      ),
    );
  }
}
