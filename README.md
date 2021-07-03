# terraform-basic-web-app
This repository is reference from [Highly Available Web Application Workshop](https://ha-webapp.workshop.aws/introduction.html) on AWS website.

## Todo list
- [x] Generate providers for all child environment folder with terragrunt.
- [x] Define S3 backend for all child environment folder with terragrunt.
- [x] aws_vpc module
- [x] aws_subnets module - Create 6 subnets (3 pairs) into 2 Availability Zone
- [x] aws_internet_gateway module
- [ ] aws_route_table module
## Architecture
![](./architecture.png)