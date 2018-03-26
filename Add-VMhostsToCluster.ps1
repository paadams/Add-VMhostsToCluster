# PowerCLI function to add ESXi hosts to vCenter Server
# Version 1.1
# 
function Add-VMhostsToCluster {
    Param(
        [string]$vCenter,
        [string]$clusterName,
        [string[]]$esxihosts
    )
  
        Write-host Enter your vCenter Credentials. -foreground green
        $vCenterCred = Get-Credential

        Write-host Enter your ESXi username and password. -foreground green
        $esxiCred = Get-Credential  
        # ---------------------------------------------------
        #
        #Connect to vCenter Server
        write-host Connecting to vCenter Server $vCenter -foreground green
        Connect-viserver $vCenter -Credential $vCenterCred
        #
        write-host --------
        write-host Start adding ESXi hosts to the vCenter Server $vCenter
        write-host --------
        #
        # Add ESXi hosts
        foreach ($esxihost in $esxihosts) {
        Add-VMHost $esxihost -Location $clusterName -Credential $esxiCred -Force
        } #foreach

        # Disconnect from vCenter Server
        write-host "Disconnecting to vCenter Server $vcenter" -foreground green
        disconnect-viserver -confirm:$false | out-null

    } #function
