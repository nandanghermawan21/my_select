import 'package:flutter/material.dart';

class MySelectValue<T> {
  List<T> items = <T>[];
  List<T> selectedItems = <T>[];
  TextEditingController textEditingController = TextEditingController();

  bool isValid = true;
  String? errorMessage;

  MySelectValue({
    this.isValid = true,
    this.errorMessage,
  }) {
    items = <T>[];
    selectedItems = <T>[];
  }
}
