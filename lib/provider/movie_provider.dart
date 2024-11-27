import 'package:flutter/material.dart';
import 'package:training_project/modal/movie_modal.dart';

import '../api_helper/api_helper.dart';

class MovieProvider extends ChangeNotifier {
  String search = "Rampag";
  MoviesModal? moviesModal;


  Future<MoviesModal?> apiCalling() async {
    final data = await Apihelper.apihelper.fetchData(search);
    moviesModal = MoviesModal.fromJson(data);
    return moviesModal;
  }

  void getSearch(String value)
  {
    search = value;
    notifyListeners();
  }
}
