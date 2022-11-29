
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=StrickerOrchest.paulstricker.local" `
-KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 4096 `
-CertStoreLocation "cert:\LocalMachine\My" `
-KeyUsageProperty Sign `
-KeyUsage CertSign `
-NotAfter (Get-Date).AddYears(2)
#Create a secure string password for the certificate
$mypwd = ConvertTo-SecureString -String "VlbQYezhyaOFafHg" -Force -AsPlainText
#Export the certificate from the LocalMachine personal store to a file `mypfx.pfx`
Get-ChildItem -Path "cert:\LocalMachine\my\$($cert.Thumbprint)" | Export-PfxCertificate `
-FilePath mypfx.pfx `
-Password $mypwd `
-CryptoAlgorithmOption TripleDES_SHA1
#Remove the certificate from the LocalMachine personal store
Get-ChildItem "Cert:\LocalMachine\My\$($cert.Thumbprint)" | Remove-Item
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=StrickerOrchest.paulstricker.local" `
-KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 4096 `
-CertStoreLocation "cert:\LocalMachine\My" `
-KeyUsageProperty Sign `
-KeyUsage CertSign `
-NotAfter (Get-Date).AddYears(2)
$mypwd = ConvertTo-SecureString -String "VlbQYezhyaOFafHg" -Force -AsPlainText
Get-ChildItem -Path "cert:\LocalMachine\my\$($cert.Thumbprint)" | Export-PfxCertificate `
-FilePath mypfx.pfx `
-Password $mypwd `
-CryptoAlgorithmOption TripleDES_SHA1
Get-ChildItem "Cert:\LocalMachine\My\$($cert.Thumbprint)" | Remove-Item