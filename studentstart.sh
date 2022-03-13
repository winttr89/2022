#!/bin/bash
x=1
while [ $x -le 500 ]
do
  echo "Start vps lan $x"
  az vm start --ids $(az vm list -g Server --query "[?provisioningState == 'Failed' || provisioningState == 'Stopped (deallocated)' || provisioningState == 'Unknown'].id" -o tsv) --no-wait
  sleep 1m
  x=$(( $x + 1 ))
done
