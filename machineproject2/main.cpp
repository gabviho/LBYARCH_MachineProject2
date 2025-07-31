#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>

extern void machineproject2(double* matrix, int* output, int y);

int main() {
    int y;
    scanf("%d", &y);

    double* matrix = (double*)malloc(sizeof(double) * y * 3);
    int* output = (int*)malloc(sizeof(int) * y);

    if (!matrix || !output) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    for (int i = 0; i < y * 3; i++) {
        scanf("%lf", &matrix[i]);
    }

    machineproject2(matrix, output, y);

    for (int i = 0; i < y; i++) {
        printf("%d\n", output[i]);
    }

    free(matrix);
    free(output);
    return 0;
}
