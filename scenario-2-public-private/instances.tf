
resource "aws_instance" "web_01" {
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${lookup(var.instance_type, var.region)}"
    subnet_id = "${aws_subnet.public.id}"
    key_name = "${aws_key_pair.dev.key_name}"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]

    tags {
        Name = "web_01"
        Group = "dev"
    }
}

resource "aws_eip" "eip_01" {
    vpc = true
    instance = "${aws_instance.web_01.id}"
}

resource "aws_instance" "db_01" {
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${lookup(var.instance_type, var.region)}"
    subnet_id = "${aws_subnet.private.id}"
    key_name = "${aws_key_pair.dev.key_name}"
    vpc_security_group_ids = ["${aws_security_group.db.id}"]

    tags {
        Name = "db_01"
        Group = "dev"
    }
}

resource "aws_instance" "nat_01" {
    ami = "ami-184dc970"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.public.id}"
    key_name = "${aws_key_pair.dev.key_name}"
    security_groups = ["${aws_security_group.nat.id}"]

    tags = {
        Name = "nat"
        Group = "dev"
    }
}

resource "aws_eip" "nat_01" {
    vpc = true
    instance = "${aws_instance.nat_01.id}"
}

