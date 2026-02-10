$ISO = 'C:\Users\User\Documents\Windows.iso'
$Drive = (Get-DiskImage -ImagePath $ISO | Mount-DiskImage | Get-Volume).DriveLetter + ':'

New-Item Sources -ItemType Directory | Out-Null
Copy-Item -Path "$Drive\*" -Destination Sources -Recurse -Force

Dismount-DiskImage -ImagePath $ISO | Out-Null

irm https://github.com/GabyNun/autounattend/raw/main/autounattend.xml -Out Sources\autounattend.xml
irm https://github.com/GabyNun/autounattend/raw/main/oscdimg.exe -Out oscdimg.exe

.\oscdimg.exe "-bSources\efi\microsoft\boot\efisys.bin" -u2 Sources autounattend.iso

Remove-Item Sources, oscdimg.exe -Recurse -Force
