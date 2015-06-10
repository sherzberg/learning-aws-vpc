
output "web_01_eip" {
    value = "${aws_eip.eip_01.public_ip}"
}

output "nat_01_eip" {
    value = "${aws_eip.nat_01.public_ip}"
}

output "db_01_ip" {
    value = "${aws_instance.db_01.private_ip}"
}

