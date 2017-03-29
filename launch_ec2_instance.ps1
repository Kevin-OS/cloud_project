"`n"
echo "*****************Creating new key pair*****************`n"
$keypairname = read-host -Prompt 'Please enter a name for a new key pair: '
$keypair = New-EC2KeyPair -KeyName $keypairname
$keypair.KeyMaterial | Out-File -Encoding ascii C:\Users\$env:USERNAME\Desktop\$keypairname.pem
echo "`n*****************Key pair $keypairname created successfully*******************"
"`n"
