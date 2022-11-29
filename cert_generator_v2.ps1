#Cert-V0.2
#Created by Tekfly

#RUN AS ADMIN
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}
########
#$name_certificate = Read-Host "Please give a name to the Certificate."
#Custom_password
$confirmation = Read-Host "Do you want insert a custom password? (y/n) "
if ($confirmation -eq 'y') {
    $Password = Read-Host -Prompt 'Input the Password'
}
if ($confirmation -eq 'n') {
    $Password = -join ((65..90) + (97..122) | Get-Random -Count 16 | ForEach-Object {[char]$_})
}

$years = Read-Host "How many Years until expire? (min 1 / max 4)"
$comon_name = hostname

$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=$comon_name" `
-KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 4096 `
-CertStoreLocation "cert:\LocalMachine\My" `
-KeyUsageProperty Sign `
-KeyUsage CertSign `
-NotAfter (Get-Date).AddYears($years)
#Create a secure string password for the certificate
$mypwd = ConvertTo-SecureString -String "$Password" -Force -AsPlainText
#Export the certificate from the LocalMachine personal store to a file `mypfx.pfx`
Get-ChildItem -Path "cert:\LocalMachine\my\$($cert.Thumbprint)" | Export-PfxCertificate `
-FilePath new_certificate.pfx `
-Password $mypwd `
-CryptoAlgorithmOption TripleDES_SHA1
#Remove the certificate from the LocalMachine personal store
Get-ChildItem "Cert:\LocalMachine\My\$($cert.Thumbprint)" | Remove-Item
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=$comon_name" `
-KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 4096 `
-CertStoreLocation "cert:\LocalMachine\My" `
-KeyUsageProperty Sign `
-KeyUsage CertSign `
-NotAfter (Get-Date).AddYears(2)
$mypwd = ConvertTo-SecureString -String "$Password" -Force -AsPlainText
Get-ChildItem -Path "cert:\LocalMachine\my\$($cert.Thumbprint)" | Export-PfxCertificate `
-FilePath new_certificate.pfx `
-Password $mypwd `
-CryptoAlgorithmOption TripleDES_SHA1
Get-ChildItem "Cert:\LocalMachine\My\$($cert.Thumbprint)" | Remove-Item
Write-Output "Certificate Password is: " $Password