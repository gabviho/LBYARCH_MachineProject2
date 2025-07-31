<h1 align = "center"> <b> LBYARCH Machine Project 2 </b> </h1>
<p align = "center"> <i> by Gabriel Vince Ocampo and Jonah Pajarillo </i> </p>

## 1. Comparative Execution Time & Performance Analysis

This project computes car acceleration using an x86-64 assembly function that communicates with a C program.

## Formula

```
Acceleration = ((Vf - Vi) * 1000 / 3600) / T
```

All values are in double precision floats. Output acceleration values are converted to integers (m/s).

## Features

- Functional scalar SIMD floating-point instructions (`movsd`, `subsd`, `mulsd`, `divsd`, `cvtsd2si`)
- Correct usage of Windows x64 calling convention (rcx, rdx, r8)
- Benchmarks for sizes: 10, 100, 1000, 10000 (30 runs each)

## Benchmark Sample Output

```
Benchmarking for 10 rows
Average time over 30 trials: 0.000012 seconds

Benchmarking for 100 rows
Average time over 30 trials: 0.000090 seconds

Benchmarking for 1000 rows
Average time over 30 trials: 0.000740 seconds

Benchmarking for 10000 rows
Average time over 30 trials: 0.007123 seconds
```

## Files

- `main.c` - handles input, output, timing, and memory
- `accel.asm` - SIMD-based acceleration function
