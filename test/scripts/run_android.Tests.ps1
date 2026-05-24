$scriptPath = Join-Path $PSScriptRoot '..\..\scripts\run_android.ps1'
. $scriptPath

Describe 'ConvertFrom-FlutterDevicesJson' {
    It '只保留 Android 设备并输出统一字段' {
        $json = @'
[
  {
    "name": "Windows",
    "id": "windows",
    "isSupported": true,
    "targetPlatform": "windows-x64"
  },
  {
    "name": "Pixel 9 Pro",
    "id": "emulator-5554",
    "isSupported": true,
    "targetPlatform": "android-x64"
  },
  {
    "name": "USB Device",
    "id": "R58N123456",
    "isSupported": true,
    "targetPlatform": "android-arm64"
  }
]
'@

        $devices = ConvertFrom-FlutterDevicesJson -Json $json

        $devices.Count | Should Be 2
        $devices[0].Name | Should Be 'Pixel 9 Pro'
        $devices[0].Id | Should Be 'emulator-5554'
        $devices[1].Name | Should Be 'USB Device'
        $devices[1].Platform | Should Be 'android-arm64'
    }
}

Describe 'ConvertFrom-FlutterEmulatorsText' {
    It '解析 flutter emulators 输出中的 Android 模拟器列表' {
        $text = @(
            '2 available emulators:',
            '',
            'Id                 • Name               • Manufacturer • Platform',
            '',
            'Pixel_9_Pro_API_35 • Pixel 9 Pro API 35 • Google       • android',
            'Small_Phone_API_34 • Small Phone API 34 • Google       • android',
            '',
            'To run an emulator, run flutter emulators --launch emulator-id.'
        ) -join "`n"

        $emulators = ConvertFrom-FlutterEmulatorsText -Text $text

        $emulators.Count | Should Be 2
        $emulators[0].Id | Should Be 'Pixel_9_Pro_API_35'
        $emulators[0].Name | Should Be 'Pixel 9 Pro API 35'
        $emulators[1].Manufacturer | Should Be 'Google'
    }

    It '当 flutter emulators 没有列表行时返回空结果' {
        $text = @(
            'No emulators available.',
            'Run flutter emulators --create to create a new emulator.'
        ) -join "`n"

        $emulators = ConvertFrom-FlutterEmulatorsText -Text $text

        @($emulators).Count | Should Be 0
    }
}

Describe 'ConvertFrom-AvdListText' {
    It '解析 emulator -list-avds 输出中的 AVD 名称' {
        $text = @(
            'Pixel_9_Pro_API_35',
            'Small_Phone_API_34'
        ) -join "`n"

        $emulators = ConvertFrom-AvdListText -Text $text

        $emulators.Count | Should Be 2
        $emulators[0].Id | Should Be 'Pixel_9_Pro_API_35'
        $emulators[0].Name | Should Be 'Pixel 9 Pro API 35'
        $emulators[0].Manufacturer | Should Be 'Unknown'
        $emulators[1].Platform | Should Be 'android'
    }
}

Describe 'Get-AndroidRunPlan' {
    It '有唯一已连接设备时直接使用该设备' {
        $plan = Get-AndroidRunPlan `
            -ConnectedDevices @(
                [pscustomobject]@{
                    Name = 'Pixel 9 Pro'
                    Id = 'emulator-5554'
                    Platform = 'android-x64'
                }
            ) `
            -AvailableEmulators @()

        $plan.Mode | Should Be 'UseConnectedDevice'
        $plan.DeviceId | Should Be 'emulator-5554'
    }

    It '没有已连接设备且只有一个模拟器时也需要用户选择' {
        $plan = Get-AndroidRunPlan `
            -ConnectedDevices @() `
            -AvailableEmulators @(
                [pscustomobject]@{
                    Name = 'Pixel 9 Pro API 35'
                    Id = 'Pixel_9_Pro_API_35'
                    Manufacturer = 'Google'
                    Platform = 'android'
                }
            )

        $plan.Mode | Should Be 'LaunchEmulator'
        $plan.RequiresSelection | Should Be $true
    }

    It '没有已连接设备且有多个模拟器时需要用户选择' {
        $plan = Get-AndroidRunPlan `
            -ConnectedDevices @() `
            -AvailableEmulators @(
                [pscustomobject]@{
                    Name = 'Pixel 9 Pro API 35'
                    Id = 'Pixel_9_Pro_API_35'
                    Manufacturer = 'Google'
                    Platform = 'android'
                },
                [pscustomobject]@{
                    Name = 'Small Phone API 34'
                    Id = 'Small_Phone_API_34'
                    Manufacturer = 'Google'
                    Platform = 'android'
                }
            )

        $plan.Mode | Should Be 'LaunchEmulator'
        $plan.RequiresSelection | Should Be $true
    }
}

Describe 'Resolve-NewAndroidDeviceAfterLaunch' {
    It '当 AVD 名称和真实设备 ID 不一致时，返回新连接的模拟器设备' {
        $beforeDevices = @()
        $afterDevices = @(
            [pscustomobject]@{
                Name = 'sdk gphone64 x86 64'
                Id = 'emulator-5554'
                Platform = 'android-x64'
                IsEmulator = $true
            }
        )

        $resolved = Resolve-NewAndroidDeviceAfterLaunch `
            -BeforeDevices $beforeDevices `
            -AfterDevices $afterDevices `
            -LaunchedEmulatorId 'Pixel_9_Pro_API_35'

        $resolved.Id | Should Be 'emulator-5554'
        $resolved.Name | Should Be 'sdk gphone64 x86 64'
    }
}
