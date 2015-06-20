## learning-aws-vpc

This repo is used to explore AWS VPC using [Terraform](https://www.terraform.io/)

We will explore a few different `AWS scenarios` from
[here](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenarios.html).

### Scenario 1

* `scenario-1-public`

This subfolder is a replica of the AWS docs [Scenario 1](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenario1.html).
This terraform config will create a simple VPC with a single instance in a public subnet.

### Setup

First, need to export `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

Next, create a `scenario-1-public/override.tf` file the following as the contents:

```
resource "aws_key_pair" "dev" {
  key_name = "dev-key"
  public_key = "CHANGE ME TO THE CONTENT OF YOUR PUBLIC SSH KEY"
}
```

Now you can try it out:

```bash
$ cd scenario-1-public
$ terraform plan
$ terraform apply
...

State path: terraform.tfstate

Outputs:

  eip_01 = XX.XXX.XX.XXX
```

After some amount of time, you should get an `Ouputs` like above. You should be able
to ssh to that instance now:

```bash
$ ssh ubuntu@XX.XXX.XX.XXX
```

Scenario 2
==========

* `scenario-2-public-private`

This subfolder is a replica of the AWS docs [Scenario 2](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenario2.html).
This terraform config will create a simple VPC with an instance in a public subnect, an
instance in a private subnet and a NAT instance.

### Setup

First, need to export `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

Next, create a `scenario-2-public-private/override.tf` file the following as the contents:

```
resource "aws_key_pair" "dev" {
  key_name = "dev-key"
  public_key = "CHANGE ME TO THE CONTENT OF YOUR PUBLIC SSH KEY"
}
```

Now you can try it out:

```bash
$ cd scenario-2-public-private
$ terraform plan
$ terraform apply
...

State path: terraform.tfstate

Outputs:

  db_01_ip   = xx.XXX.xx.XXX
  nat_01_eip = yy.YYY.yy.YYY
  web_01_eip = zz.ZZZ.zz.ZZZ
```

After some amount of time, you should get an `Ouputs` like above. You should be able
to ssh to that instance now:

```bash
$ ssh ubuntu@zz.ZZZ.zz.ZZZ
```

You will NOT be able to ssh to the instance in the private subnet (db_01)

### __Notice__

Because this launches real instances, you may be charged for usage. Be sure to
run `terraform destroy` in each of the folders that you do a `terraform apply` in.

I'm not responsible for any balances you build up!

### Planned Features

 - [x] AWS Scenario 1
 - [x] AWS Scenario 2
 - [ ] Multiple instances in public and private subnets
 - [ ] Setup simple app with frontend proxy and a backend database
 - [ ] Custom ami's using Packer
 - [ ] VPN into vpc
