#!/bin/bash
x=1
while [ $x -le 500 ]
do
  echo "Start vps lan $x"
  az vmss start --ids $(az vmss list --resource-group my2021 --query "[?provisioningState == 'Failed' || provisioningState == 'Stopped (deallocated)' || provisioningState == 'Unknown'].id" -o tsv) --no-wait
  sleep 1m
  x=$(( $x + 1 ))
done
