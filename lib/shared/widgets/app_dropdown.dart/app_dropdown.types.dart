class AppDropdownItem {
  final String key;
  final String label;
  final String flag;

  AppDropdownItem({required this.key, required this.label, this.flag = ''});
}

List<AppDropdownItem> sortAppDropdownItem(List<AppDropdownItem> list) {
  for (int i = 0; i < list.length - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < list.length; j++) {
      String nameJ = list[j].label;
      String nameMin = list[minIndex].label;
      if (nameJ.compareTo(nameMin) < 0) {
        minIndex = j;
      }
    }
    if (minIndex != i) {
      AppDropdownItem temp = list[i];
      list[i] = list[minIndex];
      list[minIndex] = temp;
    }
  }
  return list;
}
