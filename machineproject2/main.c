#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

extern void compute_acceleration(double* input, int* output, int rows);

void fill_random_data(double* input, int rows) {
    for (int i = 0; i < rows; i++) {
        double vi = rand() % 100;
        double vf = vi + (rand() % 100);
        double t = 1.0 + (rand() % 100) / 10.0;
        input[i * 3 + 0] = vi;
        input[i * 3 + 1] = vf;
        input[i * 3 + 2] = t;
    }
}

int main() {
    // ✅ Manual test first
    int test_rows = 3;
    double test_input[] = {
        0.0, 62.5, 10.1,
        60.0, 122.3, 5.5,
        30.0, 160.7, 7.8
    };
    int* test_output = malloc(sizeof(int) * test_rows);
    compute_acceleration(test_input, test_output, test_rows);
    for (int i = 0; i < test_rows; i++) {
        printf("output[%d] = %d\n", i, test_output[i]);
    }
    free(test_output);

    printf("\n");

    // ✅ Performance benchmark
    int sizes[] = {10, 100, 1000, 10000};
    int trials = 30;

    LARGE_INTEGER freq;
    QueryPerformanceFrequency(&freq);

    for (int s = 0; s < 4; s++) {
        int rows = sizes[s];
        double* input = malloc(sizeof(double) * rows * 3);
        int* output = malloc(sizeof(int) * rows);

        printf("Benchmarking for %d rows\n", rows);
        double total_time = 0.0;

        for (int t = 0; t < trials; t++) {
            fill_random_data(input, rows);

            LARGE_INTEGER start, end;
            QueryPerformanceCounter(&start);
            compute_acceleration(input, output, rows);
            QueryPerformanceCounter(&end);

            double elapsed = (double)(end.QuadPart - start.QuadPart) / freq.QuadPart;
            total_time += elapsed;
        }

        printf("Average time over %d trials: %.8f seconds\n\n", trials, total_time / trials);

        free(input);
        free(output);
    }

    return 0;
}
