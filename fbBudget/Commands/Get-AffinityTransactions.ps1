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
        if($line.Amount.StartsWith("(")) {
            $tmpAmount = $line.Amount.Trim("(").Trim(")").Trim("$")
            $t.Amount = -1 * $tmpAmount
        }
        else {
            $t.Amount = $line.Amount.Trim("$");
        }
        $transactions += $t
    }
    $transactions
}