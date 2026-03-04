#!/bin/bash
if command -v qemu-system >/dev/null 2>&1; then
else
     apt-get install qemu-system
     
fi
