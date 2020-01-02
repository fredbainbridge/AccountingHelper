function Get-CapitalOneTransactions {
    param(
        [string] $Path
    )
    $transactions = @()
    $csv = Import-Csv -Path $Path
    foreach($line in $csv) {
        $t = [Transaction]::new()
        $t.Bank = "CapitalOne"
        $t.Date = $line.'Transaction Date'
        $t.Description = $line.Description
        $t.Detail = $line.'Card No.'
        if([string]::IsNullOrEmpty($line.Credit)) {
            $t.Amount = -1 * $line.Debit
        }
        else {
            $t.Amount = $line.Credit
        }
        $transactions += $t
    }
    $transactions
}