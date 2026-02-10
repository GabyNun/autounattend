$ISO = 'C:\Users\User\Documents\Windows.iso'

Mount-DiskImage -ImagePath $ISO | Out-Null

$Drive = (Get-DiskImage -ImagePath $ISO | Get-Volume).DriveLetter + ':'

New-Item Sources -ItemType Directory -Force | Out-Null
Copy-Item -Path "$Drive\*" -Destination Sources -Recurse -Force

Dismount-DiskImage -ImagePath $ISO | Out-Null

irm https://gist.github.com/GabiNun/81da0681f2382c90332ca771eb267500/raw/autounattend.xml -Out "Sources\autounattend.xml"
irm https://github.com/ChrisTitusTech/winutil/raw/main/releases/oscdimg.exe -Out oscdimg.exe

.\oscdimg.exe "-bSources\efi\microsoft\boot\efisys.bin" -u2 Sources autounattend.iso

Remove-Item Sources -Recurse -Force
Remove-Item oscdimg.exe
