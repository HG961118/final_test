#백업볼트
resource "aws_backup_vault" "final-backup-vault" {
  name        = "final-backup-vault"

}

#백업플랜
resource "aws_backup_plan" "final-backup-plan" {
  name = "final-backup-plan"

  rule {
    rule_name         = "final-backup-rule"
    target_vault_name = aws_backup_vault.final-backup-vault.name
    schedule          = "cron(0 12 * * ? *)" #수정필요
  }
}

#백업설렉션 # role부분 지정해주자..
resource "aws_iam_role" "final-dlm-lifecycle-role" {
  name = "final-dlm-lifecycle-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#정책만들고 
resource "aws_iam_role_policy" "final-dlm-lifecycle" {
  name = "final-final-dlm-lifecycle-policy"
  role = aws_iam_role.final-dlm-lifecycle-role.id

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateSnapshot",
            "ec2:CreateSnapshots",
            "ec2:DeleteSnapshot",
            "ec2:DescribeInstances",
            "ec2:DescribeVolumes",
            "ec2:DescribeSnapshots"
         ],
         "Resource": "*"
      },
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateTags"
         ],
         "Resource": "arn:aws:ec2:*::snapshot/*"
      }
   ]
}
EOF
}

#정책을 iamrole에 붙인다. attach! 
resource "aws_iam_role_policy_attachment" "final-iam-role-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.final-dlm-lifecycle-role.name
}


resource "aws_dlm_lifecycle_policy" "final-dlm-policy" {
  description        = "final DLM lifecycle policy"
  execution_role_arn = aws_iam_role.final-dlm-lifecycle-role.arn
  state              = "DISABLED" #생성 또는 수정 직후 정책을 활성화할지 여부를 지정

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "oneday-snapshot"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
        times         = ["09:00"]
      }

      retain_rule {
        count = 1
      }
      tags_to_add = {
        SnapshotCreator = "DLM"
      }
      copy_tags = false
    }
    target_tags = {
      Name = "control"
    }
  }
}
  
#resource "aws_backup_selection" "final-backup-selection" {
#iam_role_arn = aws_iam_role.final-dlm-lifecycle-role.arn
#name          = "final-backup-selection"
  #plan_id       = aws_backup_plan.final-backup-plan.id
#}

