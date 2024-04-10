# Install Winget if not installed
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Downloading Winget";
    $url = "https://aka.ms/getwinget"
    $url2 = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx"
    $url3 = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
    $license = "https://github.com/microsoft/winget-cli/releases/download/v1.7.10861/30fe89a9836a4cfbbd3fedce72a58680_License1.xml"
    $licenseOut = "C:\30fe89a9836a4cfbbd3fedce72a58680_License1.xml"
    $output = "C:\winget.msixbundle"
    $output2 = "C:\ui.appx"
    $output3 = "C:\VCLibs.appx"

    # Download the files
    Invoke-WebRequest -Uri $license -OutFile $licenseOut
    Invoke-WebRequest -Uri $url -OutFile $output
    Invoke-WebRequest -Uri $url2 -OutFile $output2
    Invoke-WebRequest -Uri $url3 -OutFile $output3

    # Install the applications
    Write-Host "Installing Winget"
    Add-AppxPackage -Path $output3
    Add-AppxPackage -Path $output2
    Add-AppxProvisionedPackage -Online -PackagePath $output -LicensePath $licenseOut -Verbose

    # Remove Temp file
    Remove-Item $output
    Remove-Item $output2
    Remove-Item $output3
    Write-Host "Install Finished"
}

# Wait for setup
Start-Sleep -Seconds 1.5

Write-Host "Installing Programms";

$Apps = @(
    # Exapel of Apps
    "Microsoft.WindowsTerminal",
    "PuTTY.PuTTY"
)
foreach ($App in $Apps) {
    winget install --id="$App" -e;
}

Write-Host "Installing Programms Finished";

Read-Host -Prompt "Press any key to continue"