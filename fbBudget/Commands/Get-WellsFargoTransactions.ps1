function Get-WellsFargoTransactions {
    param(
        [string] $Path
    )
    $transactions = @()
    $headers = "Date", "Amount", "Something", "SomethingElse", "Description"
    $csv = Import-Csv -Path $Path -Header $headers
    foreach($line in $csv) {
        $t = [Transaction]::new()
        $t.Bank = "WellsFargo"
        $t.Date = $line.'Date'
        $t.Description = $line.Description
        $t.Detail = ''
        $t.Amount = $line.Amount
        $transactions += $t
    }
    $transactions
}