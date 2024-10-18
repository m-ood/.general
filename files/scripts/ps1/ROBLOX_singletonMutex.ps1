
start powershell -WindowStyle Hidden {if ([Threading.Mutex]::tryopenexisting('ROBLOX_singletonMutex',[ref]$null) -eq $false) {[Threading.Mutex]::new(1,'ROBLOX_singletonMutex');pause;};}
#start powershell {echo (   ([Threading.Mutex]::OpenExisting('ROBLOX_singletonMutex')).WaitOne(0,$false)  ); pause}


echo multi
return
