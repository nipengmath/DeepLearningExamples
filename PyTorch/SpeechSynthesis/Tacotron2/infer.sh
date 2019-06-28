#!/bin/bash

export PYTHONPATH=$PYTHONPATH:/data/nipeng/apex

CUDA_VISIBLE_DEVICES=3 python inference.py \
    --tacotron2 output/checkpoint_Tacotron2_10 \
    --waveglow output/checkpoint_WaveGlow_50 \
    -o output/ \
    -i phrase.txt \
    --sampling-rate 48000 \
    --fp16-run
