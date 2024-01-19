resource "aws_sns_topic" "alarm_updates" {
  name = "my-topic"
}


module "alarms" {
  source = "github.com/cisagov/instance-cw-alarms-tf-module"
  providers = {
    aws = aws
  }

  alarm_actions             = [aws_sns_topic.alarm_updates.arn]
  instance_ids              = var.ec2_id
  insufficient_data_actions = [aws_sns_topic.alarm_updates.arn]
  ok_actions                = [aws_sns_topic.alarm_updates.arn]
}