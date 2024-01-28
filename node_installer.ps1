# proveri da li je nodejs instaliran ako nije instaliraj ga
if (!(Get-Command "node" -ErrorAction SilentlyContinue)) {
    # Define the download URL and the destination
    $nodeJsUrl = "https://nodejs.org/dist/v21.6.1/node-v21.6.1-x64.msi"
    $destination = "$env:TEMP\nodejs_installer.msi"

    Write-Host "=== Download NodeJs ==="
    # Download NodeJS installer
    Invoke-WebRequest -Uri $nodeJsUrl -OutFile $destination
    
    Write-Host "=== Install NodeJS ==="
    # Install NodeJS silently
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $env:TEMP\nodejs_installer.msi /qn" -Wait    
} else {
    Write-Host "=== NodeJs installer already installed ... skip ==="
}

if (!(Get-Command "pm2" -ErrorAction SilentlyContinue)) {
    Write-Host "Install pm2 ..."
    npm i pm2 -g    
} else {
    Write-Host "=== PM2 already exists ... skip ==="
}

$pm2InstallerUrl = "https://github.com/jessety/pm2-installer/archive/main.zip"
$pm2InstallerZipDestination = "pm2Installer.zip"
$pm2InstallerUnziped = "pm2Installer"

if(!(Test-Path -Path $pm2InstallerZipDestination)) {
    # Donwload pm2-installer
    Write-Host "=== Download pm2 installer ==="
    Invoke-WebRequest -Uri $pm2InstallerUrl -OutFile $pm2InstallerZipDestination

    # Donwload pm2-installer
    Write-Host "=== Unzip pm2 installer ==="
    Expand-Archive -Path $pm2InstallerZipDestination -DestinationPath ".\"

    # uzmi poslednji element koji je sleteo
    $pm2ZipArhiva = Get-ChildItem -Directory | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    # promeni mu u odgovarajuce ime
    Rename-Item -Path $pm2ZipArhiva.Name -NewName $pm2InstallerUnziped
    # ukloni zip arhivu 
    Remove-Item -Path $pm2InstallerZipDestination
    Remove-Item -Path $pm2ZipArhiva -Recurse -Force
} else {
    Write-Host "=== PM2 installer already exists ... skip ==="
}

Set-Location .\pm2Installer

npm run configure
npm run configure-policy
npm run setup

Set-Location ..\

Write-Host "=== Configuration finished ==="