import 'package:flutter/material.dart';

class GridViewPagination extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function() addEvent;
  final bool shrinkWrap;
  final SliverGridDelegate gridDelegate;

  const GridViewPagination({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.addEvent,
    required this.gridDelegate,
    this.shrinkWrap = false,
  });

  @override
  State<GridViewPagination> createState() => _GridViewPaginationState();
}

class _GridViewPaginationState extends State<GridViewPagination> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: widget.gridDelegate,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      controller: _scrollController,
      shrinkWrap: widget.shrinkWrap,
      physics: const AlwaysScrollableScrollPhysics(),
      primary: false,
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      widget.addEvent();
    }
  }
}
