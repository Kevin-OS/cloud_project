echo "*****************Creating new IAM Group*****************`n"
$groupname = read-host -Prompt 'Please enter a name for an IAM group: '
New-IAMGroup -GroupName $groupname
echo "*****************New IAM Group Created*****************`n"

$policyDocument = @"
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "NotAction": [
                "iam:DeleteSSHPublicKey",
                "iam:GetSSHPublicKey",
                "iam:ListSSHPublicKeys",
                "iam:UpdateSSHPublicKey",
                "iam:UploadSSHPublicKey",
                "iam:CreateServiceSpecificCredential",
                "iam:ListServiceSpecificCredentials",
                "iam:UpdateServiceSpecificCredential",
                "iam:DeleteServiceSpecificCredential",
                "iam:ResetServiceSpecificCredential",
                "iam:GenerateCredentialReport",
                "iam:GenerateServiceLastAccessedDetails",
                "iam:Get*",
                "iam:List*"
                ],
      "Resource": "*"
    }
  ]
}
"@

$timestamp = get-date -UFormat "%d-%m-%Y"
Write-IAMGroupPolicy -GroupName $groupname -PolicyName "PowerUserAccess-$groupname-$timestamp" -PolicyDocument $policyDocument

echo "*****************Creating new IAM User*****************`n"

$iamuser = read-host -Prompt 'Please enter a name for an IAM user: '
New-IAMUser -UserName $iamuser

New-IAMLoginProfile -UserName $iamuser -Password "itt12345" -PasswordResetRequired $true

echo "*****************New IAM User Created*****************`n"

Add-IAMUserToGroup -UserName $iamuser -GroupName $groupname
echo "*****************$iamuser added to $groupname******************"