## ECS task execution role data
data "aws_iam_policy_document" "ecs_service_role" {

  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# ECS task execution role
resource "aws_iam_role" "ecs-instance-role" {
  name               = "ecs-instance-role-test-web"
  assume_role_policy = data.aws_iam_policy_document.ecs_service_role.json
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  role       = aws_iam_role.ecs-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_service_role" {
  role = aws_iam_role.ecs-instance-role.name
}