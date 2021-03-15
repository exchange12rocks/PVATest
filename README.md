# Pester BeforeDiscovery Variables Availability Test

I found that when I define variables in `BeforeDiscovery`, they not always avilable in `It` and `Describe`/`Context` blocks later - it depends on the host where you execute the script. I also found that variables defined in `BeforeDiscovery` available in `InModuleScope` only when you run the test in VSCode through its `Start Debugging` command (F5 key).

I manually tested how different hosts execute these tests. Each run was a clean run, meaning I reopened the applications between runs.

"Invoke-Pester" means I passed a file's path to the `Invoke-Pester` cmdlet. "Direct" means I just executed a test's .ps1 file, and in VSCode I ran it using the F5 key.

The difference between `BD` and `BA` is that the former one uses `BeforeDiscovery` to define variables, while the other one - `BeforeAll`.

The difference between `INT` and `EXT` is that in INT I run tests in InModuleScope.

## Overall result

|Test|VSCode<br />Invoke-Pester|VSCode<br />Direct|pwsh<br />Invoke-Pester|pwsh<br />Direct|Win PoSh<br />Invoke-Pester|Win PoSh<br />Direct|
|-|-|-|-|-|-|-|
|Test.INT.BD.Tests|❌|✔|❌|❌|❌|❌|
|Test.EXT.BD.Tests|❌|✔|❌|✔|❌|✔|
|Test.INT.BA.Tests|❌|❌|❌|❌|❌|❌|
|Test.EXT.BA.Tests|✔|✔|✔|✔|✔|✔|

## VSCode

### Test.INT.BD.Tests

#### Invoke

    PS C:\Scripts\PVATest> Invoke-Pester -Path .\Test.INT.BD.Tests.ps1


    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 206ms.
    [-] INMODULE-1.DESCRIBE-1.Result exists 127ms (108ms|19ms)
        Expected 'SET', but got $null.
        at $Result | Should -Be 'SET', C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
        at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
    Tests completed in 937ms
    Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0

#### Direct (F5)

    PS C:\Scripts\PVATest> c:\Scripts\PVATest\Test.INT.BD.Tests.ps1
    HIT BEFOREDISC SET

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 194ms.
    [+] C:\Scripts\PVATest\Test.INT.BD.Tests.ps1 901ms (122ms|610ms)
    Tests completed in 919ms
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

### Test.EXT.BD.Tests

#### Invoke

    PS C:\Scripts\PVATest> Invoke-Pester -Path .\Test.EXT.BD.Tests.ps1


    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 177ms.
    [-] DESCRIBE-1.Result exists 129ms (112ms|18ms)
        Expected 'SET', but got $null.
        at $Result | Should -Be 'SET',C:\Scripts\PVATest\Test.EXT.BD.Tests.ps1:12
        at <ScriptBlock>, C:\Scripts\PVATest\Test.EXT.BD.Tests.ps1:12
    Tests completed in 832ms
    Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0

#### Direct (F5)

    PS C:\Scripts\PVATest> c:\Scripts\PVATest\Test.EXT.BD.Tests.ps1
    HIT BEFOREDISC SET

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 157ms.
    [+] C:\Scripts\Test.EXT.BD.Tests.ps1 718ms (105ms|476ms)
    Tests completed in 735ms
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

### Test.INT.BA.Tests

#### Invoke

    PS C:\Scripts\PVATest> Invoke-Pester -Path .\Test.INT.BA.Tests.ps1


    Starting discovery in 1 files.
    System.Management.Automation.RuntimeException: No modules named 'PVATest' are currently loaded.
    at Get-ScriptModule, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8968
    at InModuleScope, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8927
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 8
    at New-Block, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 766
    at Describe, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8578
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7
    at <ScriptBlock>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2903
    at Invoke-File, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2912
    at Invoke-BlockContainer, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2837
    at Discover-Test, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 1411
    at Invoke-Test, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2356
    at Invoke-Pester<End>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 4839
    at <ScriptBlock>, <No file>: line 1

#### Direct (F5)

    PS C:\Scripts\PVATest> c:\Scripts\PVATest\Test.INT.BA.Tests.ps1

    Starting discovery in 1 files.
    System.Management.Automation.RuntimeException: No modules named 'PVATest' are currently loaded.
    at Get-ScriptModule, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8968
    at InModuleScope, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8927
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 8
    at New-Block, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 766
    at Describe, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8578
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7
    at <ScriptBlock>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2903
    at Invoke-File, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2912
    at Invoke-BlockContainer, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2837
    at Discover-Test, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 1411
    at Invoke-Test, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2356
    at Invoke-Pester<End>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 4839
    at <ScriptBlock>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8609
    at Invoke-Interactively, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8613
    at Describe, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8582
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7

### Test.EXT.BA.Tests

#### Invoke

    PS C:\Scripts\PVATest> Invoke-Pester -Path .\Test.EXT.BA.Tests.ps1


    Starting discovery in 1 files.
    Discovery finished in 185ms.
    HIT BEFOREALL SET
    [+] C:\Scripts\PVATest\Test.EXT.BA.Tests.ps1 948ms (191ms|594ms)
    Tests completed in 975ms
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

#### Direct (F5)

    PS C:\Scripts\PVATest> c:\Scripts\PVATest\Test.EXT.BA.Tests.ps1

    Starting discovery in 1 files.
    Discovery finished in 154ms.
    HIT BEFOREALL SET
    [+] C:\Scripts\PVATest\Test.EXT.BA.Tests.ps1 746ms (123ms|489ms)
    Tests completed in 765ms
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

### $PSVersionTable

    PS C:\Scripts\PVATest> $PSVersionTable


    Name                           Value
    ----                           -----
    PSVersion                      7.1.3
    PSEdition                      Core
    GitCommitId                    7.1.3
    OS                             Microsoft Windows 10.0.19042
    Platform                       Win32NT
    PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
    PSRemotingProtocolVersion      2.3
    SerializationVersion           1.1.0.1
    WSManStackVersion              3.0

## PowerShell 7

### Test.INT.BD.Tests

#### Invoke-Pester

    ❯ Invoke-Pester -Path .\Test.INT.BD.Tests.ps1

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 168ms.
    [-] INMODULE-1.DESCRIBE-1.Result exists 118ms (100ms|18ms)
        Expected 'SET', but got $null.
        at $Result | Should -Be 'SET', C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
        at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
    Tests completed in 881ms
    Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0

#### Direct

    ❯ .\Test.INT.BD.Tests.ps1
    HIT BEFOREDISC SET

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 171ms.
    [-] INMODULE-1.DESCRIBE-1.Result exists 122ms (103ms|19ms)
    Expected 'SET', but got $null.
    at $Result | Should -Be 'SET', C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
    Tests completed in 915ms
    Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0

### Test.EXT.BD.Tests

#### Invoke-Pester

    ❯ Invoke-Pester -Path .\Test.EXT.BD.Tests.ps1

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 170ms.
    [-] DESCRIBE-1.Result exists 124ms (105ms|19ms)
        Expected 'SET', but got $null.
        at $Result | Should -Be 'SET', C:\Scripts\PVATest\Test.EXT.BD.Tests.ps1:12
        at <ScriptBlock>, C:\Scripts\PVATest\Test.EXT.BD.Tests.ps1:12
    Tests completed in 766ms
    Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0

#### Direct

    ❯ .\Test.EXT.BD.Tests.ps1
    HIT BEFOREDISC SET

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 155ms.
    [+] C:\Scripts\PVATest\Test.EXT.BD.Tests.ps1 672ms (90ms|452ms)
    Tests completed in 688ms
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

### Test.INT.BA.Tests

#### Invoke-Pester

    ❯ Invoke-Pester -Path .\Test.INT.BA.Tests.ps1

    Starting discovery in 1 files.
    System.Management.Automation.RuntimeException: No modules named 'PVATest' are currently loaded.
    at Get-ScriptModule, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8968
    at InModuleScope, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8927
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 8
    at New-Block, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 766
    at Describe, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8578
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7
    at <ScriptBlock>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2903
    at Invoke-File, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2912
    at Invoke-BlockContainer, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2837
    at Discover-Test, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 1411
    at Invoke-Test, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2356
    at Invoke-Pester<End>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 4839
    at <ScriptBlock>, <No file>: line 1

#### Direct

    ❯ .\Test.INT.BA.Tests.ps1

    Starting discovery in 1 files.
    System.Management.Automation.RuntimeException: No modules named 'PVATest' are currently loaded.
    at Get-ScriptModule, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8968
    at InModuleScope, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8927
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 8
    at New-Block, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 766
    at Describe, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8578
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7
    at <ScriptBlock>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2903
    at Invoke-File, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2912
    at Invoke-BlockContainer, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2837
    at Discover-Test, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 1411
    at Invoke-Test, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2356
    at Invoke-Pester<End>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 4839
    at <ScriptBlock>, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8609
    at Invoke-Interactively, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8613
    at Describe, C:\Users\User\Documents\PowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8582
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7
    at <ScriptBlock>, <No file>: line 1

### Test.EXT.BA.Tests

#### Invoke-Pester

    ❯ Invoke-Pester -Path .\Test.EXT.BA.Tests.ps1

    Starting discovery in 1 files.
    Discovery finished in 163ms.
    HIT BEFOREALL SET
    [+] C:\Scripts\PVATest\Test.EXT.BA.Tests.ps1 710ms (106ms|465ms)
    Tests completed in 727ms
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

#### Direct

    ❯ .\Test.EXT.BA.Tests.ps1

    Starting discovery in 1 files.
    Discovery finished in 150ms.
    HIT BEFOREALL SET
    [+] C:\Scripts\PVATest\Test.EXT.BA.Tests.ps1 709ms (112ms|466ms)
    Tests completed in 733ms
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

### $PSVersionTable

    ❯ $PSVersionTable

    Name                           Value
    ----                           -----
    PSVersion                      7.1.3
    PSEdition                      Core
    GitCommitId                    7.1.3
    OS                             Microsoft Windows 10.0.19042
    Platform                       Win32NT
    PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
    PSRemotingProtocolVersion      2.3
    SerializationVersion           1.1.0.1
    WSManStackVersion              3.0

## Windows PowerShell

### Test.INT.BD.Tests

#### Invoke-Pester

    PS C:\Scripts\PVATest> Invoke-Pester -Path .\Test.INT.BD.Tests.ps1

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 339ms.
    [-] INMODULE-1.DESCRIBE-1.Result exists 252ms (150ms|102ms)
        Expected 'SET', but got $null.
        at $Result | Should -Be 'SET', C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
        at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
    Tests completed in 1.23s
    Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0

#### Direct

    PS C:\Scripts\PVATest> .\Test.INT.BD.Tests.ps1
    HIT BEFOREDISC SET

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 329ms.
    [-] INMODULE-1.DESCRIBE-1.Result exists 203ms (165ms|38ms)
        Expected 'SET', but got $null.
        at $Result | Should -Be 'SET', C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
        at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BD.Tests.ps1:15
    Tests completed in 1.27s
    Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0

### Test.EXT.BD.Tests

#### Invoke-Pester

    PS C:\Scripts\PVATest> Invoke-Pester -Path .\Test.EXT.BD.Tests.ps1

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 293ms.
    [-] DESCRIBE-1.Result exists 187ms (151ms|36ms)
        Expected 'SET', but got $null.
        at $Result | Should -Be 'SET', C:\Scripts\PVATest\Test.EXT.BD.Tests.ps1:12
        at <ScriptBlock>, C:\Scripts\PVATest\Test.EXT.BD.Tests.ps1:12
    Tests completed in 1.13s
    Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0

#### Direct

    PS C:\Scripts\PVATest> .\Test.EXT.BD.Tests.ps1
    HIT BEFOREDISC SET

    Starting discovery in 1 files.
    HIT BEFOREDISC SET
    Discovery finished in 301ms.
    [+] C:\Scripts\PVATest\Test.EXT.BD.Tests.ps1 1.05s (215ms|565ms)
    Tests completed in 1.09s
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

### Test.INT.BA.Tests

#### Invoke-Pester

    PS C:\Scripts\PVATest> Invoke-Pester -Path .\Test.INT.BA.Tests.ps1

    Starting discovery in 1 files.
    System.Management.Automation.RuntimeException: No modules named 'PVATest' are currently loaded.
    at Get-ScriptModule, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8968
    at InModuleScope, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8927
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 8
    at New-Block, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 766
    at Describe, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8578
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7
    at <ScriptBlock>, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2903
    at Invoke-File, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2912
    at Invoke-BlockContainer, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2837
    at Discover-Test, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 1411
    at Invoke-Test, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2356
    at Invoke-Pester<End>, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 4839
    at <ScriptBlock>, <No file>: line 1

#### Direct

    PS C:\Scripts\PVATest> .\Test.INT.BA.Tests.ps1

    Starting discovery in 1 files.
    System.Management.Automation.RuntimeException: No modules named 'PVATest' are currently loaded.
    at Get-ScriptModule, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8968
    at InModuleScope, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8927
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 8
    at New-Block, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 766
    at Describe, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8578
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7
    at <ScriptBlock>, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2903
    at Invoke-File, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2912
    at Invoke-BlockContainer, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2837
    at Discover-Test, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 1411
    at Invoke-Test, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 2356
    at Invoke-Pester<End>, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 4839
    at <ScriptBlock>, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8609
    at Invoke-Interactively, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8613
    at Describe, C:\Users\User\Documents\WindowsPowerShell\Modules\Pester\5.1.1\Pester.psm1: line 8582
    at <ScriptBlock>, C:\Scripts\PVATest\Test.INT.BA.Tests.ps1: line 7
    at <ScriptBlock>, <No file>: line 1

### Test.EXT.BA.Tests

#### Invoke-Pester

    PS C:\Scripts\PVATest> Invoke-Pester -Path .\Test.EXT.BA.Tests.ps1

    Starting discovery in 1 files.
    Discovery finished in 293ms.
    HIT BEFOREALL SET
    [+] C:\Scripts\PVATest\Test.EXT.BA.Tests.ps1 1.02s (166ms|607ms)
    Tests completed in 1.06s
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

#### Direct

    PS C:\Scripts\PVATest> .\Test.EXT.BA.Tests.ps1

    Starting discovery in 1 files.
    Discovery finished in 342ms.
    HIT BEFOREALL SET
    [+] C:\Scripts\PVATest\Test.EXT.BA.Tests.ps1 1.15s (188ms|680ms)
    Tests completed in 1.19s
    Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0

### $PSVersionTable

    PS C:\Scripts\PVATest> $PSVersionTable

    Name                           Value
    ----                           -----
    PSVersion                      5.1.19041.610
    PSEdition                      Desktop
    PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
    BuildVersion                   10.0.19041.610
    CLRVersion                     4.0.30319.42000
    WSManStackVersion              3.0
    PSRemotingProtocolVersion      2.3
    SerializationVersion           1.1.0.1
