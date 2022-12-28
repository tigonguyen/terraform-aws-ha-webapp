# terraform-highs-scaling-aws-web
## Description
In this project, I used Terragrunt to apply DRY strategy in Terraform scripts and resolve the problem in passing outputs between Terraform modules. 

All attached modules was built by myself and they will automatically configure AWS VPC, Amazon Aurora RDS, Amazon EC2, Amazon EFS, and Amazon ElastiCache to build a highly available, auto-scaling multi-tier web application. The architecture used in this project is referenced from the from [Highly Available Web Application Workshop](https://ha-webapp.workshop.aws/introduction.html) on AWS website.
## Architecture
This project are based upon the materials developed as a reference architecture by AWS which is available as a [GitHub repository](https://github.com/aws-samples/aws-refarch-wordpress).
![](./aws-refarch-wordpress.jpeg)

## Usage
### Prerequisite
Here is some related components to follow my scanerio:
- Dedicated Vault server (this project used[vault.scienista.com](https://vault.scienista.com)).
- An AWS programable account with following permissions:
    - AmazonRDSFullAccess
    - AmazonEC2FullAccess
    - AmazonElastiCacheFullAccess
    - AmazonS3FullAccess
    - AmazonDynamoDBFullAccess
    - AmazonElasticFileSystemFullAccess
### Instruction
Clone the repository:
```
git clone https://github.com/tigonguyen/terraform-basic-web-app.git
cd terraform-basic-web-app/envs/
```

Provision S3 andf DynamoDB backend:
```
cd backend
terraform init
terraform plan --out "tfplan"
terraform apply "tfplan"
cd ../
```

Provision a new HA web environment via modifying a `yaml` file:
```
cp -rf dev uat
cd uat/
sed -i 's/dev/uat/g' env_vars.yaml \
&& sed -i 's+10.0.0.0/16+192.168.0.0/16+g' env_vars.yaml \
&& sed -i 's+10.0.0.0/24+192.168.0.0/24+g' env_vars.yaml \
&& sed -i 's+10.0.1.0/24+192.168.1.0/24+g' env_vars.yaml \
&& sed -i 's+10.0.2.0/24+192.168.2.0/24+g' env_vars.yaml \
&& sed -i 's+10.0.3.0/24+192.168.3.0/24+g' env_vars.yaml \
&& sed -i 's+10.0.5.0/24+192.168.4.0/24+g' env_vars.yaml \
&& sed -i 's+10.0.5.0/24+192.168.5.0/24+g' env_vars.yaml
```

Provision entire the architecture:
```
terragrunt run-all apply
```

Clean up:
```
terragrunt run-all destroy
```

## Author
- **[Thanh, Dinh Nguyen](https://github.com/tigonguyen)**

## License
Distributed under the MIT License. See [LICENSE](./LICENSE) for more information.
