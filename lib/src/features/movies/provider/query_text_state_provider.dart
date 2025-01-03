import 'package:flutter_riverpod/flutter_riverpod.dart';

final queryTextSearchController = StateProvider.autoDispose<String>((ref) {
  return "";
});
