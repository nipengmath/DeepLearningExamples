#!/bin/bash

export PYTHONPATH=$PYTHONPATH:/data/nipeng/apex

mkdir -p output
CUDA_VISIBLE_DEVICES=0,1,2 python -m multiproc train.py \
    -m WaveGlow \
    -o ./output/ \
    -lr 1e-4 \
    --epochs 2001 \
    -bs 16 \
    --segment-length  8000 \
    --weight-decay 0 \
    --grad-clip-thresh 65504.0 \
    --epochs-per-checkpoint 50 \
    --cudnn-benchmark=True \
    --log-file ./output/nvlog.json \
    --fp16-run \
    --sampling-rate 48000
    # --resume True \
    # --resume-waveglow-path output/checkpoint_WaveGlow_200
