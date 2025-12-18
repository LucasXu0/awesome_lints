// ignore_for_file: avoid_unnecessary_stateful_widgets

import 'package:flutter/material.dart';

// expect_lint: prefer_sliver_prefix
class CustomList extends StatelessWidget {
  const CustomList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Text('Item $index'),
        childCount: 10,
      ),
    );
  }
}

// expect_lint: prefer_sliver_prefix
class GridWidget extends StatelessWidget {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(),
        childCount: 10,
      ),
    );
  }
}

// expect_lint: prefer_sliver_prefix
class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Title'),
    );
  }
}

// expect_lint: prefer_sliver_prefix
class PaddedContent extends StatelessWidget {
  const PaddedContent({super.key});

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverList(
          delegate: SliverChildListDelegate([]),
        ),
      );
}

// expect_lint: prefer_sliver_prefix
class ConditionalSliver extends StatelessWidget {
  const ConditionalSliver({super.key, required this.useGrid});

  final bool useGrid;

  @override
  Widget build(BuildContext context) {
    if (useGrid) {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        delegate: SliverChildListDelegate([]),
      );
    }
    return SliverList(
      delegate: SliverChildListDelegate([]),
    );
  }
}

// expect_lint: prefer_sliver_prefix
class FillRemainingWidget extends StatelessWidget {
  const FillRemainingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Container(),
    );
  }
}

// expect_lint: prefer_sliver_prefix
class ToBoxAdapterWidget extends StatelessWidget {
  const ToBoxAdapterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(),
    );
  }
}
