# PowerCLI script to add ESXi hosts to vCenter Server
# Version 1.0
# 
# ---------------------------------------------------
# Edit the information below to match your environment
#
# Specify vCenter Server, vCenter Server username, vCenter Server user password, vCenter Server location which can be the Datacenter, a Folder or a Cluster (which I used).
# Parameterize, take user input instead of hardcoded
$vCenter="vcenter"

# Change to Get-Credential
$vCenterUser=""
$vCenterUserPassword="not-secret"

# Parameterize this piece
$vcenterlocation="npx005-01"
#
# Specify the ESXi host you want to add to vCenter Server and the user name and password to be used.
# Paramtererize, take input from pipeline, get-content
$esxihosts=("host01","host02")

# Change to Get-Credential
$esxihostuser="root"
$esxihostpasswd="not-secret"
#
# You don't have to change anything below this line
# ---------------------------------------------------
#
#Connect to vCenter Server
write-host Connecting to vCenter Server $vcenter -foreground green
Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0 | out-null
#
write-host --------
write-host Start adding ESXi hosts to the vCenter Server $vCenter
write-host --------
#
# Add ESXi hosts
foreach ($esxihost in $esxihosts) {
Add-VMHost $esxihost -Location $vcenterlocation -User $esxihostuser -Password $esxihostpasswd
}
#
# Disconnect from vCenter Server
write-host "Disconnecting to vCenter Server $vcenter" -foreground green
disconnect-viserver -confirm:$false | out-null