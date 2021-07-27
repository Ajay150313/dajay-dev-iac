# security group
resource "aws_security_group" "ssh-allowed" {

    name = "seg-dev-ssh"
    vpc_id = "${aws_vpc.dajay-dev-vpc.id}"

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        
        // This means, all ip address are allowed to ssh !
        // Do not do it in the production. Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }

    //If you do not add this rule, you can not reach the NGIX
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    tags = {
        Name = "ssh-allowed"
    }
}

resource "aws_security_group" "rds_sg" {
    name = "seg-dev-rds"
    vpc_id = "${aws_vpc.dajay-dev-vpc.id}"

    ingress {
        protocol        = "tcp"
        from_port       = 3306
        to_port         = 3306
        cidr_blocks     = ["10.0.0.32/27"]
        # security_groups = "${[aws_security_group.ecs_sg.id]}"
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = -1
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ec2-sg" {
  name        = "allow-all-ec2"
  description = "allow all"
  vpc_id      = aws_vpc.dajay-dev-vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all-ec2"
  }
}


# resource "aws_security_group" "alb-sg" {
#   name        = "seg-myapp-load-balancer-security-group"
#   description = "controls access to the ALB"
#   vpc_id = "${aws_vpc.dajay-dev-vpc.id}"

#   ingress {
#     protocol    = "tcp"
#     from_port   = var.app_port
#     to_port     = var.app_port
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # this security group for ecs - Traffic to the ECS cluster should only come from the ALB
# resource "aws_security_group" "ecs_sg" {
#   name        = "testapp-ecs-tasks-security-group"
#   description = "allow inbound access from the ALB only"
#   vpc_id = "${aws_vpc.dajay-dev-vpc.id}"

#   ingress {
#     protocol        = "tcp"
#     from_port       = var.app_port
#     to_port         = var.app_port
#     security_groups = "${[aws_security_group.alb-sg.id]}"
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }