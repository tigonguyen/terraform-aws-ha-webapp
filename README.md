# terraform-basic-web-app
This repository is reference from [Highly Available Web Application Workshop](https://ha-webapp.workshop.aws/introduction.html) on AWS website.

In this workshop, we will explore how to configure AWS VPC, Amazon Aurora RDS, Amazon EC2, Amazon EFS, and Amazon ElastiCache to build a highly available, auto-scaling multi-tier web application.

## Todo list
- [x] Generate providers for all child environment folder with terragrunt.
- [x] Define S3 backend for all child environment folder with terragrunt.
- [x] aws_vpc module
- [x] aws_subnets module - Create 6 subnets (3 pairs) into 2 Availability Zone
- [x] aws_internet_gateway module
- [x] aws_route_table module and related route, associations.
- [x] aws_nat_gateway module and related route, associations.
- [x] aws_security_groups module and related rule.
- [ ] aws_db_subnet_group module.
## Architecture
These labs are based upon the materials developed as a reference architecture by AWS. The reference architecture is available as a [GitHub repository](https://github.com/aws-samples/aws-refarch-wordpress).
![](./aws-refarch-wordpress.jpeg)