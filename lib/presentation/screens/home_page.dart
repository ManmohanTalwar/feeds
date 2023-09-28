import 'dart:async';

import 'package:feeds/helper/app_constants.dart';
import 'package:feeds/main.dart';
import 'package:feeds/presentation/widgets/animated_app_bar.dart';
import 'package:feeds/presentation/widgets/feed_card.dart';
import 'package:feeds/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        AutomaticKeepAliveClientMixin<HomePage>,
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin {
  late AppStore store;
  late AnimationController appBarController;

  @override
  void initState() {
    super.initState();
    appBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    appBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    store = context.watch<AppStore>();
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppConstants.white,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedAppBar(
                  isNormal: false,
                  controller: appBarController,
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: Observer(
                    builder: (context) => store.feeds == null
                        ? Container()
                        : store.feeds != null &&
                                store.feeds!.title.isNullOrEmpty()
                            ? Container()
                            : ListView.builder(
                                itemCount: store.feeds!.rows?.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    store.feeds!.rows![index].isEmpty()
                                        ? const SizedBox.shrink()
                                        : FeedCard(
                                            data: store.feeds!.rows![index],
                                          ),
                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Future<bool> onWillPop(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text("EXIT APP"),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("NO"),
            ),
            OutlinedButton(
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: const Text("YES"),
            ),
          ],
        ),
      ) ??
      false;
}
