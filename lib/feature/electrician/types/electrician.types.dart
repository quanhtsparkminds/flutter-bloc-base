enum ListType { gird, listView }

extension ExListType on ListType {
  String get title {
    switch (this) {
      case ListType.listView:
        return 'List View';
      case ListType.gird:
      default:
        return 'Grid View';
    }
  }
}
