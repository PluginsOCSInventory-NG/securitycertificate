Set-Location cert:\LocalMachine

$store = Get-ChildItem -Recurse cert: | select *

foreach ($store in $store){
	if($store.FriendlyName -ne $null){
		$xml += "<SECURITYCERTIFICATE>`n"
		$xml += "<NAME>"+$store.FriendlyName+"</NAME>`n"
		$xml += "<AUTORITY>"+$store.Issuer+"</AUTORITY>`n"
		$xml += "<DATESTART>"+$store.NotBefore+"</DATESTART>`n"
		$xml += "<EXPIRATION>"+$store.NotAfter+"</EXPIRATION>`n"
		$xml += "</SECURITYCERTIFICATE>`n"
	}
}

echo $xml
