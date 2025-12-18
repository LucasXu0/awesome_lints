// Note: These will show as unresolved imports, which is expected for this test
// The lint should flag the double slashes regardless of whether the import resolves

// expect_lint: avoid_double_slash_imports
import 'package:test//material.dart';

// expect_lint: avoid_double_slash_imports
import '../../..//avoid_continue/should_trigger_lint.dart';

// expect_lint: avoid_double_slash_imports
export 'package:mocktail//good_file.dart';

void main() {
  print('Testing double slash imports');
}
