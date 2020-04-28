# Gentoo GNU/Linux image with AMD ROCm packages

Built on top of vanilla `gentoo/stage3-amd64-nomultilib` image and contains ROCm packages taken at https://github.com/justxi/rocm/. It includes core packages pulled by installing `dev-util/amd-rocm-meta`. However, that contains the packages consuming most of time, CPU and RAM (`sci-libs/rocBLAS` and `sci-libs/rocFFT`), so it can be a good base for experiments with something else (e.g. machine learning frameworks).
