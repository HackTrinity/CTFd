#!/bin/sh
set -e

pip install -r requirements.txt
for d in CTFd/plugins/*; do
  if [ -f "$d/requirements.txt" ]; then
    pip install -r $d/requirements.txt
  fi
done
