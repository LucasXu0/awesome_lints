import 'package:flutter/material.dart';

// Correctly named with Sliver prefix
class SliverCustomList extends StatelessWidget {
  const SliverCustomList({super.key});

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

// Correctly named with Sliver prefix (StatefulWidget)
class SliverCustomGrid extends StatefulWidget {
  const SliverCustomGrid({super.key});

  @override
  State<SliverCustomGrid> createState() => _SliverCustomGridState();
}

class _SliverCustomGridState extends State<SliverCustomGrid> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildListDelegate([]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}

// Regular widget returning non-sliver widget
class RegularWidget extends StatelessWidget {
  const RegularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const Text('Not a sliver'));
  }
}

// Regular widget returning Column
class ColumnWidget extends StatelessWidget {
  const ColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: const [Text('Item 1'), Text('Item 2')]);
  }
}

// Widget returning CustomScrollView (not a sliver itself)
class ScrollableWidget extends StatelessWidget {
  const ScrollableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [SliverList(delegate: SliverChildListDelegate([]))],
    );
  }
}

// Widget returning ListView (not a sliver)
class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [Text('Item 1'), Text('Item 2')]);
  }
}

// Widget with arrow function syntax returning non-sliver
class ArrowWidget extends StatelessWidget {
  const ArrowWidget({super.key});

  @override
  Widget build(BuildContext context) => const Text('Hello');
}

// Widget with arrow function syntax returning sliver (correctly named)
class SliverArrowWidget extends StatelessWidget {
  const SliverArrowWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      SliverToBoxAdapter(child: const Text('Hello'));
}

// Class that doesn't extend StatelessWidget or StatefulWidget
class NotAWidget {
  Widget build(BuildContext context) {
    return SliverList(delegate: SliverChildListDelegate([]));
  }
}

// Widget returning a Scaffold
class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: Container(),
    );
  }
}
