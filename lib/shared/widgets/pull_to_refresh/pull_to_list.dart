import 'package:flutter/material.dart';
import 'package:myapp/shared/widgets/app_nodata/app_nodata.dart';
import 'package:myapp/shared/widgets/skeleton_loader/skeleton_loader.dart';

class PullToRefreshIndicator<T> extends StatelessWidget {
  final bool isLoading;
  final RefreshCallback onRefresh;
  final List<T> data;
  final NullableIndexedWidgetBuilder itemBuilder;
  final Widget? textNodata;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry paddingContent;
  final IndexedWidgetBuilder separatorBuilder;
  final Key? keyList;
  final Widget? emptyWidget;
  final ScrollPhysics? physics;

  const PullToRefreshIndicator(
      {super.key,
      required this.isLoading,
      required this.onRefresh,
      required this.data,
      this.textNodata,
      required this.itemBuilder,
      this.scrollController,
      required this.paddingContent,
      required this.separatorBuilder,
      this.keyList,
      this.physics,
      this.emptyWidget});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: SkeletonLoader())
        : Column(
            children: [
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: onRefresh,
                  key: keyList,
                  color: Theme.of(context).colorScheme.outline,
                  child: data.isEmpty
                      ? emptyWidget ?? AppNodata(title: textNodata)
                      : ListView.separated(
                          shrinkWrap: false,
                          physics:
                              physics ?? const AlwaysScrollableScrollPhysics(),
                          controller: scrollController,
                          itemCount: data.length,
                          padding: paddingContent,
                          itemBuilder: itemBuilder,
                          separatorBuilder: separatorBuilder,
                        ),
                ),
              ),
            ],
          );
  }
}
