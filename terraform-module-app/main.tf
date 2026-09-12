#dev infra

module "dev-infra"{
    source="./infra-app"
    env="dev"
    bucket_name="clouddevopslab-infra-app"
    instant_count=1
    instant_type="t2.micro"
    ec2_ami_id="ami-01a00762f46d584a1" #linux
    hash_key="studentID"
}

#prd infra

module "prd-infra"{
    source="./infra-app"
    env="prd"
    bucket_name="clouddevopslab-infra-app"
    instant_count=2
    instant_type="t2.medium"
    ec2_ami_id="ami-01a00762f46d584a1" #linux
    hash_key="studentID"
}

#stg infra

module "stg-infra"{
    source="./infra-app"
    env="stg"
    bucket_name="clouddevopslab-infra-app"
    instant_count=1
    instant_type="t2.small"
    ec2_ami_id="ami-01a00762f46d584a1" #linux
    hash_key="studentID"
}