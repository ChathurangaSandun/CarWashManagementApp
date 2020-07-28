import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';

class AppSort {
  ///Default Sort
  static SortModel defaultSort = SortModel.fromJson(
    {
      "code": "nearest",
      "name": "nearest_post",
      "icon": Icons.swap_vert,
    },
  );

  ///List Sort support in Application
  static List<SortModel> listSortDefault = [
    {
      "code": "nearest",
      "name": "nearest_post",
      "icon": Icons.swap_vert,
    },
    {
      "code": "most_view",
      "name": "most_view",
      "icon": Icons.swap_vert,
    },
    {
      "code": "rating",
      "name": "review_rating",
      "icon": Icons.swap_vert,
    },
    {
      "code": "favorite",
      "name": "favorite_post",
      "icon": Icons.swap_vert,
    },
  ].map((item) => SortModel.fromJson(item)).toList();

  ///Singleton factory
  static final AppSort _instance = AppSort._internal();

  factory AppSort() {
    return _instance;
  }

  AppSort._internal();
}
