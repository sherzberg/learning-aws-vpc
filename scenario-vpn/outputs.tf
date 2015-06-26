
output "instance_01_ip" {
    value = "${aws_instance.instance_01.private_ip}"
}

output "vpn_eip" {
    value = "${aws_eip.vpn.public_ip}"
}
