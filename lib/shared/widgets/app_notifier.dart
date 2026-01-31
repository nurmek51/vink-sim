import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppNotifier {
  static bool _isToastShowing = false;

  final FToast _fToast = FToast();  
  final IconData toastIcon;
  final String toastText;
  final Color toastTextColor;
  final Color toastColor;
  final Color toastIconColor;

  AppNotifier({
    required this.toastIcon,
    required this.toastText,
    required this.toastColor,
    this.toastTextColor = Colors.white,
    this.toastIconColor = Colors.white,
  });

  static AppNotifier success(String message) {
    return AppNotifier(
      toastText: message,
      toastIcon: Icons.check,
      toastColor: Colors.greenAccent,
    );
  } 

  static AppNotifier error(String message) {
    return AppNotifier(
      toastText: message,
      toastIcon: Icons.close_rounded,
      toastColor: Colors.red,
    );
  }  

  static AppNotifier info(String message) {
    return AppNotifier(
      toastText: message,
      toastIcon: Icons.info_outline_rounded,
      toastColor: Colors.blueAccent,
    );
  }    

   void showAppToast(BuildContext context) {
    if (_isToastShowing) return;
    _isToastShowing = true;
    _fToast.init(context);

    _fToast.showToast(
      child: SafeArea(child: buildCustomToast(context)),
      positionedToastBuilder:(context, child, gravity) => Positioned(
        top: 12,
        left: 0,
        right: 0,
        child: child,
      ),
      toastDuration: const Duration(seconds: 2),
    );

   Future.delayed(const Duration(seconds: 2), () {
    _isToastShowing = false;
  });

  }

  void removeTestToast() {
    _fToast.removeCustomToast();
  }

  Widget buildCustomToast(BuildContext context) {
    return Opacity(
      opacity: 0.75,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: toastColor,
          borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8, 
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],          
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: LocalizedText(
                toastText,
                maxLines: 3,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: toastTextColor,
                ),
              ),
            ),
            SizedBox(width:5),
            Icon(
              toastIcon,
              color: toastIconColor, 
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

}
