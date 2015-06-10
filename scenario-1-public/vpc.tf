
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"

    tags {
        Name = "main"
        Group = "dev"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "main"
        Group = "dev"
    }
}

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    depends_on = ["aws_internet_gateway.gw"]

    tags {
        Name = "public"
        Group = "dev"
    }
}

resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "public_routing_table"
        Group = "dev"
    }
}

resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

