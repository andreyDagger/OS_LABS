#include <iostream>

int main(int argc, char** argv) {
    long double x = std::stold(argv[1]);
    const int N = 3e8;
    long double add = 1;
    long double res = 0;
    for (int i = 0; i < N; ++i) {
        res += add;
        add /= i + 1;
        add *= x;
    }
    std::cout.precision(20);
    std::cout << std::fixed << res << std::endl;
}
