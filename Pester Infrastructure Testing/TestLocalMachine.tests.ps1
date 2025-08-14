BeforeAll {
    # Code to run before all tests
}

AfterAll {
    # Code to run after all tests
}

Describe "Testing local machine settings" {
    Context 'Time Settings' {
        It "Should have the correct time zone" {
            $expectedTimeZone = 'W. Europe Standard Time'
            $currentTimeZone = (Get-TimeZone).Id
            $currentTimeZone | Should -Be $expectedTimeZone
        }

        It "Is the Windows Time Service enabled?" {
            $service = Get-Service -Name w32time -ErrorAction SilentlyContinue
            $service | Should -Not -BeNullOrEmpty
            $service.Status | Should -Be 'Running'
        }

        It "NTP Server is configured correctly" {
            $settings = w32tm /query /peers
            $settings = $settings -join "`n"
            $settings | Should -Not -BeNullOrEmpty
            $settings | Should -BeLike '*time.windows.com*'
        }

       #It "Should have the correct system time" {
       #    $expectedTime = (Get-Date).ToUniversalTime()
       #    $currentTime = (Get-Date).ToUniversalTime()
       #    $currentTime | Should -Be $expectedTime
       #}
    }
}