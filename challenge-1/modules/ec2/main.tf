resource "aws_instance" "bastion" {

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet1
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.out_bastion_ssh]

  tags = {
    Name = "${var.entity_name}-bastion"
  }
}


resource "aws_eip" "bastion_eip" {

  instance = aws_instance.bastion.id
  vpc      = true

}

resource "aws_launch_configuration" "asg_lc" {

  name          = "${var.entity_name}-launch_configuration"
  image_id      = var.ami
  instance_type = var.instance_type
  security_groups = [
    var.out_alb_sg,
    var.out_bastion_ssh,
    var.out_ec2_sg
  ]

  associate_public_ip_address = true
  user_data                   = file("${var.user_data_file}")
}

resource "aws_autoscaling_group" "ec2_asg" {

  name                      = "${var.entity_name}-asg"
  max_size                  = var.max_asgp
  min_size                  = var.min_asgp
  launch_configuration      = aws_launch_configuration.asg_lc.name
  target_group_arns         = [aws_lb_target_group.tg_build.arn]
  force_delete              = true
  vpc_zone_identifier       = [var.private_subnet3, var.private_subnet4]
  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_lb" "alb_build" {

  name               = "${var.entity_name}-alb"
  load_balancer_type = "application"
  subnets            = [var.private_subnet3, var.private_subnet4]
  security_groups    = [var.out_alb_sg]
  tags = {
    Environment = "Application Load Balancer"
  }
}

resource "aws_lb_target_group" "tg_build" {
  name        = "${var.entity_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}


resource "aws_lb_listener" "listener_build" {

  load_balancer_arn = aws_lb.alb_build.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_build.arn
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDD0SBPDc86IP5KaDFPtfD10O3t6LPxEV0Ct1jNCBB7lwzrnCJua9qVSQzqkz4DpJOIT9h91QQ04Stnvx7EjIKXJzD+elXtuhIwVtz5Y5GQ/7dtLKo1BqDPLqW9i0vD3T5x2xp+D0MU2OwuLPEQqw87tt2icQuWJh6fYD2N7ubWQMjulPpk5qt9lmLL2orCxyyPfPG27QqVD7YpV/2Vju0/99uDn0Idp3tLD6ltvmvj1gBMRO4I8xhLlbKi1R63N44/EirgO96KLCdSzBbG+WYWRCfGoNs7XhGtSJbmyi7CtfGwoIR3fXx+hMs5DD+JmgeuCVe0WBH59gi9X3ShKinwMLcT7VqUgflMbEvPHh7Kp5aHT71Inm0w9TmMEfu8wVoWCNejUn0o9JOXZ/YQcNnkP/S8wRX54Ahm5D7o1Sco3GPjMyR8Y+Ac67q74Wmv6tpWFNgs28KV/mAqjqb7Lje6S1juII5aZzcXwFtvVKI0khfgbaSGksAQYOdogz/+1uLA3iyZ4VER6zzeHtaPgL2zCx6itOgmg1wqUro8E5u6o/rSLaWNudP7xvz3UU4aaDP9lmGycVKuOlELZN1JbTwCkh9npRQgTk6svfTQ7kSzjd6yhsZhk0LB6ddKk49Tf7nJAhWQzx33yUs5JMrmgks+kWJRyx3C+NmDrNk/SpKZ6w== jiayo@xiatylo"
}