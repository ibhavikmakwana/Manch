import 'package:flutter/material.dart';

enum BaseWidgetState { success, error, loading, empty }

class BaseWidgetSwitcher extends StatelessWidget {
  final BaseWidgetState state;
  final Widget successWidget;
  final Widget errorWidget;
  final Widget loadingWidget;
  final Widget emptyWidget;

  const BaseWidgetSwitcher({
    Key? key,
    this.state = BaseWidgetState.loading,
    this.successWidget = const SizedBox.shrink(),
    this.errorWidget = const SizedBox.shrink(),
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.emptyWidget = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case BaseWidgetState.success:
        return successWidget;
      case BaseWidgetState.error:
        return errorWidget;
      case BaseWidgetState.loading:
        return loadingWidget;
      case BaseWidgetState.empty:
        return emptyWidget;
      default:
        return const SizedBox.shrink();
    }
  }
}
