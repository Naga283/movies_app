import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/src/response/response.dart';
import 'package:http/http.dart' as http;

final getMovieResFutureProvider =
    FutureProvider.autoDispose<List<MoviesList>>((ref) async {
  try {
    final url = "https://api.sampleapis.com/movies/animation";
    final res = await http.get(Uri.parse(url));
    List<dynamic> listT = jsonDecode(res.body);
    return listT.map((e) => MoviesList.fromJson(e)).cast<MoviesList>().toList();
  } catch (e, sT) {
    throw Exception();
  }
});
