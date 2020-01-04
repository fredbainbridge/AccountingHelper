function Get-AffinityTransactions {
    param(
        [string] $Path
    )
    $transactions = @()
    $csv = Import-Csv -Path $Path
    foreach($line in $csv) {
        $t = [Transaction]::new()
        $t.Bank = "Affinity"
        $t.Date = $line.'Date'
        $t.Description = $line.Description
        $t.Detail = $line.'Check Number'
        $t.Amount = $line.Amount -replace '\$',''
        
        $transactions += $t
    }
    $transactions
}