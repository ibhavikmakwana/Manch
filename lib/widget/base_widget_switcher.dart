import 'package:flutter/material.dart';

enum BaseWidgetState { SUCCESS, ERROR, LOADING, EMPTY }

class BaseWidgetSwitcher extends StatelessWidget {
  final BaseWidgetState state;
  final Widget successWidget;
  final Widget errorWidget;
  final Widget loadingWidget;
  final Widget emptyWidget;

  const BaseWidgetSwitcher({
    Key? key,
    this.state = BaseWidgetState.LOADING,
    this.successWidget = const SizedBox.shrink(),
    this.errorWidget = const SizedBox.shrink(),
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.emptyWidget = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case BaseWidgetState.SUCCESS:
        return successWidget;
      case BaseWidgetState.ERROR:
        return errorWidget;
      case BaseWidgetState.LOADING:
        return loadingWidget;
      case BaseWidgetState.EMPTY:
        return emptyWidget;
      default:
        return SizedBox.shrink();
    }
  }
}
