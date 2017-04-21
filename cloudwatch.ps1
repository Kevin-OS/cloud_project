$arn = Read-Host -Prompt 'Please enter arn for scale down policy: '
Write-CWMetricAlarm -AlarmName cpuAlarm1 -AlarmAction $arn -ComparisonOperator LessThanOrEqualToThreshold -Dimension @{ Name="AutoScalingGroupName"; Value="TestAutoScalingGroup" } -period 60 -EvaluationPeriod 1 -Namespace AWS/EC2 -Statistic Average -Threshold 19 -Unit Percent -MetricName CPUUtilization
$arn = Read-Host -Prompt 'Please enter arn for scale up policy: '
Write-CWMetricAlarm -AlarmName cpuAlarm2 -AlarmAction $arn -ComparisonOperator GreaterThanOrEqualToThreshold -Dimension @{ Name="AutoScalingGroupName"; Value="TestAutoScalingGroup" } -period 60 -EvaluationPeriod 1 -Namespace AWS/EC2 -Statistic Average -Threshold 20 -Unit Percent -MetricName CPUUtilization
