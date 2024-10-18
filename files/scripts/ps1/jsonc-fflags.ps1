function k($j){$h=@{};foreach($a in ($j|ConvertFrom-Json).PSObject.Properties){$h[$a.name]=$a.value};return $h};
function format-json([Parameter(Mandatory, ValueFromPipeline)][String] $json) {$indent = 0;($json -Split "`n" | % {if ($_ -match '[\}\]]\s*,?\s*$') {$indent--};$line = ('  ' * $indent) + $($_.TrimStart() -replace '":  (["{[])', '": $1' -replace ':  ', ': ');if ($_ -match '[\{\[]\s*$') {$indent++};$line}) -Join "`n"};


if ((test-path -path '.\config.json') -eq $true){$s=(k(gc -Raw -Path .\config.json))} else {$s=@{}};
if (($s.FflagsOverrideLocation -eq $null) -or ((test-path -path $s.FflagsOverrideLocation) -eq $false)){$s.FflagsOverrideLocation=".\fflags.jsonc"};
[IO.File]::WriteAllLines(($pwd).path+"\config.json",($s|convertto-json|format-json));

if ((test-path -path $s.FflagsOverrideLocation) -eq $true) {
    $n=k((gc -Raw -Path $s.FflagsOverrideLocation)-replace'(?m)(?<=^([^"]|"[^"]*")*)//.*'-replace'(?ms)/\*.*?\*/');
    [IO.File]::WriteAllLines(($pwd).path+"\Modifications\ClientSettings\ClientAppSettings.json",($n|convertto-json|format-json));
    #($n|convertto-json|format-json) | out-file -encoding "ASCII" -NoNewline -Force -FilePath .\Modifications\ClientSettings\ClientAppSettings.json #? no trailing newline
};


echo fflags
return
