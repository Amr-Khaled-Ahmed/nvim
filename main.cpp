#include <iostream>

int add(int a, int b) { return a + b; }
int main() {
  int xx = 5, y = 10;
  int result = add(xx, y);
  std::cout << "Result: " << result << std::endl;
  return 0;
}
