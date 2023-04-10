#!/bin/bash
./iceprog --help  2>/dev/null
# Check to make sure that it worked 
if [ $? -eq 0 ]; then
  echo "iceprog is already installed"
  exit 0
fi
