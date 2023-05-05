## Requirements

- The infrastructure should be codified using Terraform and provisioned in such a way that it can be redeployed to a different account with minor variable changes.
- S3 should be configured as a static site and used to host the content.
- Amazon CloudFront should be configured to distribute the content from the S3 static site.
- Amazon CloudFront’s default behavior should be configured to not cache.
- Amazon CloudFront should have an additional behavior configured to cache an image for a default / minimum / maximum TTL = 30 minutes.
- Amazon CloudFront should have SSL enabled using the Default CloudFront Certificate
- CodePipeline should be configured in such a way to deploy / update the files for the site.
- CodePipeline should trigger off any commits or pull requests merged to a specific branch of the site’s source code git repository.
- CodePipeline should invalidate the CloudFront Distribution after adding files to the site.


# Terraform setup for S3 Static site, Cloudfront, and Codepipeline

This repository contains a complete deployment for an S3 Static Site setup as origin for a Cloudfront distrubution and with the CICD pipelines with Codepipeline tu update the S3 bucket files each commit to main branch.


DIAGRAM HERE
![Diagram](diagram.png "Diagram")

there are some values that you can customize of this deployment and you can find them in the `terraform.tfvars` file.


## The deployment is the the folder deploy

### 1. Network

The network module creates a VPC for a given CIDR block along with private and public subnets that are defined as a map in the `terraform.tfvars` file

### 2. App

The app module creates the ALB, ASG and the Launch template needed to spin up EC2 instance with a nginx server on it

### 3. Dbs

The db module creates the DB postgres with the values given in the `terraform.tfvars`



## The content for the web site is in the repo

### Global Vars
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|prefix_resources_name|prefix that will be used for all resources creation|`map`| |no|
|other_tags|Aditional tags you can add to all resources|`string`| |no|

### Module Network Vars
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|vpc_cidr_block|cicd used for the creation of the VPC|`string`| |yes|
|subnet_cicd_az_name|subnets details such as AZs and cicd blocks|`map`| |yes|


### Module App
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|asg_target_value|CPU load average target value for the ASG|`number`| |yes|


### Module DBs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|rds_instance_class|instance type to use in the DB|`string`| |yes|
|rds_allocated_storage|storage size for the DB|`number`| |yes|



## How setup to deploy to specific acocunt



## How update files
