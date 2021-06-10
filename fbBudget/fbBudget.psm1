class Transaction {
    [DateTime]$Date
    [string]$Detail
    [string]$Description
    [double]$Amount
    [string]$Bank
}
. $PSScriptRoot\Commands\Get-CapitalOneTransations.ps1
. $PSScriptRoot\Commands\Get-AffinityTransactions.ps1
. $PSScriptRoot\Commands\Get-ToplineTransactions.ps1
. $PSScriptRoot\Commands\Get-WellsFargoTransactions.ps1
. $PSScriptRoot\Commands\Get-AmazonTransactions.ps1
. $PSScriptRoot\Commands\Get-CostCoTransactions.ps1
