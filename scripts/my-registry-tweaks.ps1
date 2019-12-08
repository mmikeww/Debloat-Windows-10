# just combined some reg entries from the privacy-settings and UI settings into one script


$registryEntries = @(


    # privacy link
    # https://docs.microsoft.com/en-us/windows/configuration/manage-connections-from-windows-operating-system-components-to-microsoft-services




    # Settings -> Privacy -> General

    # Let apps use my advertising ID...
    ("HKLM:\Software\Policies\Microsoft\Windows\AdvertisingInfo", "DisabledByGroupPolicy", 1),
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo", 'Enabled', 0),

    # Let websites provide locally relevant content
    ("HKCU:\Control Panel\International\User Profile", 'HttpAcceptLanguageOptOut', 1),

    # Let Windows track app launches to improve Start and search results
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", 'Start_TrackProgs', 0),

    # Show me suggested content in the Settings App (1709)
    ("HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", 'SubscribedContent-338393Enabled', 0),




    # Settings -> Privacy -> Feedback
    
    # Diagnostic Data
    ("HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection", "AllowTelemetry", 0),
    ("HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection", "AllowTelemetry", 0),
    ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection", "AllowTelemetry", 0),

    # Feedback frequency - never
    ("HKCU:\Software\Microsoft\Siuf\Rules", "NumberOfSIUFInPeriod", 0),
    ("HKCU:\Software\Microsoft\Siuf\Rules", "PeriodInNanoSeconds", 0),
    ("HKLM:\Software\Policies\Microsoft\Windows\DataCollection", "DoNotShowFeedbackNotifications", 1),

    
    


    # Windows Update

    # Change Windows Updates to "Notify to schedule restart" - is this still true?
    #("HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings", 'UxOption', 1),

    # Delivery Optimization - Disable P2P Update downloads outside of local network
    #("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config", 'DODownloadMode', 0),
    # this is the correct key for me on Win10 Fall Creators Update 1709:
    ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings", 'DownloadMode', 0),
    # this will still do it via group policy:
    #("HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization", "DODownloadMode", 0),
    
    # Prevent Windows From Downloading Broken Drivers From Windows Update
    #("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata", "PreventDeviceMetadataFromNetwork", 1),

    # Disable Malicious Software Removal Tool from installing
    #("HKLM:\SOFTWARE\Policies\Microsoft\MRT", 'DontOfferThroughWUAU', 1),

    # Disable automatic updates?
    #("HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU", "NoAutoUpdate", 0)
    #("HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU", "NoAutoUpdate", 0),

    # 0. Notify the user before downloading the update.
    # 1. Auto install the update and then notify the user to schedule a device restart.
    # 2 (default). Auto install and restart.
    # 3. Auto install and restart at a specified time.
    # 4. Auto install and restart without end-user control.
    # 5. Turn off automatic updates.
    ("HKLM:\Software\Microsoft\Windows\CurrentVersion\WindowsStore", "WindowsUpdate", 0),

    # Notify before download: NotConfigured: 0, Disabled: 1, NotifyBeforeDownload: 2, NotifyBeforeInstall: 3, ScheduledInstall: 4
    ("HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU", "AUOptions", 2),
    ("HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU", "AUOptions", 2),

    #("HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU", "ScheduledInstallDay", 0),
    #("HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU", "ScheduledInstallTime", 3),
    





    # Explorer View Options

    # Set Windows Explorer to open on This PC instead of Quick Access
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "LaunchTo", 1),

    # Show hidden files (1=show, 2=hide)
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Hidden", 1),
    
    # Show Protected OS hidden files (1=show, 0=hide)
    #("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "ShowSuperHidden", 1),
    
    # Show file extensions
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "HideFileExt", 0),
    
    # Hide Sync Provider Notifications
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "ShowSyncProviderNotifications", 0),

    # Don't use checkboxes next to files and folders
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "AutoCheckSelect", 0),






    # Lock screen

    # Hide WiFi settings on lock screen
    ("HKLM:\SOFTWARE\Policies\Microsoft\Windows\System", "DontDisplayNetworkSelectionUI", 1),

    # Hide shutdown on lock screen
    #("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System", "ShutdownWithoutLogon", 0)





    # Taskbar

    # Hide the search box from taskbar. You can still search by pressing the Win key and start typing what you're looking for ***
    # 0 = hide completely, 1 = show only icon, 2 = show long search box
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search", "SearchboxTaskbarMode", 0),

    # Hide Task View button
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "ShowTaskViewButton", 0),

    # Hide People icon
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People", "PeopleBand", 0),





    # Windows Defender

    # Disable Cloud-Based Protection: Enabled Advanced: 2, Enabled Basic: 1, Disabled: 0
    # Set-MpPreference -MAPSReporting 0
    ("HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet", "SpyNetReporting", 0),

    # Disable automatic sample submission: Prompt: 0, Auto Send Safe: 1, Never: 2, Auto Send All: 3
    # Set-MpPreference -SubmitSamplesConsent 2
    ("HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet", "SubmitSamplesConsent", 2),





    # Other


    # "Disable Aero-Shake Minimize feature"
    ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "DisallowShaking", 1),

    # Get fun facts, tips, tricks, and more on your lock screen
    ("HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "RotatingLockScreenOverlayEnabled", 0),
    ("HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "SubscribedContent-338389Enabled", 0),
    
    # Windows tips and feedback
    ("HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "SoftLandingEnabled", 0), 

    # Shows occasional app suggestions in Start menu
    ("HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "SystemPaneSuggestionsEnabled",0),
    ("HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager", "SubscribedContent-338388Enabled", 0),

    # *** Disable MRU lists (jump lists) of XAML apps in Start Menu ***
    #("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced", "Start_TrackDocs", 0),

    # Disable Cortana
    #("HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search", "AllowCortana", 1),
    #("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search","CortanaEnabled", 0),

    # program telemetry?
    ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience\Program-Telemetry", "Enabled", 0),

    # Cortana Telemetry
    #("HKLM:\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0", "f!dss-winrt-telemetry.js", 0),
    #("HKLM:\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0", "f!proactive-telemetry.js", 0),
    #("HKLM:\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0", "f!proactive-telemetry-event_8ac43a41e5030538", 0),
    #("HKLM:\COMPONENTS\DerivedData\Components\amd64_microsoft-windows-c..lemetry.lib.cortana_31bf3856ad364e35_10.0.10240.16384_none_40ba2ec3d03bceb0", "f!proactive-telemetry-inter_58073761d33f144b", 0),
  
    # Bing Start Menu Search
    #("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search", "BingSearchEnabled", 0),

    # Program Steps Recorder
    #("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat", "DisableUAR", 1),

    # Autologger records events that occur early in the OS boot process
    #("HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener", "Start", 0),
    #("HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger", "Start", 0),

    # Disable Customer Experience Improvement Telemetry (CEIP/SQM - Software Quality Management)
    #("HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows", "CEIPEnable", 0),

    # Disable Application Impact Telemetry (AIT)
    #("HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat", "AITEnable", 0),

    # SmartScreen Filter for Store Apps: Disable
    #("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost", 'EnableWebContentEvaluation', 0),

    # Game DVR
    #("HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR", "AllowGameDVR", 0),
    #("HKCU:\System\GameConfigStore", "GameDVR_Enabled", 0),

    # WiFi Sense: HotSpot Sharing: Disable
    #("HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting", 'value', 0),

    # WiFi Sense: Shared HotSpot Auto-Connect: Disable
    #("HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots", 'value', 0),

    # WiFi sense disable - new setting?
    ("HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config", "AutoConnectAllowedOEM", 0),

    # Prevents "Consumer Experience Apps" from returning
    ("HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content", "DisableWindowsConsumerFeatures", 1)
)

# Modify Registry Entries using the List above
# 0 = Registry Path, 1 = Registry Key Name, 2 = Key Value
foreach ($entry in $registryEntries) {

    #if registry path doesnt exist, create it
    if (!(Test-Path $entry[0])) {
        New-Item -Path "$($entry[0])" -Force | Out-Null
    }

    Write-Host -f Yellow "Modifying Registry Key: $($entry[0])\$($entry[1])"
    Set-ItemProperty -Path "$($entry[0])" -Name "$($entry[1])" -Value "$($entry[2])" -Type DWORD  #-Force -ErrorAction SilentlyContinue | Out-Null
    if ($? -eq $false){
        #Get-ItemProperty -Path "$($entry[0])" -Name "$($entry[1])" -ErrorAction Silent
        Write-Host -f red "ERROR: Unable to modify: $($entry[0])\$($entry[1])"
    }
}


Write-Output "Disable Edge desktop shortcut on new profiles"
New-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer -Name DisableEdgeDesktopShortcutCreation -PropertyType DWORD -Value 1

