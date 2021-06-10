function Get-CostCoTransactions {
    param(
        [string] $Path
    )
    $transactions = @()
    $csv = Import-Csv -Path $Path
    foreach($line in $csv) {
        $t = [Transaction]::new()
        #'Status,Date,Description,Debit,Credit,Member Name'
        $t.Bank = "CostCo"
        $t.Date = $line.'Date'
        $t.Description = $line.Description
        $t.Detail = $line.'Member Name'
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