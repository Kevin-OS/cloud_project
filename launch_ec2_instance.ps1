"`n"
echo "*****************Creating new key pair*****************`n"
$keypairname = read-host -Prompt 'Please enter a name for a new key pair: '
$keypair = New-EC2KeyPair -KeyName $keypairname
$keypair.KeyMaterial | Out-File -Encoding ascii C:\Users\$env:USERNAME\Desktop\$keypairname.pem
echo "`n*****************Key pair $keypairname created successfully*******************`n"

echo "`n*****************Creating new security group******************`n"
$securitygroup = read-host -Prompt 'Please enter a name for a new security group: '
$description = Read-Host -Prompt 'Please enter a description: '
New-EC2SecurityGroup -GroupName $securitygroup -Description $description

$cidrBlocks = New-Object 'collections.generic.list[string]' 
$cidrBlocks.add("0.0.0.0/0") 
$ipPermissions = New-Object Amazon.EC2.Model.IpPermission 
$ipPermissions.IpProtocol = "tcp" 
$ipPermissions.FromPort = 22 
$ipPermissions.ToPort = 22 
$ipPermissions.IpRanges = $cidrBlocks 
Grant-EC2SecurityGroupIngress -GroupName $securitygroup -IpPermissions $ipPermissions

$cidrBlocks = New-Object 'collections.generic.list[string]' 
$cidrBlocks.add("0.0.0.0/0") 
$ipPermissions = New-Object Amazon.EC2.Model.IpPermission 
$ipPermissions.IpProtocol = "tcp" 
$ipPermissions.FromPort = 3389 
$ipPermissions.ToPort = 3389 
$ipPermissions.IpRanges = $cidrBlocks 
Grant-EC2SecurityGroupIngress -GroupName $securitygroup -IpPermissions $ipPermissions
"`n***************Created security group successfully*****************"

echo "`nPlease enter ImageId for Amazon Linux or Windows Server 2016 instance"
echo "Amazon Linux: ami-4836a428"
echo "Windows Server 2016: ami-94e26af4"
$imageid = Read-Host -prompt 'Image Id: '
New-EC2Instance -ImageId $imageid -MinCount 1 -MaxCount 1 -KeyName $keypairname -SecurityGroups $securitygroup -InstanceType t2.micro
"`n***************Launched Instance********************"