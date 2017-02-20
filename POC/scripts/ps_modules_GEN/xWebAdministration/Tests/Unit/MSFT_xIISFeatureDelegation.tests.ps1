
$script:DSCModuleName = 'xWebAdministration'
$script:DSCResourceName = 'MSFT_xIISFeatureDelegation'

#region HEADER

$script:moduleRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$repoSource = (Get-Module -Name $script:DSCModuleName -ListAvailable)

# If module was obtained from the gallery install test folder from the gallery instead of cloning from git
if (($null -ne $repoSource) -and ($repoSource[0].RepositorySourceLocation.Host -eq 'www.powershellgallery.com'))
{
    if ( -not (Test-Path -Path (Join-Path -Path $script:moduleRoot -ChildPath 'Tests\DscResourceTestHelper')) )
    {
        $choice = 'y'

        # If user wants to skip prompt - set this environment variale equal to 'true'
        if ($env:getDscTestHelper -ne $true)
        {
            $choice = read-host 'In order to run this test you need to install a helper module, continue with installation? (Y/N)'
        }

        if ($choice -eq 'y')
        {
            # Install test folders from gallery
            Save-Module -Name 'DscResourceTestHelper' -Path (Join-Path -Path $script:moduleRoot -ChildPath 'Tests')
        }

        else 
        {
            Write-Error 'Unable to run tests without the required helper module - Exiting test'
            return
        }
        
    }

    $testModuleVer = Get-ChildItem -Path (Join-Path -Path $script:moduleRoot -ChildPath '\Tests\DscResourceTestHelper')
    Import-Module (Join-Path -Path $script:moduleRoot -ChildPath "Tests\DscResourceTestHelper\$testModuleVer\TestHelper.psm1") -Force
} 
# Otherwise module was cloned from github
else
{
    # Get common tests and test helpers from gitHub rather than installing them from the gallery
    # This ensures that developers always have access to the most recent DscResource.Tests folder 
    $testHelperPath = (Join-Path -Path $script:moduleRoot -ChildPath '\Tests\DscResource.Tests\DscResourceTestHelper\TestHelper.psm1')
    if (-not (Test-Path -Path $testHelperPath))
    {
        # Clone test folders from gitHub
        $dscResourceTestsPath = Join-Path -Path $script:moduleRoot -ChildPath '\Tests\DscResource.Tests'
        & git @('clone','https://github.com/PowerShell/DscResource.Tests.git',$dscResourceTestsPath)
        
        # TODO get rid of this section once we update all other resources and merge the gitDependency branch with the main branch on DscResource.Tests
        Push-Location
        Set-Location $dscResourceTestsPath
        & git checkout gitDependency
        Pop-Location
    }

    Import-Module $testHelperPath -Force
}

Import-Module (Join-Path -Path $script:moduleRoot -ChildPath 'Tests\MockWebAdministrationWindowsFeature.psm1')

$TestEnvironment = Initialize-TestEnvironment `
    -DSCModuleName $script:DSCModuleName `
    -DSCResourceName $script:DSCResourceName `
    -TestType Unit
#endregion

# Begin Testing
try
{
    #region Pester Tests
    InModuleScope $DSCResourceName {

        #region Function Get-TargetResource
        Describe 'MSFT_xIISFeatureDelegation\Get-TargetResource' {
            Context 'OverRideMode is present' {
                Mock Get-OverrideMode {return 'Allow'}
                $result = Get-TargetResource -SectionName 'serverRunTime' -OverRideMode 'Allow'
                $expected = @{
                    SectionName = 'serverRunTime'
                    OverrideMode = 'Allow'
                    Ensure = 'Present'
                }
                It 'should return the correct hashtable' {
                    $result.SectionName  | Should Be $expected.SectionName
                    $result.OverrideMode | Should Be $expected.OverrideMode
                }
            }
            Context 'OverRideMode is absent' {
                Mock Get-OverrideMode {return 'Deny'}
                $result = Get-TargetResource -SectionName 'serverRunTime' -OverRideMode 'Allow'
                $expected = @{
                    SectionName = 'serverRunTime'
                    OverrideMode = 'Deny'
                    Ensure = 'Absent'
                }
                It 'should return the correct hashtable' {
                    $result.SectionName  | Should Be $expected.SectionName
                    $result.OverrideMode | Should Be $expected.OverrideMode
                }
            }
        }
        #endregion


        #region Function Test-TargetResource
        Describe 'MSFT_xIISFeatureDelegation\Test-TargetResource' {
            Context 'OverRideMode is present' {
                Mock Get-OverrideMode {return 'Allow'}
                It 'should return true' {
                    $results = Test-TargetResource -SectionName 'serverRunTime' -OverRideMode 'Allow'
                    $results | Should Be $true
                }
            }

            Context 'OverRideMode is absent' {
                Mock Get-OverrideMode {return 'Allow'}
                It 'should return true' {
                    $results = Test-TargetResource -SectionName 'serverRunTime' -OverRideMode 'Deny'
                    $results | Should Be $false
                }
            }
        }
        #endregion


        #region Function Set-TargetResource
        Describe 'MSFT_xIISFeatureDelegation\Set-TargetResource' {
            Context 'Settings are correct' {

                Mock -ModuleName MSFT_xIisFeatureDelegation -CommandName Set-WebConfiguration -MockWith {}

                Set-TargetResource -SectionName 'mockName' -OverrideMode 'Allow'

                It 'should call all the mocks' {
                    Assert-MockCalled -ModuleName MSFT_xIisFeatureDelegation -CommandName Set-WebConfiguration -Exactly 1
                }
            }

        }
        #endregion

        Describe 'MSFT_xIISFeatureDelegation\Get-OverrideMode' {
            $mockWebConfigOutput = 
            @{
                Metadata = 
                @{
                    effectiveOverrideMode = $null
                }
            }
            $mockSection = 'NonExistant'
            Mock -CommandName Assert-Module -MockWith {}
        
            Context 'function is not able to find a value' {
                It 'Should throw an error on null' {
                    Mock Get-WebConfiguration { return $mockWebConfigOutput }
                    {Get-OverrideMode -Section $mockSection} | Should Throw ($LocalizedData.UnableToGetConfig -f $mockSection)
                }

                It 'Should throw an error on the wrong value' {
                    $mockWebConfigOutput.Metadata.effectiveOverrideMode = 'Wrong'
                    Mock Get-WebConfiguration { return $mockWebConfigOutput }
                    {Get-OverrideMode -Section $mockSection} | Should Throw ($LocalizedData.UnableToGetConfig -f $mockSection)
                }
            }
                        
            Context 'oMode is set correctly' {
                $mockWebConfigOutput.Metadata.effectiveOverrideMode = 'Allow'
                Mock -CommandName Get-WebConfiguration -MockWith {return $mockWebConfigOutput}
                
                $oMode = Get-OverrideMode -Section $mockSection
                It 'Should be Allow' {
                    $oMode | Should Be 'Allow'
                }
            
            }
        }

    }
    #endregion
}
finally
{
    #region FOOTER
    Restore-TestEnvironment -TestEnvironment $TestEnvironment
    #endregion
}
