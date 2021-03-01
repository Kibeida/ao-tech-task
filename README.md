# ao-tech-task

My first thoughts with this were around a S3 bucket with Cloudfront distribution but the instructions mentioned a VPC bound environment and that paired with the containers discussion we had I thought I’d push myself to work through Docker and Kubernetes.
So I’ve worked through an approach suggested on terraform for provisioning EKS. I felt it demonstrated the concept well because it also ensures the cluster sits within a VPC with public and private subnets
