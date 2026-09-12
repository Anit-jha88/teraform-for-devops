variable "env" {

    description ="this is my  env for infra"
    type=string
}

variable "bucket_name" {

    description ="this is my bucket_name for my infra"
    type=string
}

variable "instant_count" {

    description ="this is the no of ec2 for my infra"
    type=number
}

variable "instant_type" {

    description ="this is the no of instant_type for ec2 my infra"
    type=string
}

variable "ec2_ami_id" {

    description ="this is the no of ec2_ami_id for ec2 my infra"
    type=string
}

variable "hash_key" {

    description ="this is the no of hash_key for dynamodb my infra"
    type=string
}