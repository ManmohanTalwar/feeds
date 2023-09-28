import 'package:feeds/helper/extension.dart';
import 'package:feeds/models/feeds.dart';
import 'package:feeds/presentation/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FeedCard extends StatelessWidget {
  final FeedData data;
  const FeedCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(
              data.imageHref,
            ).animate().fadeIn(
                  duration: 350.ms,
                ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.title ?? '',
                    style: context.customStyle(
                      size: 16.0,
                      color: context.black(),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    data.description ?? '',
                    style: context.customStyle(
                      size: 14.0,
                      color: context.black(),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
