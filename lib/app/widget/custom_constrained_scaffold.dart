import 'package:flutter/material.dart';

/// A reusable Scaffold that wraps its body with a ConstrainedBox and centers it.
/// - `maxContentWidth` controls the maximum width of the inner content.
/// - You can provide an appBar, floatingActionButton, bottomNavigationBar, etc.
class CustomConstrainedScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final EdgeInsetsGeometry contentPadding;
  final double maxContentWidth;
  final Color? backgroundColor;
  final bool
      centerBody; // if true, will center the constrained child horizontally

  const CustomConstrainedScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.maxContentWidth = 900,
    this.backgroundColor,
    this.centerBody = true,
  });

  @override
  Widget build(BuildContext context) {
    // Scaffold preserves usual behavior (status bar, keyboard, etc.)
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // If the available width is larger than maxContentWidth, lock to maxContentWidth and center horizontally.
            Widget constrained = ConstrainedBox(
              constraints: BoxConstraints(
                // allow it to shrink on small screens, but cap the max width
                maxWidth: maxContentWidth,
                minWidth: 0,
              ),
              child: Padding(
                padding: contentPadding,
                child: body ?? const SizedBox.shrink(),
              ),
            );

            if (centerBody && constraints.maxWidth > maxContentWidth) {
              // center horizontally inside a Row
              return SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    constrained,
                  ],
                ),
              );
            } else {
              // on small screens, just use full width (with padding)
              return SingleChildScrollView(child: constrained);
            }
          },
        ),
      ),
    );
  }
}
