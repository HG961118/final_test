#internet_gateway
resource "aws_internet_gateway" "final-igw" {
    vpc_id = aws_vpc.final-vpc.id

    tags = {
        Name = "final-igw"
    }
}

#Elastic_IP 
resource "aws_eip" "final-nip" {
    vpc = true

    tags = {
        Name = "final-nip"
    }
}


#NAT_gateway
resource "aws_nat_gateway" "final-ngw" {
    allocation_id = aws_eip.final-nip.id
    subnet_id = aws_subnet.final-sub-pub-a.id

    tags = {
        Name = "final-ngw"
    }
}

#IGW - PUBLIC 
resource "aws_route_table" "final-rt-pub" {
    vpc_id = aws_vpc.final-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.final-igw.id
    }

        tags = {
            Name = "final-rt-pub"
        }
    
}

#PUBLIC ROUTE TABLE을 만들어서 PUBLIC SUBNET에 연결
resource "aws_route_table_association" "final-rtass-pub-a" {
    subnet_id = aws_subnet.final-sub-pub-a.id
    route_table_id = aws_route_table.final-rt-pub.id
}

resource "aws_route_table_association" "final-rtass-pub-c" {
    subnet_id = aws_subnet.final-sub-pub-c.id
    route_table_id = aws_route_table.final-rt-pub.id
}

#PRIVATE WEB을 NAT GATEWAY에 연결
resource "aws_route_table" "final-rt-pri-webwas" {
    vpc_id = aws_vpc.final-vpc.id

    tags = {
        Name = "final-rt-pri-web"
    }
}

resource "aws_route" "final-pri-webwas" {
    route_table_id = aws_route_table.final-rt-pri-webwas.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.final-ngw.id
}


#PRIVATE ROUTE TABLE - PRIVATE WEB, WAS SUBNET
resource "aws_route_table_association" "final-rtass-pri-a-web" {
    subnet_id = aws_subnet.final-sub-pri-a-web.id
    route_table_id = aws_route_table.final-rt-pri-webwas.id
}

resource "aws_route_table_association" "final-rtass-pri-c-web" {
    subnet_id = aws_subnet.final-sub-pri-c-web.id
    route_table_id = aws_route_table.final-rt-pri-webwas.id
}

resource "aws_route_table_association" "final-rt-pri-a-was" {
    subnet_id = aws_subnet.final-sub-pri-a-was.id
    route_table_id = aws_route_table.final-rt-pri-webwas.id
}

resource "aws_route_table_association" "final-rt-pri-c-was" {
    subnet_id = aws_subnet.final-sub-pri-c-was.id
    route_table_id = aws_route_table.final-rt-pri-webwas.id
}
