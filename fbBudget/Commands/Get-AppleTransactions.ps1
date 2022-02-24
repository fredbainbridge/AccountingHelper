function Get-AppleTransactions {
    param(
        [string] $Path
    )
    $transactions = @()
    $csv = Import-Csv -Path $Path
    foreach($line in $csv) {
        $t = [Transaction]::new()
        $t.Bank = "Apple"
        $t.Date = $line.'Transaction Date'
        $t.Description = $line.Description
        $t.Detail = $line.'Merchant'
        $t.Amount = -1 * $line.'Amount (USD)' -replace '\$',''
        
        $transactions += $t
    }
    $transactions
}