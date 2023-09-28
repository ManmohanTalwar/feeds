import 'package:feeds/helper/app_constants.dart';
import 'package:feeds/helper/extension.dart';
import 'package:flutter/material.dart';

class MessageText extends StatelessWidget {
  const MessageText({
    Key? key,
    this.message,
    this.action,
    this.onAction,
    this.color,
    this.textColor,
  }) : super(key: key);
  final String? message;
  final String? action;
  final VoidCallback? onAction;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message ?? 'Failed to load data, Please try again.',
            style: context.customStyle(
              color: textColor ?? inactiveGrey,
              fontWeight: FontWeight.w600,
              size: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          if (action != null) ...{
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              onPressed: onAction,
              child: Text(
                'Try again',
                style: context.customStyle(
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          }
        ],
      ),
    );
  }
}
