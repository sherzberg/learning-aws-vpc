
resource "aws_instance" "instance_01" {
    ami = "${lookup(var.amis, var.region)}"
    instance_type = "${lookup(var.instance_type, var.region)}"
    subnet_id = "${aws_subnet.private.id}"
    key_name = "${aws_key_pair.dev.key_name}"
    vpc_security_group_ids = ["${aws_security_group.instance.id}"]

    tags {
        Name = "instance_01"
        Group = "dev"
    }
}

resource "aws_instance" "nat" {
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

resource "aws_eip" "nat" {
    vpc = true
    instance = "${aws_instance.nat.id}"
}

resource "aws_instance" "vpn" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${lookup(var.instance_type, var.region)}"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.vpn.id}"]
  key_name = "${aws_key_pair.dev.key_name}"
  source_dest_check = false

  tags = {
    Name = "vpn"
  }

  connection {
    user = "ubuntu"
    key_file = "~/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      # "sudo iptables -t nat -A POSTROUTING -j MASQUERADE",
      # "echo 1 | sudo tee /proc/sys/net/ipv4/conf/all/forwarding > /dev/null",
      /* Install docker */
      "curl -sSL https://get.docker.com/ubuntu/ | sudo sh",
      /* Initialize open vpn data container */
      "sudo mkdir -p /etc/openvpn",
      "sudo docker run --name ovpn-data -v /etc/openvpn busybox",
      /* Generate OpenVPN server config */
      "sudo docker run --volumes-from ovpn-data --rm gosuri/openvpn ovpn_genconfig -p ${var.vpc_cidr} -u udp://${aws_instance.vpn.public_ip}"
    ]
  }
}

resource "aws_eip" "vpn" {
    vpc = true
    instance = "${aws_instance.vpn.id}"
}

