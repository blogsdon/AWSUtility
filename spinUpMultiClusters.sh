#!/bin/bash

for i in {1..5}
do
  starcluster start -b 2 -c queue320_8x_$i cluster_$i
done
