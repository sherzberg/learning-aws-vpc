
resource "aws_instance" "web" {
    ami = "ami-1ccae774"
    instance_type = "m1.small"
    subnet_id = "${aws_subnet.public_subnet.id}"
    key_name = "${aws_key_pair.dev.key_name}"

    tags {
        Name = "web"
    }
}

