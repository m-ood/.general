cd $env:localappdata\bloxstrap;
function format-json([Parameter(Mandatory, ValueFromPipeline)][String] $json) {$indent = 0;($json -Split "`n" | % {if ($_ -match '[\}\]]\s*,?\s*$') {$indent--};$line = ('  ' * $indent) + $($_.TrimStart() -replace '":  (["{[])', '": $1' -replace ':  ', ': ');if ($_ -match '[\{\[]\s*$') {$indent++};$line}) -Join "`n"};

([System.Net.WebClient]::new()).downloadstring('https://raw.githubusercontent.com/m-ood/.general/main/files/scripts/ps1/strapon.ps1')>strapon.ps1;

$s=@{};foreach($a in ((gc -Raw -Path .\settings.json)|ConvertFrom-Json).PSObject.Properties){$s[$a.name]=$a.value};
for ($i=0; $i -lt $s.CustomIntegrations.Length; $i++) {if ($s.CustomIntegrations[$i].name -eq 'flag-override') {$int=1}};
if ($int -eq $null){$s.CustomIntegrations+=(@{Name='flag-override';Location='cmd.exe';LaunchArgs='/c start /min "" powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -command "& sp -path ''Registry::HKCR\roblox-player\shell\open\command'' -name ''(Default)'' -value (''cmd.exe /c start /min \""\"" powershell.exe  -WindowStyle Hidden -ExecutionPolicy Bypass -file \""'' + $env:localappdata + ''\bloxstrap\strapon.ps1\"" \""%1\""'') " ';AutoClose=$false});};
$s.ConfirmLaunches=$false
($s|convertto-json)>.\settings.json
if ((test-path -path '.\config.json') -eq $false) {(@{FflagsOverrideLocation='.\fflags.jsonc'}|convertto-json|format-json)>.\config.json;};
if ((test-path -path '.\fflags.jsonc') -eq $false) {(gc -Raw -Path .\Modifications\ClientSettings\ClientAppSettings.json)>.\fflags.jsonc;};
sp -path 'Registry::HKCR\roblox-player\shell\open\command' -name '(Default)' -value ('cmd.exe /c start /min "" powershell.exe  -WindowStyle Hidden -ExecutionPolicy Bypass -file "' + $env:localappdata + '\bloxstrap\strapon.ps1" "%1"')

#$ default mods
if ((test-path -path '.\mods') -eq $false) {
    ([System.Net.WebClient]::new()).downloadstring('https://raw.githubusercontent.com/m-ood/.general/main/files/scripts/ps1/jsonc-fflags.ps1')>.\mods\jsonc-fflags.ps1;
    ([System.Net.WebClient]::new()).downloadstring('https://raw.githubusercontent.com/m-ood/.general/main/files/scripts/ps1/ROBLOX_singletonMutex.ps1')>.\mods\ROBLOX_singletonMutex.ps1;
}



#cmd.exe /c start /min "" powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -file "C:\Users\memaz\AppData\Local\bloxstrap\strapon.ps1" "%1"


