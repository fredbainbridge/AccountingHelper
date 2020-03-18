function Get-AmazonTransactions {
    param(
        [string] $Path
    )
    $transactions = @()
    $csv = Import-Csv -Path $Path
    foreach($line in $csv) {
        $t = [Transaction]::new()
        $t.Bank = "Amazon"
        $t.Date = $line.'Transaction Date'
        $t.Description = $line.Description
        $t.Detail = $line.'Reference Number'
        $t.Amount = $line.Amount
        $transactions += $t
    }
    $transactions
}