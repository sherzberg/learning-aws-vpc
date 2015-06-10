
resource "aws_instance" "web" {
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "t1.micro"
    subnet_id = "${aws_subnet.public.id}"
    key_name = "${aws_key_pair.dev.key_name}"
    vpc_security_group_ids = ["${aws_security_group.web.id}"]

    tags {
        Name = "web"
        Group = "dev"
    }
}

