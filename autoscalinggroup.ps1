$instanceid = Read-Host -prompt 'Enter Instance ID for Launch Configuration: '
New-ASAutoScalingGroup -AutoScalingGroupName TestAutoScalingGroup -InstanceId $instanceid -MinSize 1 -MaxSize 3 -DesiredCapacity 2 -AvailabilityZone us-west-2b
Write-ASScalingPolicy -AutoScalingGroupName TestAutoScalingGroup -PolicyName ScaleDown -ScalingAdjustment -1 -AdjustmentType ChangeInCapacity
Write-ASScalingPolicy -AutoScalingGroupName TestAutoScalingGroup -PolicyName ScaleUp -ScalingAdjustment 1 -AdjustmentType ChangeInCapacity
