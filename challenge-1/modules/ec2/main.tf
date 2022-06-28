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