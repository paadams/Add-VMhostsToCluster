<#

.SYNOPSIS
This is a function to add VMware ESXi hosts to an existing cluster in vCenter

.DESCRIPTION
The function will add one or more hosts to an existing cluster

.EXAMPLE
Add-VMhostsToCluster -vCenter vCenter.domain.local -clusterName "Cluster 01" -esxihosts (Get-Content C:\Temp\vmhosts.txt)

Add-VMhostsToCluster -vCenter 192.168.130.11 -clusterName Cluster01 -esxihosts host01.domain.local, host02.domain.local

.NOTES

.LINK

#>
 
Function Add-VMhostsToCluster {
    Param(
        [string]$vCenter,
        [string]$clusterName,
        [string[]]$esxihosts
    )
    
    BEGIN {
        # Get and store vCente and ESXi credentials
        Write-host Enter your vCenter Credentials. -foreground green
        $vCenterCred = Get-Credential
        Write-host Enter your ESXi username and password. -foreground green
        $esxiCred = Get-Credential  
    } # BEGIN

    PROCESS {
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

    } # PROCESS

    END {
        # Disconnect from vCenter Server
        write-host "Disconnecting to vCenter Server $vcenter" -foreground green
        disconnect-viserver -confirm:$false | out-null

    } # END

} # End Add-VMhostsToCluster function

    