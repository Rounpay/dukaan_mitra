import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:flutter_demo/core/widgets/search_text_field.dart';

import '../utils/spacing.dart';

/// @Created by akash on 22-01-2026.
/// Know more about author at https://akash.cloudemy.in

class SearchItemWidget<T> extends StatelessWidget {
  SearchItemWidget({
    super.key,
    this.filterOn,
    required this.data,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
  });

  final Widget Function(List<T> list) child;
  final String Function(T item)? filterOn;
  final EdgeInsetsGeometry? padding;
  final List<T> data;
  final RxList<T> list = <T>[].obs;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    list.value = List.from(data);
    return Column(
      children: [
        if (filterOn != null && data.length > 1)
          SearchTextField(
            controller: searchController,
            onChanged: (value) {
              if (value == null) {
                list.value = data;
              } else {
                list.value = data
                    .where(
                      (element) => filterOn!
                          .call(element)
                          .toLowerCase()
                          .contains(value.toLowerCase()),
                    )
                    .toList();
              }
            },
            padding: padding,
          ),
        Spacing.h4,
        Expanded(child: Obx(() => child(list.value))),
      ],
    );
  }
}
