import 'package:flutter/material.dart';
import 'package:my_select/my_select_controller.dart';
import 'package:my_select/my_select_value.dart';

class MySelect<T> extends StatelessWidget {
  final MySelectController<T> controller;
  final List<T> items;
  final List<T> selectedItems;
  final String? Function(List<T>)? validator;
  final InputDecoration? inputDecoration;
  final InputDecoration? errorDecoration;
  final TextStyle? errorTextStyle;
  final Widget Function(T item, bool isSelected) itemBuilder;
  final Widget Function(T item) selectedBuilder;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final dynamic positionLabel;
  final InputDecoration? nputDecoration;
  final String? label;
  final List<String> Function(List<T> items) toStringBuilder;
  final String separator;
  final String? hintText;
  final String? btnConfirmLabel;
  final TextStyle? textStyleBtnConfirm;
  final ButtonStyle? btnConfirmStyle;
  final ValueChanged<List<T>>? onConfirmed;
  final bool autoConfirm = false;

  MySelect({
    required this.items,
    this.selectedItems = const [],
    this.validator,
    super.key,
    this.inputDecoration,
    this.errorDecoration,
    this.errorTextStyle,
    required this.itemBuilder,
    required this.controller,
    required this.selectedBuilder,
    this.borderRadius = 5,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.contentPadding,
    this.positionLabel,
    this.label,
    this.nputDecoration,
    required this.toStringBuilder,
    this.separator = ",",
    this.hintText,
    this.btnConfirmLabel,
    this.textStyleBtnConfirm,
    this.btnConfirmStyle,
    this.onConfirmed,
  }) {
    controller.value.items = items.isNotEmpty ? items : controller.value.items;
    controller.value.selectedItems = selectedItems.isNotEmpty
        ? selectedItems
        : controller.value.selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IntrinsicHeight(
        child: Stack(
          children: [
            TextFormField(
              controller: controller.value.textEditingController,
              validator: (value) {
                return validator?.call(controller.value.selectedItems);
              },
              decoration: inputDecoration ??
                  (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                        contentPadding: contentPadding,
                        filled: backgroundColor != null ? true : false,
                        fillColor: backgroundColor,
                        label: positionLabel.toString() == "input"
                            ? Text(label ?? "")
                            : null,
                        hintText: hintText,
                        prefixIcon: prefixIcon,
                        suffixIcon: suffixIcon ??
                            const Icon(
                              Icons.arrow_drop_down,
                            ),
                        focusedErrorBorder: borderRadius == null
                            ? null
                            : OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadius ?? 5),
                                ),
                                borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                        errorBorder: borderRadius == null
                            ? null
                            : OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadius ?? 5),
                                ),
                                borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.error),
                              ),
                        focusedBorder: borderRadius == null
                            ? null
                            : OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadius ?? 5),
                                ),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                        enabledBorder: borderRadius == null
                            ? null
                            : OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadius ?? 5),
                                ),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                        border: borderRadius == null
                            ? null
                            : OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadius ?? 5),
                                ),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                        disabledBorder: borderRadius == null
                            ? null
                            : OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadius ?? 5),
                                ),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                      ),
            ),
            GestureDetector(
              onTap: () {
                showMenuSelect(context);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<T?>> showMenuSelect(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: ValueListenableBuilder<MySelectValue<T>>(
              valueListenable: controller,
              builder: (b, d, w) {
                return Container(
                  width: 300,
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                List.generate(d.selectedItems.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  controller
                                      .onRemoveItem(d.selectedItems[index]);
                                  if (autoConfirm == true) {
                                    controller.confirm();
                                    controller.updateTextController(
                                        toStringBuilder, separator);
                                    onConfirmed
                                        ?.call(controller.value.confirmedItems);
                                  }
                                },
                                child: selectedBuilder(
                                  d.selectedItems[index],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView(
                          children: List.generate(d.items.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.toogleItem(d.items[index]);
                                controller.updateTextController(
                                    toStringBuilder, separator);
                                if (autoConfirm == true) {
                                  controller.confirm();
                                  controller.updateTextController(
                                      toStringBuilder, separator);
                                  onConfirmed
                                      ?.call(controller.value.confirmedItems);
                                }
                              },
                              child: itemBuilder(items[index],
                                  controller.isSelected(items[index])),
                            );
                          }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          autoConfirm == false
                              ? ElevatedButton(
                                  onPressed: () {
                                    controller.confirm();
                                    controller.updateTextController(
                                        toStringBuilder, separator);
                                    if (onConfirmed != null) {
                                      onConfirmed?.call(
                                          controller.value.confirmedItems);
                                    } else {
                                      Navigator.pop(context,
                                          controller.value.confirmedItems);
                                    }
                                  },
                                  style: btnConfirmStyle,
                                  child: Text(
                                    btnConfirmLabel ?? "Confirm",
                                    style: textStyleBtnConfirm ??
                                        Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    ).then((value) {
      return value;
    });
  }

  static Widget defauldItemBuilder(
      {required String label,
      required BuildContext context,
      required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      decoration: BoxDecoration(
        border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSecondaryContainer,
            width: isSelected ? 1 : 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          ),
        ],
      ),
    );
  }

  static Widget defaultSelectedBuilder(
      {required String label, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
