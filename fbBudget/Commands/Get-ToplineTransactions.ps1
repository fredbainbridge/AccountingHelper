function Get-ToplineTransactions {
    param(
        [string] $Path
    )
    $transactions = @()
    $csv = Import-Csv -Path $Path
    foreach($line in $csv) {
        $t = [Transaction]::new()
        $t.Bank = "Topline"
        $t.Date = $line.'Posting Date'
        $t.Description = $line.Description
        $t.Detail = $line.'Type'
        $t.Amount = $line.Amount
        $transactions += $t
    }
    $transactions
}