import 'package:feeds/helper/extension.dart';
import 'package:feeds/presentation/widgets/messgae_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/error.svg',
            height: 150.0,
          ),
          Text(
            'Loading Failed',
            style: context.customStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 10.0,
            ),
            child: MessageText(
              message:
                  "It\'s just that you lost your Internet Connection.\n Please check your internet connection and try again.",
              action: 'Try Again',
              onAction: () {},
            ),
          ),
        ],
      ),
    );
  }
}
