# ao-tech-task

Provide a deployable CloudFormation or Terraform IaC stack for securely hosting a publicly available web page in a VPC bound environment. The content of the page is irrelevant but the IaC code, AWS components and security controls you use will be assessed.  Any future recommendations for the stack should be documented and submitted in support of the provided stack.

The brief asked for a deployment of IaC (I used Terraform) stack to host a publically available web page in a VPC bound environment.
Initially my thinking was using a s3 bucket for the web page but the instructions mentioned a VPC bound environmnet. I decided to build a kubernetes EKS cluster with a Docker image that I created. The implementation shows an AWS VPC with both public and private subnets, security groups and an EKS cluster.

## Terraform Files:

### main.tf
 provisions a VPC using VPC module as well as the security groups that will be used by the EKS cluster.
 
 ### eks-cluster.tf
 provisions an EKS cluster with autoscaling groups for the cluster using eks module and assosciating it with the VPC.
 
 ### outputs.tf
 contains the configuration of the outputs to be displayed.
 
 ### providers.tf
 configures AWS as the provider as well as the terraform versions used.
 
 ### variables.tf
 contains the value of variables defined. 
 
 ### kubernetes.tf 
This file includes the kubernetes provider. 

## Future Recommendations:

. Using Remote State on s3.
. Using Amazon ECS to run the dockerized web page.
. Using ECR to store and manage containers.
