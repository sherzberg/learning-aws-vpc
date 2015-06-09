
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags {
        Name = "main"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"

    tags {
        Name = "public"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.2.0/24"

    tags {
        Name = "private"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "main"
    }
}

resource "aws_route_table" "rt" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "public_routing_table"
    }
}

