learning-aws-vpc
================

This repo is used to explore AWS VPC using [Terraform](https://www.terraform.io/)

public-private
--------------

This subfolder shows how to build a simple VPC with a public and private
subnet.

Setup
-----

First, need to export `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

Next, create a `public-private/variables.tf` file the following as the contents:

```
variable "region" {
    default = "us-east-1"
}

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

- [ ] BUG: `public-private` won't route traffic through the route table + internet gateway
- [ ] implement more complex multi-az vpc
