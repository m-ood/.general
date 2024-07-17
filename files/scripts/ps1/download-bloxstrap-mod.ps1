cd $env:localappdata\bloxstrap;

([System.Net.WebClient]::new()).downloadstring('https://raw.githubusercontent.com/m-ood/.general/main/files/scripts/ps1/flag-override.ps1')>flag-override.ps1;

$s=@{};foreach($a in ((gc -Raw -Path .\settings.json)|ConvertFrom-Json).PSObject.Properties){$s[$a.name]=$a.value};
for ($i=0; $i -lt $s.CustomIntegrations.Length; $i++) {if ($s.CustomIntegrations[$i].name -eq 'flag-override') {$int=1}};
if ($int -eq $null){$s.CustomIntegrations+=(@{Name='flag-override';Location='cmd.exe';LaunchArgs='/c start /min "" powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -command "& sp -path ''Registry::HKCR\roblox-player\shell\open\command'' -name ''(Default)'' -value (''cmd.exe /c start /min \""\"" powershell.exe  -WindowStyle Hidden -ExecutionPolicy Bypass -file \""'' + $env:localappdata + ''\bloxstrap\flag-override.ps1\"" \""%1\""'') " ';AutoClose=$false});};
($s|convertto-json)>.\settings.json
if ((test-path -path '.\fflags.jsonc') -eq $false) {(gc -Raw -Path .\Modifications\ClientSettings\ClientAppSettings.json)>.\fflags.jsonc;};
sp -path 'Registry::HKCR\roblox-player\shell\open\command' -name '(Default)' -value ('cmd.exe /c start /min "" powershell.exe  -WindowStyle Hidden -ExecutionPolicy Bypass -file "' + $env:localappdata + '\bloxstrap\flag-override.ps1" "%1"')




#cmd.exe /c start /min "" powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -file "C:\Users\memaz\AppData\Local\bloxstrap\flag-override.ps1" "%1"


