#!/bin/sh

for i in {1..6};
do
  starcluster start -b 2 -c queue320_8x_$i cluster$i
done