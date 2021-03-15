BeforeDiscovery {
    $VarSet = 'SET'
    Write-Host "HIT BEFOREDISC $VarSet"
}

Describe 'DESCRIBE-1' {
    BeforeAll {
        $Result = $VarSet
    }

    It 'Result exists' {
        $Result | Should -Be 'SET'
    }
}