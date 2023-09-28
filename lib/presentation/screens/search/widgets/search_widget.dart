import 'package:feeds/helper/Helper.dart';
import 'package:feeds/helper/extension.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Map data;
  const SearchWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 10.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: context.primaryColor(),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.card_giftcard_outlined,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['shipment_name'],
                    style: context.customStyle(
                      color: Colors.black,
                      size: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    '${data['shipment_id']} · ${data['from']} -> ${data['to']}',
                    style: context.customStyle(
                      color: Colors.grey,
                      size: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Helper.divider(
            right: 0.0,
            left: 0.0,
            color: context.dividerColor(),
          ),
        ],
      ),
    );
  }
}
