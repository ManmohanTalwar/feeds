import 'package:feeds/presentation/screens/search/widgets/search_widget.dart';
import 'package:feeds/presentation/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool showList = true;
  List<Map<String, dynamic>> searchData = [
    {
      'shipment_name': 'Macbook Pro M2',
      'shipment_id': '#NE43765875',
      'from': 'Paris',
      'to': 'Morocco'
    },
    {
      'shipment_name': 'Summer Jacket',
      'shipment_id': '#NE44965875',
      'from': 'Barcelona',
      'to': 'Paris'
    },
    {
      'shipment_name': 'Tapered Jeans',
      'shipment_id': '#NE86865875',
      'from': 'Colombia',
      'to': 'Paris'
    },
    {
      'shipment_name': 'Slim Fit Jeans AW',
      'shipment_id': '#NE98765875',
      'from': 'Bogota',
      'to': 'Dhaka'
    },
    {
      'shipment_name': 'Office Desk',
      'shipment_id': '#NE99786875',
      'from': 'France',
      'to': 'Germany'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'Search-Container',
              child: SearchContainer(
                isSearch: true,
                onSearched: (val) {
                  setState(
                    () {
                      showList = false;
                    },
                  );
                  Future.delayed(const Duration(milliseconds: 100), () {
                    setState(() {
                      showList = true;
                    });
                  });
                },
              ),
            ),
            if (showList)
              Flexible(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 20.0,
                        offset: const Offset(-4, 0),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...searchData
                            .map((e) => SearchWidget(
                                  data: e,
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 350.ms).then().slideY(
                    duration: 300.ms,
                    begin: 0.3,
                    end: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
