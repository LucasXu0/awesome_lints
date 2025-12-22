import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ServiceA {}

class ServiceB {}

class ServiceC {}

class ShouldNotTriggerLint extends StatelessWidget {
  const ShouldNotTriggerLint({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is good
    return MultiProvider(
      providers: [
        Provider<ServiceA>(create: (_) => ServiceA()),
        Provider<ServiceB>(create: (_) => ServiceB()),
        Provider<ServiceC>(create: (_) => ServiceC()),
      ],
      child: Container(),
    );
  }
}

class SingleProvider extends StatelessWidget {
  const SingleProvider({super.key});

  @override
  Widget build(BuildContext context) {
    // Single provider is fine
    return Provider<ServiceA>(create: (_) => ServiceA(), child: Container());
  }
}
