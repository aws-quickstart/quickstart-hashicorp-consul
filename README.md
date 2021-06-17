# quickstart-hashicorp-consul
## HashiCorp Consul on the AWS Cloud
Consul version: 1.7.0

HashiCorp Consul is a tool that provides the foundation of cloud networking automation using a central registry for service-based networking. Consul’s core use cases include:

* Service registry & health monitoring, to provide a real-time directory of all services with their health status;
* Network middleware automation, with service discovery for dynamic reconfiguration as services scale up, down or move;
* Zero trust network with service mesh, to secure service-to-service traffic with identity-based security policies and encrypted traffic with Mutual-TLS.

Each stack in this deployment takes approximately 10 minutes to create. For more information and step-by-step deployment instructions, see the [deployment guide](https://aws-quickstart.s3.amazonaws.com/quickstart-hashicorp-consul/doc/hashicorp-consul-on-the-aws-cloud.pdf).

### Deployment Options
* Deployment of HashiCorp Consul into a new VPC (end-to-end deployment) builds a new VPC with public and private subnets, and then deploys HashiCorp Vault into that infrastructure.
* Deployment of HashiCorp Consul into an existing VPC provisions HashiCorp Vault into your existing infrastructure.

### Architectture
![quickstart-hashicorp-consul](https://d0.awsstatic.com/partner-network/QuickStart/datasheets/hashicorp-consul-on-aws-architecture.png)

### Change Log (January 2020)
* Upgraded to HashiCorp Consul 1.7 using best practices.
* Updated AWS architecture.
* Updated templates:
  * [Deploy HashiCorp Consul into a new VPC on AWS](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/templates/quickstart-hashicorp-consul-master.template)
  * [Deploy HashiCorp Consul into an existing VPC on AWS](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/templates/quickstart-hashicorp-consul.template) 
  
For architectural details, best practices, step-by-step instructions, and customization options, see the [deployment guide](https://aws-quickstart.s3.amazonaws.com/quickstart-hashicorp-consul/doc/hashicorp-consul-on-the-aws-cloud.pdf).

To post feedback, submit feature ideas, or report bugs, use the **Issues** section of this GitHub repo.
If you'd like to submit code for this Quick Start, please review the [AWS Quick Start Contributor's Kit](https://aws-quickstart.github.io/).
