$host.ui.rawui.BackgroundColor="Black";cd $PSScriptRoot;

(ls '.\mods').Name|%{&".\mods\$($_)" "$($args[0])"}
& '.\BloxStrap.exe' -player "$($args[0])"
$($args[0])>.\Logs\uri.txt

echo finished

return
