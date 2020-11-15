#!/bin/bash
PACKER_LOG=1 packer build -on-error=ask windows_10.json
