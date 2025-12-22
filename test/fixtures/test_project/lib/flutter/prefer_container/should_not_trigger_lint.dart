import 'package:flutter/widgets.dart';

void notTrigger() {
  // Single widget - no nesting issue
  Padding(padding: EdgeInsets.all(8), child: Text('Hello'));

  // Only 2 widgets nested - below minimum sequence
  Align(
    alignment: Alignment.topLeft,
    child: Padding(padding: EdgeInsets.all(8), child: Text('World')),
  );

  // Container is already used
  Container(
    alignment: Alignment.topRight,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(color: Color(0xFF000000)),
    child: Text('Foo'),
  );

  // Custom widget in the chain
  Padding(
    padding: EdgeInsets.all(8),
    child: CustomWidget(
      child: Align(alignment: Alignment.bottomLeft, child: Text('Bar')),
    ),
  );
}

class CustomWidget extends StatelessWidget {
  final Widget child;

  const CustomWidget({required this.child});

  @override
  Widget build(BuildContext context) => child;
}
