# https://hub.docker.com/r/nvidia/cuda/tags
# FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04

# https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch/tags
# 23.12-py3: U22.04.3, Py 3.10.12, Torch 2.2, CUDA 12.3
# 24.02-py3: U22.04.3, Py 3.10.12, Torch 2.3, CUDA 12.3
# 24.03-py3: U22.04.4, Py 3.10.12, Torch 2.3, CUDA 12.4
# 24.04-py3: U22.04.4, Py 3.10.12, Torch 2.3, CUDA 12.4
FROM nvcr.io/nvidia/pytorch:24.02-py3

ENV CUDA_HOME=/usr/local/cuda
ENV CUDA_VISIBLE_DEVICES=0

# python-is-python3 \
# python3-pip \
RUN apt update -y && apt install -y \
    git \
    libgl1-mesa-dev \
    libglib2.0-dev \
    ninja-build \
    sudo \
    wget

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /opt/weights && \
    cd /opt/weights && \
    wget -q https://github.com/IDEA-Research/GroundingDINO/releases/download/v0.1.0-alpha/groundingdino_swint_ogc.pth
