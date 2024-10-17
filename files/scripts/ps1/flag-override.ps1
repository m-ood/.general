&{$host.ui.rawui.BackgroundColor="Black";clear;};cd $PSScriptRoot;


function k($j){$h=@{};foreach($a in ($j|ConvertFrom-Json).PSObject.Properties){$h[$a.name]=$a.value};return $h};

function format-json([Parameter(Mandatory, ValueFromPipeline)][String] $json) {$indent = 0;($json -Split "`n" | % {if ($_ -match '[\}\]]\s*,?\s*$') {$indent--};$line = ('  ' * $indent) + $($_.TrimStart() -replace '":  (["{[])', '": $1' -replace ':  ', ': ');if ($_ -match '[\{\[]\s*$') {$indent++};$line}) -Join "`n"};



if ((test-path -path '.\config.json') -eq $true){$s=(k(gc -Raw -Path .\config.json))} else {$s=@{}};
if (($s.FflagsOverrideLocation -eq $null) -or ((test-path -path $s.FflagsOverrideLocation) -eq $false)){$s.FflagsOverrideLocation=".\fflags.jsonc";
($s|convertto-json|format-json)>.\config.json;};

if ((test-path -path $s.FflagsOverrideLocation) -eq $true) {
    $n=k((gc -Raw -Path $s.FflagsOverrideLocation)-replace'(?m)(?<=^([^"]|"[^"]*")*)//.*'-replace'(?ms)/\*.*?\*/');
    ($n|convertto-json|format-json)>.\Modifications\ClientSettings\ClientAppSettings.json;
};
& '.\BloxStrap.exe' "-player " "$($args[0])"

