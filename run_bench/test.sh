#!/bin/bash

sudo pcm-memory -csv=./test.log &
pid=$(echo $!)
echo $pid
sleep 7
sudo kill -15 $pid
