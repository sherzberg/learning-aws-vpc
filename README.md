learning-aws-vpc
================

This repo is used to explore AWS VPC using [Terraform](https://www.terraform.io/)

We will explore a few different `AWS scenarios` from
[here](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Scenarios.html).

Scenario 1
-----------------

* `scenario-1-public`

This subfolder is a replica of the AWS docs Scenario 1. This terraform config will
create a simple VPC with a single instance in a public subnet.

Setup
-----

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
$ cd public-private
$ terraform plan
$ terraform apply
```

TODO
----

- [ ] Scenario 2
