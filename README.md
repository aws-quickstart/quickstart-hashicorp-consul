## HashiCorp Consul on the AWS Cloud

### Versions:
* `CONSUL CLIENT VERSION`='1.6.0'
* `CONSUL SERVER VERSION`='1.6.0'
* `CONSUL_TEMPLATE_VERSION`='0.20.1'

### Deployment options:

* Deploy HashiCorp Consul into a new VPC (end-to-end deployment) builds a new VPC with public and private subnets, and then deploys HashiCorp Consul into that infrastructure.
* Deployment of HashiCorp Consul into an existing VPC provisions HashiCorp Consul into your existing infrastructure. 

### Architecture

![quickstart-hashicorp-consul](/images/consul.png)

### Change Log: 

* Updated Consul versions to '1.6.0'
* Converted to yaml
* Adds S3 Authenticated calls for ConfigSets (Remove the need public bucket)






