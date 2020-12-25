#include <iostream>
#include <ctime>

using namespace std;

int main()
{
    int i = 0;
    clock_t t1 = clock();
    while (true)
    {
        i++;
        clock_t t2 = clock();
        if ((t2 - t1) % (CLOCKS_PER_SEC * 5) == 0 || (t2 - t1) % (CLOCKS_PER_SEC * 10) == 0) { cout << i << endl; t1 -= 1; }
        if ((t2 - t1) / CLOCKS_PER_SEC > 15) break;
    }
    cout << "end: " << i << endl;
}