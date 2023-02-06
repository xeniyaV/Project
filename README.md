# eFuse-Project
## Objective 1: Deploy a containerized application in Kubernetes

Created Kubernetes manifest yaml file [eFuse-Project/k8s/nginx.yaml](eFuse-Project/k8s/nginx.yaml) which includes Deployment using the Docker nginx image and a Load Balancer service defined with port: 80 and targetPort: 80, which means that external traffic will be routed to the Nginx container on TCP port 80. For testing I deployed it to EKS cluster.

By default Nginx responding to both HEAD and GET requests. You can always specify any custom Nginx configuration using ConfigMaps (which I didn't include in this example)
You can test HEAD and GET requests by using the `curl` command :

   ``` 
   curl http://<load-balancer-IP>
   ```


## Objective 2: Implement path-based routing for a Kubernetes ingress

## Objective 3: Implement an infrastructure-as-code solution to create an Amazon S3 bucket.

Created s3 bucket and IAM user using Terraform [eFuse-Project/Infra/](eFuse-Project/Infra/) with all necessary permission for bucket and user. 
Also, uploaded 3 files to s3 bucket with command:

   ```
   aws s3 cp <path-folder> s3://<bucket-name>/<prefix-key>
   ```
   
   [Here is one of the objects](https://efuse-s3bucket-work-sample.s3.us-east-2.amazonaws.com/files/pic2.jpeg)

## Bonus Objective: Implement a deployment process
   
Automated Terraform Deployment [eFuse-Project/.github/workflows/terraform-deploy.yml](eFuse-Project/.github/workflows/terraform-deploy.yml) and Deployment to EKS 
[eFuse-Project/.github/workflows/eks-deploy.yml](eFuse-Project/.github/workflows/eks-deploy.yml) using GitHub Actions.