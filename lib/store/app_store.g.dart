// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  Computed<List<FeedData>?>? _$feedListComputed;

  @override
  List<FeedData>? get feedList =>
      (_$feedListComputed ??= Computed<List<FeedData>?>(() => super.feedList,
              name: '_AppStore.feedList'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$feedsAtom = Atom(name: '_AppStore.feeds', context: context);

  @override
  FeedEntity? get feeds {
    _$feedsAtom.reportRead();
    return super.feeds;
  }

  @override
  set feeds(FeedEntity? value) {
    _$feedsAtom.reportWrite(value, super.feeds, () {
      super.feeds = value;
    });
  }

  late final _$searchedFeedsAtom =
      Atom(name: '_AppStore.searchedFeeds', context: context);

  @override
  ObservableList<FeedData>? get searchedFeeds {
    _$searchedFeedsAtom.reportRead();
    return super.searchedFeeds;
  }

  @override
  set searchedFeeds(ObservableList<FeedData>? value) {
    _$searchedFeedsAtom.reportWrite(value, super.searchedFeeds, () {
      super.searchedFeeds = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_AppStore.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$searchFeedAsyncAction =
      AsyncAction('_AppStore.searchFeed', context: context);

  @override
  Future<void> searchFeed({required String query}) {
    return _$searchFeedAsyncAction.run(() => super.searchFeed(query: query));
  }

  late final _$getFeedsAsyncAction =
      AsyncAction('_AppStore.getFeeds', context: context);

  @override
  Future<void> getFeeds() {
    return _$getFeedsAsyncAction.run(() => super.getFeeds());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
feeds: ${feeds},
searchedFeeds: ${searchedFeeds},
feedList: ${feedList}
    ''';
  }
}
