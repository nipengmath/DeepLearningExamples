#!/bin/bash

export PYTHONPATH=$PYTHONPATH:/data/nipeng/apex

mkdir -p output
CUDA_VISIBLE_DEVICES=0,3  python -m multiproc train.py \
    -m Tacotron2 \
    -o ./output/ \
    -lr 1e-3 \
    --epochs 2001 \
    -bs 30 \
    --weight-decay 1e-6 \
    --grad-clip-thresh 1.0 \
    --cudnn-benchmark True \
    --log-file ./output/nvlog.json \
    --anneal-steps 500 1000 1500 \
    --anneal-factor 0.1 \
    --fp16-run \
    --sampling-rate 48000
