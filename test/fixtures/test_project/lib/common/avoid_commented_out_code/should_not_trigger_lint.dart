// Test cases that should NOT trigger the avoid_commented_out_code lint

/// This is a documentation comment
/// It can span multiple lines
/// And contain references to code like [MyClass]
void documentedFunction() {}

void test() {
  // Valid: Regular explanatory comment
  // This function processes the data

  // Valid: NOTE comment
  // NOTE: This approach was chosen because...

  // Valid: Comment explaining the next line
  // Calculate the total sum

  // Valid: Comment with code-like words but not actual code
  // The return value should be void

  // Valid: Comment mentioning code concepts
  // We use a for loop here for better performance

  // Valid: Comment with technical terms
  // This implements the Strategy pattern

  // Valid: Comment with example usage (descriptive, not code)
  // Example: calling this with true will enable debug mode

  // Valid: XXX comment
  // XXX: This needs refactoring

  // Valid: Comment describing what needs to be done
  // Need to add validation here

  // Valid: Comment about code behavior
  // This will throw an exception if null
}

// Valid: File-level comment
// This file contains test cases
