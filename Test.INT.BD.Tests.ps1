BeforeDiscovery {
    $VarSet = 'SET'
    Write-Host "HIT BEFOREDISC $VarSet"
    Import-Module -Name (Join-Path -Path $PSScriptRoot -ChildPath 'PVATest.psd1') -Force
}

Describe 'INMODULE-1' {
    InModuleScope PVATest {
        Describe 'DESCRIBE-1' {
            BeforeAll {
                $Result = $VarSet
            }

            It 'Result exists' {
                $Result | Should -Be 'SET'
            }
        }
    }
}