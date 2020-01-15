## HashiCorp Consul on the AWS Cloud

### Table of Contents
- [Overview](#overview)
- [Architectture](#architectture)
- [Getting Started](#getting-started)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Support](#support)
- [License](#license)

### Overview
This repo contains a set of CloudFormation templates and modules for deploying an open-source HashiCorp Consul cluster and clients on AWS. HashiCorp Consul is a tool that provides the foundation of cloud networking automation using a central registry for service based networking. Consul’s core use cases include:

* Service registry & health monitoring, to provide a real-time directory of all services with their health status;
* Network middleware automation, with service discovery for dynamic reconfiguration as services scale up, down or move;
* Zero trust network with service mesh, to secure service-to-service traffic with identity-based security policies and encrypted traffic with Mutual-TLS.

### Architectture

![quickstart-hashicorp-consul](/images/consul.png)

Deployed Versions:
* `CONSUL CLIENT VERSION`='1.7.0-beta2'
* `CONSUL SERVER VERSION`='1.7.0-beta2'
* `CONSUL TEMPLATE VERSION`='0.24.0'

For architectural details, best practices, step-by-step instructions, and customization options, see the [deployment guide](https://aws-quickstart.s3.amazonaws.com/quickstart-hashicorp-consul/doc/hashicorp-consul-on-the-aws-cloud.pdf).

### Getting Started
#### How to Use this Repo
This repo has the following folder structure:
* [templates](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/templates): This folder contains CloudFormation templates to deploy the QuickStart stacks.
* [submodules](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/submodules): Git submodules utilized during the deployment of QuickStart stacks.
* [ci](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/ci): Utilized by [taskcat](https://github.com/aws-quickstart/taskcat) utility to run tests via CI.
* [functions](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/functions): Contains packaged functions used by the QuickStart templates during deployment.
* [images](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/images): Image of the QuickStart Architecture.

#### How to Deploy Consul QuickStart Templates
To deploy a Consul cluster and clients using this repo, there are two approaches:
* End-to-end Deployment: deploys HashiCorp Consul cluster and its ELB, Consul clients, and a bastion host into a new VPC with public, private subnets, and gateways. See [master deployment template](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/templates/quickstart-hashicorp-consul-master.template).
* Existing Infrastructure Deployment: deploys HashiCorp Consul cluster and its ELB, Consul clients, and a bastion host into a an existing VPC and its associated public, private subnets, and gateways. See [consul deployment template](https://github.com/aws-quickstart/quickstart-hashicorp-consul/tree/master/templates/quickstart-hashicorp-consul.template).

#### How to Set up a Service with Consul Connect - Service Mesh
[Consul Connect](https://www.consul.io/docs/connect/index.html) is enabled by default. To set up a service on the Consul client nodes, you will need to register the service and proxy with Consul. For more information, please visit the following HashiCorp Learn pages:
* [Register the Service and Proxy with Consul](https://learn.hashicorp.com/consul/getting-started/connect#register-the-service-and-proxy-with-consul)
* [Register a Dependent Service and Proxy](https://learn.hashicorp.com/consul/getting-started/connect#register-a-dependent-service-and-proxy)
* [Control Communication with Intentions](https://learn.hashicorp.com/consul/getting-started/connect#control-communication-with-intentions)

#### How to Manage Consul Autopilot
[Consul Autopilot](https://www.consul.io/docs/commands/operator/autopilot.html) is enabled by default with the following settings:
```
"autopilot": {
  "cleanup_dead_servers": true,
  "last_contact_threshold": "200ms",
  "max_trailing_logs": 250,
  "server_stabilization_time": "10s",
  "redundancy_zone_tag": "az",
  "disable_upgrade_migration": false,
  "upgrade_version_tag": ""
}
```
For more information, please visit the following HashiCorp Learn pages:
* [Default Cofiguration](https://learn.hashicorp.com/consul/day-2-operations/autopilot#default-configuration)
* [Dead Server Cleanup](https://learn.hashicorp.com/consul/day-2-operations/autopilot#dead-server-cleanup)
* [Server Stabilization](https://learn.hashicorp.com/consul/day-2-operations/autopilot#server-stabilization)
* [Redundancy Zones](https://learn.hashicorp.com/consul/day-2-operations/autopilot#redundancy-zones)
* [Upgrade Migrations](https://learn.hashicorp.com/consul/day-2-operations/autopilot#upgrade-migrations)
* [Server Health Checking](https://learn.hashicorp.com/consul/day-2-operations/autopilot#server-health-checking)

### Documentation
Consul provides several key features:

* **Service Discovery** - Consul makes it simple for services to register
  themselves and to discover other services via a DNS or HTTP interface.
  External services such as SaaS providers can be registered as well.

* **Health Checking** - Health Checking enables Consul to quickly alert
  operators about any issues in a cluster. The integration with service
  discovery prevents routing traffic to unhealthy hosts and enables service
  level circuit breakers.

* **Key/Value Storage** - A flexible key/value store enables storing
  dynamic configuration, feature flagging, coordination, leader election and
  more. The simple HTTP API makes it easy to use anywhere.

* **Multi-Datacenter** - Consul is built to be datacenter aware, and can
  support any number of regions without complex configuration.

* **Service Segmentation** - Consul Connect enables secure service-to-service
communication with automatic TLS encryption and identity-based authorization.

Full, comprehensive documentation is viewable on the [Consul docs pages](https://www.consul.io/docs/).

### Contributing
Thank you for your interest in contributing! Please refer to [Quick Start Contributor's Guide](https://aws-quickstart.github.io) for instructions.

### Support
HashiCorp Support: https://support.hashicorp.com | 
AWS QuickStart Support: https://aws.amazon.com/quickstart

### License
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**





