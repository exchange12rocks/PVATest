BeforeAll {
    $VarSet = 'SET'
    Write-Host "HIT BEFOREALL $VarSet"
}

Describe 'DESCRIBE-1' {
    BeforeAll {
        $Result = $VarSet
    }

    It 'Result exists' {
        $Result | Should -Be 'SET'
    }
}