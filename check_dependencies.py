#!/usr/bin/env python

from __future__ import print_function
import subprocess
import sys

class output:
    HEADER = '\033[95m'
    BOLD = '\033[1m'
    OK = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

# Start checking pre-requisites
print()

#
# VMWare fusion
#
print(output.BOLD,"Checking for VMWare Fusion presense......", end='')
vmwarestatus = subprocess.call(["vmrun", "list"], stdout=subprocess.PIPE)
if vmwarestatus !=0:
	print(ouput.FAIL,"FAILED")
else:
	print(output.OK,"OK")

print(output.ENDC, end='')


#
# Vagrant
#
print(output.BOLD, "Checking for Vagrant presense......", end='')
sys.stdout.flush()
vagrantstatus = subprocess.call(["vagrant", "status"], stdout=subprocess.PIPE)
if vagrantstatus !=0:
	print(output.FAIL,"FAILED")
else:
	print(output.OK,"OK")


# End checking pre-requisites
print()
