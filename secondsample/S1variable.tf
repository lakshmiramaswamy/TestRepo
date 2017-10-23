variable "Abbive_vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "A list of public subnets cidr inside the VPC."
  default     = ["10.0.1.0/24","10.0.2.0/24"]

}

variable "private_subnet" {
  description = "A list of public subnets cidr inside the VPC."
  default     = ["10.0.3.0/24","10.0.4.0/24"]

}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = "aws-terraform"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {
          "CreatedBy" = "Shobha" 
          "Project" = "Abbive sample"
  }
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {
        "CreatedBy" = "Sho"
        "Project" = "Abbive sample"
  }
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  default     = {
        "CreatedBy" = "Sho"
        "Project" = "Abbive sample"
  }
}

variable "access_key" {
  description = "AWS access key"
  default = "AKIAJI4INTOM6BXDWR3A"
}

variable "secret_key" {
  description = "AWS secret access key"
  default = "WfUf+j2fPB9VGg1qsWJxSMS0FUxnQrW+tSurofSC"
}

variable "region"     {
  description = "AWS region to host your network"
  default = "ap-northeast-2"
}
