resource "aws_vpc" "final-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"
    tags = {
        Name = "final-vpc"
    }
}



#public subnet
resource "aws_subnet" "final-sub-pub-a" {
    vpc_id  = aws_vpc.final-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = true

    tags = {
        Name = "final-sub-pub-a"
    }
}

resource "aws_subnet" "final-sub-pub-c" {
    vpc_id = aws_vpc.final-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = true

    tags = {
        Name = "final-sub-pub-c"
    }
}

#private subnet -web
resource "aws_subnet" "final-sub-pri-a-web" {
    vpc_id = aws_vpc.final-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-2a"
    
    tags = {
        Name = "final-sub-pri-a-web"
    }
}

resource "aws_subnet" "final-sub-pri-c-web" {
    vpc_id = aws_vpc.final-vpc.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "ap-northeast-2c"
    
    tags = {
        Name = "final-sub-pri-c-web"
    }
}

#was
resource "aws_subnet" "final-sub-pri-a-was" {
    vpc_id = aws_vpc.final-vpc.id
    cidr_block = "10.0.30.0/24"
    availability_zone = "ap-northeast-2a"
    
    tags = {
        Name = "final-sub-pri-a-was"
    }
}

resource "aws_subnet" "final-sub-pri-c-was" {
    vpc_id = aws_vpc.final-vpc.id
    cidr_block = "10.0.40.0/24"
    availability_zone = "ap-northeast-2c"
    
    tags = {
        Name = "final-sub-pri-c-was"
    }
}

#db
resource "aws_subnet" "final-sub-pri-a-db" {
    vpc_id = aws_vpc.final-vpc.id
    cidr_block = "10.0.50.0/24"
    availability_zone = "ap-northeast-2a"
    
    tags = {
        Name = "final-sub-pri-a-db"
    }
}

resource "aws_subnet" "final-sub-pri-c-db" {
    vpc_id = aws_vpc.final-vpc.id
    cidr_block = "10.0.60.0/24"
    availability_zone = "ap-northeast-2c"
    
    tags = {
        Name = "final-sub-pri-c-db"
    }
}