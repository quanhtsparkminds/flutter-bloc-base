import 'package:flutter/material.dart';

class DropDownModel {
  int? id;
  String? name;
  String? flag;
  int? index;

  DropDownModel({this.id, this.index, required this.name, this.flag});

  DropDownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    flag = json['flag'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['index'] = index;
    return data;
  }

  void copyWith({
    String? name,
    int? id,
    int? index,
  }) {
    this.name = name ?? this.name;
    this.id = id ?? this.id;
    this.index = index ?? this.index;
  }

  String get nameSelected => name ?? '';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropDownModel && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

bool areListsEqualByName(List<DropDownModel> list1, List<DropDownModel> list2) {
  if (list1.isEmpty && list2.isEmpty) {
    return true;
  }
  if (list1.length != list2.length) {
    return false;
  }

  for (int i = 0; i < list1.length; i++) {
    if (list1[i].name != list2[i].name) {
      return false;
    }
  }

  return true;
}

bool areListsEqualById(List<DropDownModel> list1, List<DropDownModel> list2) {
  if (list1.isEmpty && list2.isEmpty) {
    return true;
  }
  if (list1.length != list2.length) {
    return false;
  }

  for (int i = 0; i < list1.length; i++) {
    if (list1[i].id != list2[i].id) {
      return false;
    }
  }

  return true;
}

void sortByNames(List<DropDownModel> list) {
  list.sort((a, b) {
    if (a.name == null && b.name == null) return 0;
    if (a.name == null) return 1;
    if (b.name == null) return -1;
    return a.name!.compareTo(b.name!);
  });
}

bool containsItemByName(List<DropDownModel> list, DropDownModel item) {
  return list
      .any((element) => element.name == item.name && element.id == item.id);
}

List<DropDownModel> manualSortByName(List<DropDownModel> list) {
  for (int i = 0; i < list.length - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < list.length; j++) {
      String nameJ = list[j].name ?? '';
      String nameMin = list[minIndex].name ?? '';
      if (nameJ.compareTo(nameMin) < 0) {
        minIndex = j;
      }
    }
    if (minIndex != i) {
      DropDownModel temp = list[i];
      list[i] = list[minIndex];
      list[minIndex] = temp;
    }
  }
  return list;
}

class DropdownButtonStyle2 {
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;
  final double elevation;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;
  final BorderRadius? borderRadius;

  const DropdownButtonStyle2({
    this.borderRadius,
    this.boxShadow,
    this.border,
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation = 0,
    this.padding,
    this.shape,
  });
}

class DropdownStyle2 {
  final double? elevation;
  final double? height;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Color? scrollbarColor;

  /// Add shape and border radius of the dropdown from here
  final ShapeBorder? shape;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  ///button width must be set for this to take effect
  final double? width;

  const DropdownStyle2({
    this.height,
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.shape,
    this.color,
    this.padding,
    this.scrollbarColor,
  });
}
