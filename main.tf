#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-7e50c21a
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-bulldog
#


#   access_key = "${var.access_key}"
#   secret_key = "${var.secret_key}"

module "example" {
   source = "./example-module"
   command = "echo 'Hello World 222'"
}


   
variable aws_access_key  {
  type = "string"
}

variable aws_secret_key  {
  type = "string"
}

variable aws_region {
  default = "us-west-1"

}

variable "num_vars" {
   default = "3" // comment
}


provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
#  access_key = "AKIAIXEQSINCE53KLOGQ"
#  secret_key = "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"
#  region     = "us-west-1"
}

resource "aws_instance" "web" {
  count = "${var.num_vars}"
  ami                    = "ami-30217250"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-7e50c21a"
  vpc_security_group_ids = ["sg-29ef374e"]

  tags {
    Identity       = "autodesk-bulldog"
    "Name"         = "capacity_app3"
    "adsk:family"  = "Capacity"
    "adsk:product" = "Capacity"
    "adsk:role"    = "app"
    "adsk:service" = "Capacity"
    "role" = "app"
    "xyz" = "XYZ"
    Name2= "web ${count.index} / ${var.num_vars}"
  }
}

output "public_dns" {
   value = ["${aws_instance.web.*.public_dns}"]
   #value = "${aws_instance.web.public_dns}"

}
