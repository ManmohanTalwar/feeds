import 'dart:async';

import 'package:feeds/helper/Helper.dart';
import 'package:feeds/helper/app_prefs.dart';
import 'package:feeds/helper/extension.dart';
import 'package:feeds/injection.dart';
import 'package:feeds/presentation/widgets/animated_app_bar.dart';
import 'package:feeds/presentation/widgets/feed_card.dart';
import 'package:feeds/presentation/widgets/messgae_text.dart';
import 'package:feeds/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

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
          backgroundColor: context.primaryColorLight(),
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                store.isLoading = true;
              });
              await store.init();
              setState(() {
                store.isLoading = false;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedAppBar(
                  isNormal: false,
                  controller: appBarController,
                ),
                PreferenceBuilder(
                  preference: locator<AppPrefs>().isNetworkError,
                  builder: (context, isError) => isError
                      ? MessageText(
                          message:
                              "It's just that you lost your Internet Connection.\n Please check your internet connection and try again.",
                          action: 'Try Again',
                          onAction: () {},
                          color: Colors.red,
                          textColor: context.white(),
                        )
                      : const SizedBox.shrink(),
                ),
                Observer(
                  builder: (context) => store.isLoading
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 450),
                          color: context.accentColor(),
                          child: loadingIcon(
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Expanded(
                  child: Observer(
                    builder: (context) => store.feeds == null
                        ? loadingIcon(
                            isFull: true,
                          )
                        : store.feeds != null &&
                                store.feeds!.title.isNullOrEmpty()
                            ? const Text(
                                'No Feeds Found',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: 'Spartan',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : ListView.builder(
                                itemCount: store.feeds!.rows?.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    store.feeds!.rows![index].isEmpty()
                                        ? const SizedBox.shrink()
                                        : FeedCard(
                                            data: store.feeds!.rows![index],
                                          )
                                            .animate()
                                            .fadeIn(duration: 300.ms)
                                            .slideY(
                                              duration: 450.ms,
                                              end: 0,
                                              begin: 0.5,
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
