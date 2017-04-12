## HashiCorp Consul on the AWS Cloud
> Consul version 8.0
### Deployment options:
* Deploy HashiCorp Consul into a new VPC (end-to-end deployment) builds a new VPC with public and private subnets, and then deploys HashiCorp Consul into that infrastructure.
* Deployment of HashiCorp Consul into an existing VPC provisions HashiCorp Consul into your existing infrastructure. 

### Architecture
![quickstart-hashicorp-consul](/images/consul.png)
### Change Log: 
* Added Linux Bastion
* Updated Consul version to '0.8.0'
* Removed SeedServer
* Added ec2-retry functionality




