#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")

python3 demo/inference_on_a_image.py \
    -c groundingdino/config/GroundingDINO_SwinT_OGC.py \
    -p /opt/weights/groundingdino_swint_ogc.pth \
    -i demo/dogs.png \
    -o output \
    -t "chair"

