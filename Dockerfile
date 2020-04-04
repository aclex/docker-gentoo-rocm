FROM gentoo/stage3-amd64-nomultilib:latest

RUN emerge --sync && emerge dev-vcs/git

RUN ["mkdir", "/etc/portage/repos.conf", "/etc/portage/env", "/etc/portage/package.accept_keywords", "/etc/portage/package.env", "/etc/portage/package.mask"]

RUN echo -e "[DEFAULT]\n\
main-repo = gentoo\n\
\n\
[gentoo]\n\
location = /var/db/repos/gentoo\n\
sync-type = git\n\
sync-uri = https://github.com/gentoo-mirror/gentoo.git\n\
auto-sync = yes" > /etc/portage/repos.conf/gentoo.conf && \
\
echo -e "[rocm]\n\
location = /var/db/repos/rocm\n\
sync-type = git\n\
sync-uri = https://github.com/justxi/rocm.git\n\
auto-sync = yes" > /etc/portage/repos.conf/rocm.conf

RUN rm -rf /var/db/repos/gentoo && emerge --sync

RUN echo -e "dev-util/amd-rocm-meta ~amd64\n\
dev-libs/rocm-comgr ~amd64\n\
dev-libs/rocm-device-libs ~amd64\n\
dev-libs/rocm-opencl-driver ~amd64\n\
dev-libs/rocm-opencl-runtime ~amd64\n\
dev-util/rocm-cmake ~amd64\n\
dev-util/rocminfo ~amd64\n\
dev-libs/roct-thunk-interface ~amd64\n\
dev-libs/rocr-runtime ~amd64\n\
sys-devel/llvm-roc ~amd64\n\
dev-util/rocm-smi ~amd64\n\
dev-libs/rocm-smi-lib ~amd64\n\
sys-devel/hcc ~amd64\n\
\n\
sys-devel/hip ~amd64\n\
sci-libs/rocRAND ~amd64\n\
sci-libs/hipCUB ~amd64\n\
sci-libs/rocSPARSE ~amd64\n\
dev-util/rocm-clang-ocl ~amd64\n\
sci-libs/rocThrust ~amd64\n\
sci-libs/rocALUTION ~amd64\n\
sci-libs/rocBLAS ~amd64\n\
sci-libs/hipBLAS ~amd64\n\
sci-libs/hipSPARSE ~amd64\n\
sci-libs/rocPRIM ~amd64\n\
sci-libs/rocSOLVER ~amd64\n\
sci-libs/rocFFT ~amd64\n\
\n\
sci-libs/miopengemm ~amd64\n\
dev-libs/khronos-ocl-icd ~amd64\n\
dev-libs/half ~amd64\n\
sci-libs/miopen ~amd64\n\
dev-libs/rccl ~amd64\n\
\n\
dev-python/CppHeaderParser ~amd64\n\
dev-util/roctracer ~amd64" > /etc/portage/package.accept_keywords/rocm && \
\
echo -e ">dev-libs/rocm-opencl-runtime-3.0.0\n\
>dev-libs/rocm-device-libs-3.0.0\n\
>dev-libs/rocm-opencl-driver-3.0.0\n\
>dev-libs/rocm-comgr-3.0.0\n\
>dev-util/rocminfo-3.0.0-r1\n\
>dev-util/rocm-cmake-3.0.0\n\
>dev-libs/rocr-runtime-3.0.0\n\
>sys-devel/hip-3.0.0\n\
>sys-devel/llvm-roc-3.0.0\n\
>sci-libs/miopen-3.0.0\n\
>sys-devel/hcc-3.0.0\n\
>sci-libs/rocBLAS-3.0.0\n\
>dev-util/amd-rocm-meta-3.0.0\n\
>dev-libs/roct-thunk-interface-3.0.0\n\
>dev-libs/rccl-3.0.0\n\
>sci-libs/rocThrust-3.0.0" > /etc/portage/package.mask/rocm && \
\
echo -e "dev-util/amd-rocm-meta hip opencl science\n\
sci-libs/rocSOLVER -gfx803 gfx906\n\
sci-libs/rocALUTION -gfx803 gfx906\n\
sci-libs/rocSPARSE -gfx803 gfx906\n\
sci-libs/rocFFT -gfx803 gfx906\n\
sci-libs/rocBLAS -gfx803 gfx906\n\
dev-libs/rccl -gfx803 gfx906" > /etc/portage/package.use/rocm && \
\
echo -e "media-libs/libglvnd X" > /etc/portage/package.use/libglvnd && \
echo -e "MAKEOPTS=\"-j1\"" > /etc/portage/env/onejob.conf && \
\
echo -e "sci-libs/rocFFT onejob.conf" > /etc/portage/package.env/rocm

RUN ebuild /var/db/repos/rocm/sci-libs/rocALUTION/rocALUTION-3.0.0.ebuild manifest --force

RUN emerge amd-rocm-meta