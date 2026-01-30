import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'toolbox_logic.dart';
import '../../lang/lang.dart';

class ToolboxView extends GetView<ToolboxLogic> {
  const ToolboxView({super.key});

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
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(80),
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                    bottom: ScreenUtil().setHeight(20),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: ScreenUtil().setWidth(16),
                      mainAxisSpacing: ScreenUtil().setHeight(16),
                      childAspectRatio: 0.85,
                    ),
                    itemCount: controller.tools.length,
                    itemBuilder: (context, index) {
                      final tool = controller.tools[index];
                      return _buildToolCard(tool, index);
                    },
                  ),
                ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(24),
                left: ScreenUtil().setWidth(20),
                child: _buildBackButton(),
              ),
              Positioned(
                top: ScreenUtil().setHeight(20),
                left: 0,
                right: 0,
                child: Center(
                  child: _buildTitle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: controller.goBack,
      child: Container(
        width: ScreenUtil().setWidth(44),
        height: ScreenUtil().setWidth(44),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.2),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: ScreenUtil().setWidth(1),
          ),
        ),
        child: Icon(
          Icons.arrow_back_ios,
          size: ScreenUtil().setSp(18),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(24),
        vertical: ScreenUtil().setHeight(12),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(ScreenUtil().radius(20)),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: ScreenUtil().setWidth(1),
        ),
      ),
      child: Text(
        Lang.toolboxTitle,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(18),
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: ScreenUtil().setSp(1),
        ),
      ),
    );
  }

  Widget _buildToolCard(Map<String, dynamic> tool, int index) {
    final colors = [
      [const Color(0xFFFF6B6B), const Color(0xFFFF8E8E)],
      [const Color(0xFF4ECDC4), const Color(0xFF6EDDD6)],
      [const Color(0xFF45B7D1), const Color(0xFF6BC5D8)],
      [const Color(0xFF96CEB4), const Color(0xFFB4E0C8)],
      [const Color(0xFFFFEAA7), const Color(0xFFFFF0C0)],
      [const Color(0xFFDDA0DD), const Color(0xFFE8B8E8)],
      [const Color(0xFFFFB347), const Color(0xFFFFC470)],
      [const Color(0xFF87CEEB), const Color(0xFFA8D8EA)],
      [const Color(0xFFFF69B4), const Color(0xFFFF8CC8)],
      [const Color(0xFF98D8C8), const Color(0xFFB5E8D8)],
      [const Color(0xFFF7DC6F), const Color(0xFFFAE8A8)],
      [const Color(0xFFBB8FCE), const Color(0xFFD4B5E8)],
      [const Color(0xFF85C1E2), const Color(0xFFA5D4F0)],
      [const Color(0xFFFFA07A), const Color(0xFFFFB89A)],
      [const Color(0xFF90EE90), const Color(0xFFB0F0B0)],
    ];
    
    final cardColors = colors[index % colors.length];
    
    return GestureDetector(
      onTap: () => controller.navigateToTool(tool['route']),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cardColors[0].withValues(alpha: 0.9),
              cardColors[1].withValues(alpha: 0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(ScreenUtil().radius(20)),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: ScreenUtil().setWidth(1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: cardColors[0].withValues(alpha: 0.3),
              blurRadius: ScreenUtil().setWidth(20),
              offset: Offset(0, ScreenUtil().setHeight(8)),
            ),
          ],
        ),
        padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil().setWidth(50),
              height: ScreenUtil().setWidth(50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.25),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: ScreenUtil().setWidth(2),
                ),
              ),
              child: Icon(
                tool['icon'],
                size: ScreenUtil().setSp(28),
                color: Colors.white,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(8)),
            Flexible(
              child: Text(
                tool['name'],
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: ScreenUtil().setSp(0.5),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
