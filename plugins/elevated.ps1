function pshazz:elevated:init {
	# https://stackoverflow.com/questions/31341998/ternary-operator-in-powershell
	$elevated = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")

	$global:pshazz.elevated = @{
		elevated    = $elevated;
		prompt_char = if ($elevated) { "#" } else { "$" };
		user        = if ($elevated) { "root" } else { $env:username };
	}
}

function global:pshazz:elevated:prompt {
	$vars = $global:pshazz.prompt_vars
	$vars.elevated = $global:pshazz.elevated.prompt_char
	$vars.elevated_user = $global:pshazz.elevated.user
}
