<#
This script creates a new VM Infra Provider Master Policy. 
Depends_on Node Group Profiles.
#>

# Source Variables file
. ./00_variables.ps1

Set-IntersightConfiguration @ApiParams

# Variables Section
$name                  = "pwsh_controlPlaneNodePool1"
$vmInstanceName        = "pwsh_vm_instance"
$infraConfigPolicyName = "pwsh_vmInfraConfig1"
$nodeGroupName         = "pwsh_cpNodegroup_profile"

# Initialize Objects
$instanceTypeObject = Initialize-IntersightMoMoRef -ClassId "MoMoRef" -ObjectType "kubernetesVirtualMachineInstanceType" -Selector "Name eq '$($vmInstanceName)'"

$infraConfigPolicyObject = Initialize-IntersightMoMoRef -ClassId "MoMoRef" -ObjectType "kubernetesVirtualMachineInfraConfigPolicy" -Selector "Name eq '$($infraConfigPolicyName)'"

$nodeGroupObject = Initialize-IntersightMoMoRef -ClassId "MoMoRef" -ObjectType "kubernetesNodeGroupProfile" -Selector "Name eq '$($nodeGroupName)'"

# Create Virtual Machine Infrastructure Providers Policy
New-IntersightKubernetesVirtualMachineInfrastructureProvider -Name $name -InstanceType $instanceTypeObject -InfraConfigPolicy $infraConfigPolicyObject -NodeGroup $nodeGroupObject