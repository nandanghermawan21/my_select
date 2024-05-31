import 'package:flutter/material.dart';
import 'package:my_select/my_select_value.dart';

class MySelectController<T> extends ValueNotifier<MySelectValue<T>> {
  MySelectController({MySelectValue<T>? value})
      : super(value ?? MySelectValue<T>());

  //add selected item
  void addSelectedItem(T item) {
    value.selectedItems.add(item);
    commit();
  }

  //remove from list
  void onRemoveItem(T item) {
    value.selectedItems.remove(item);
    commit();
  }

  // check item is selected
  bool isSelected(T item) {
    return value.selectedItems.contains(item);
  }

  //toogle selection
  void toogleItem(T item) {
    if (isSelected(item)) {
      this.onRemoveItem(item);
    } else {
      this.addSelectedItem(item);
    }
  }

  //generateToString
  void updateTextController(
      List<String> Function(List<T>) generator, String separator) {
    var textNew = generator(value.selectedItems).join(separator);
    value.textEditingController.text = textNew;
  }

  void commit() {
    notifyListeners();
  }
}
