# eFuse-Project
## Objective 1: Deploy a containerized application in Kubernetes

Created Kubernetes manifest yaml file [eFuse-Project/k8s/nginx.yaml](eFuse-Project/k8s/nginx.yaml) which includes `Deployment` using the Docker nginx image and a `Load Balancer service` defined with port: 80 and targetPort: 80, which means that external traffic will be routed to the Nginx container on TCP port 80. For testing I deployed it to EKS cluster.

By default Nginx responding to both HEAD and GET requests. You can always specify any custom Nginx configuration using ConfigMaps (which I didn't include in this example)
You can test HEAD and GET requests by using the `curl` command :

   ``` 
   curl http://<load-balancer-IP>
   ```


## Objective 2: Implement path-based routing for a Kubernetes ingress

Created Kubernetes manifest yaml file [eFuse-Project/k8s/whoami.yaml](eFuse-Project/k8s/whoami.yaml)
which include `Deployment` that contains  containous/whoami image in it that will run on port 80. By the reference of deployment POD is created.

`Cluster IP Services` in Kubernetes consistently maintain a well-defined endpoint for pods. Service is responsible for enabling network access to a set of pods. 

`Ingress` Now the main part of this assignment is ingress where I have routed external traffic to services(Service is  accessible from outside).

For testing that Kubernetes ingress controller is sending only requests for `/whoami` to the container use `curl` command with Ingress `EXTERNAL_IP` address

```
curl http://<EXTERNAL_IP>/whoami

```



## Objective 3: Implement an infrastructure-as-code solution to create an Amazon S3 bucket.

Created s3 bucket and IAM user using Terraform [eFuse-Project/Infra/](eFuse-Project/Infra/) with all necessary permission for bucket and user. 
Also, uploaded 3 files to s3 bucket with command:

   ```
   aws s3 cp <path-folder> s3://<bucket-name>/<prefix-key>
   ```

  One of the object [Here](https://efuse-s3bucket-work-sample.s3.us-east-2.amazonaws.com/files/pic2.jpeg)

## Bonus Objective: Implement a deployment process
   
Automated Terraform Deployment [eFuse-Project/.github/workflows/terraform-deploy.yml](eFuse-Project/.github/workflows/terraform-deploy.yml) and Deployment to EKS 
[eFuse-Project/.github/workflows/eks-deploy.yml](eFuse-Project/.github/workflows/eks-deploy.yml) using GitHub Actions.