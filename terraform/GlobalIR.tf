resource "aws_iam_role" "GlobalIncidentResponse" {
  name                = "GlobalIncidentResponse"
  managed_policy_arns = [data.aws_iam_policy.ReadOnlyAccess.arn]
  assume_role_policy  = data.aws_iam_policy_document.IRTrustPolicy.json
  inline_policy {
    name   = "BlendIncidentResponse"
    policy = data.aws_iam_policy_document.BlendIncidentResponse.json
  }
}

data "aws_iam_policy" "ReadOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

data "aws_iam_policy_document" "BlendIncidentResponse" {
  statement {
    effect = "Allow"
    actions = [
      "iam:DeleteAccessKey",
      "iam:UpdateAccessKey",
      "iam:DeleteVirtualMFADevice",
      "iam:DeactivateMFADevice",
      "ec2:RebootInstances",
      "ec2:CopySnapshot",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot",
      "ec2:ImportSnapshot",
      "ec2:StartInstances",
      "ec2:TerminateInstances",
      "ec2:StopInstances",
      "trustedadvisor:*"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "IRTrustPolicy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    sid     = "IncidentResponseTrustRelationPolicy"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::896107675552:user/asingh",
        "arn:aws:iam::896107675552:user/asingh-2",
        "arn:aws:iam::896107675552:user/asingh-admin"
      ]
    }
  }
}
