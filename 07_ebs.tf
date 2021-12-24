resource "aws_ebs_volume" "final-ebs" {
    availability_zone   = "ap-northeast-2c"
    size                = 40

    tags = {
        Name = "final-ebs"
    }
}

resource "aws_volume_attachment" "final-ebs-att" {
    device_name = "/dev/sdh"
    volume_id   = aws_ebs_volume.final-ebs.id 
    instance_id = aws_instance.final-ec2-pub-control.id
}
