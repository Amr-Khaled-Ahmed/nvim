#include <iostream>

int add(int a, int b) { return a + b; }

int main() {
  int x = 5, y = 10;
  int result = add(x, y);
  std::cout << "Result: " << result << std::endl;
  return 0;
}
