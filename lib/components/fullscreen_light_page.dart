import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FullscreenLightPage extends StatelessWidget {
  final Widget lightContent;
  final Widget controlPanel;
  final String title;
  final VoidCallback? onBack;
  
  const FullscreenLightPage({
    super.key,
    required this.lightContent,
    required this.controlPanel,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 16,
            ),
          ),
          onPressed: onBack ?? () => Get.back(),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(18),
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          lightContent,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                    Colors.black.withValues(alpha: 0.9),
                  ],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  child: controlPanel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
