resource "aws_instance" "private_ec2" {
  ami             = var.aws_ami_id
  instance_type   = "t2.micro"
  key_name        = var.tf_key_name
  subnet_id       = var.private_subnet_id
  security_groups = [var.private_sg_id]

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  tags = {
    "Name" = "PRIVATE_EC2_HOST"
    "VPC"  = "AWS_NETWORKING_EXAM_IGW"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "BASTAIN_HOST_INSTANCE_PROFILE"
  tags = {
    "Name" : "BASTAIN_HOST_INSTANCE_PROFILE"
  }
  role = aws_iam_role.s3_iam_role.name

}

resource "aws_iam_role" "s3_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_doc.json
}

data "aws_iam_policy_document" "assume_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "role_policies" {
  role   = aws_iam_role.s3_iam_role.id
  policy = data.aws_iam_policy_document.iam_policy_doc.json

}

data "aws_iam_policy_document" "iam_policy_doc" {
  statement {
    actions   = ["s3:*"]
    effect    = "Allow"
    resources = ["*"]
  }
}
