#   Description:
# This script will use Windows package manager to bootstrap Chocolatey and
# install a list of packages. Script will also install Sysinternals Utilities
# into your default drive's root directory.

# should i use --NotSilent so that i can check the checkboxes myself?
# i perfer to set the options during installation and dont mind clicking Next
# i also dont want to have desktop shortcuts created etc

$packages = @(
    #"chocolateygui"
    "notepadplusplus.install"
    "7zip.install"
    "vlc"             # or mpc-hc or mpc-be, with madvr? or mpv
    "sumatrapdf.install"
    "keepass"
    "firefox"
    "thunderbird"
    "skype"          # chocolatey breaks skype internal update, so dont use that, just wait for the chocolatey upgrade
    "googlechrome"   # extensions adblockplus, builtwith, stylish/stylus, vimium or mouselessbrowsing
    "git"
    "autohotkey.install"
    "sharex"
    "filezilla"
    "sysinternals"   # this script also downloads it below
    "obs-studio"
    "sandboxie"
    "gpg4win-vanilla"
    "putty"
    #"shotcut"        # video editor
    #"vim"           # chocolatey is using the cream installer which i dont like
    #"virtualbox"
    #"plexmediaserver"  # or emby?
    #"winmerge"
    #"teamviewer"     # no don't want to install this, just dl myself and use the runonce option
    #"f.lux"          # no just use win10 night light?
    #"utorrent"       # no - we install this inside sandboxie

    # non chocolatey pkgs that i still need
    # hp drivers
    # epson drivers
    # safejumper VPN from proxy.sh
)

echo "Setting up Chocolatey software package manager"
Get-PackageProvider -Name chocolatey -Force

echo "Setting up Full Chocolatey Install"
Install-Package -Name Chocolatey -Force -ProviderName chocolatey
$chocopath = (Get-Package chocolatey | ?{$_.Name -eq "chocolatey"} | Select @{N="Source";E={((($a=($_.Source -split "\\"))[0..($a.length - 2)]) -join "\"),"Tools\chocolateyInstall" -join "\"}} | Select -ExpandProperty Source)
& $chocopath "upgrade all -y"
choco install chocolatey-core.extension --force

#echo "Creating daily task to automatically upgrade Chocolatey packages"
# adapted from https://blogs.technet.microsoft.com/heyscriptingguy/2013/11/23/using-scheduled-tasks-and-scheduled-jobs-in-powershell/
#$ScheduledJob = @{
    #Name = "Chocolatey Daily Upgrade"
    #ScriptBlock = {choco upgrade all -y}
    #Trigger = New-JobTrigger -Daily -at 2am
    #ScheduledJobOption = New-ScheduledJobOption -RunElevated -MultipleInstancePolicy StopExisting -RequireNetwork
#}
#Register-ScheduledJob @ScheduledJob

echo "Installing Packages"
$packages | %{choco install $_ --NotSilent --force -y}

#echo "Installing Sysinternals Utilities to C:\Sysinternals"
#$download_uri = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
#$wc = new-object net.webclient
#$wc.DownloadFile($download_uri, "/SysinternalsSuite.zip")
#Add-Type -AssemblyName "system.io.compression.filesystem"
#[io.compression.zipfile]::ExtractToDirectory("/SysinternalsSuite.zip", "/Sysinternals")
#echo "Removing zipfile"
#rm "/SysinternalsSuite.zip"
