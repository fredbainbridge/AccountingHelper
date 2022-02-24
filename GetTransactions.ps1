param(
    [string]$Dir = "D:\Users\FredBainbridge\Downloads"
)

Import-Module .\fbBudget -Force

$files = Get-ChildItem -Path $Dir -Filter *.csv
$CapitalOne = "Transaction Date,Posted Date,Card No.,Description,Category,Debit,Credit"
$Affinity = '"Date","Description","Comments","Check Number","Amount","Balance"'
$Topline = '"Transaction ID","Posting Date","Effective Date","Transaction Type","Amount","Check Number","Reference Number","Description","Transaction Category","Type","Balance","Memo","Extended Description"'
$Amazon = 'Transaction Date,Posting Date,Reference Number,Amount,Description'
$CostCo = 'Status,Date,Description,Debit,Credit,Member Name'
$Apple = 'Transaction Date,Clearing Date,Description,Merchant,Category,Type,Amount (USD),Purchased By'
$transactions = @();
foreach($file in $files) {
    $content = Get-Content -Path $file.FullName
    if($content.count -eq 1) {
        continue
    }
    $header = $content[0];
    switch ($header) {
        $CapitalOne { $transactions += Get-CapitalOneTransactions -Path $file.FullName }
        $Affinity { $transactions += Get-AffinityTransactions -Path $file.FullName }
        $Topline { $transactions += Get-ToplineTransactions -Path $file.FullName }
        $Amazon { $transactions += Get-AmazonTransactions -Path $file.FullName }
        $CostCo {$transactions += Get-CostCoTransactions -Path $file.FullName }
        $Apple {$transactions += Get-AppleTransactions -Path $file.FullName}
        Default { $transactions += Get-WellsFargoTransactions -Path $file.FullName }
    }
}
$json = $transactions | ConvertTo-Json

$json | Out-File -FilePath D:\apps\accounting\newtransactions.json -Force

Invoke-WebRequest -Uri https://localhost:6001/Accounting -UseBasicParsing