## Change Log: (tagged dev-rc1)

### Template Changes
* Added Master template (links sub templates)
* Added VPC Configuration
 * 3 Subnet config
 * Uses NAT Gateways `Uses instances where NAT GW is not supported`
* Master Template:
 * Links sub templates (VPC)
 * Updated original template to consume VPC resources

### Added Template Functionality

* Added SecGroup to Consul Template
* Added VPC Zone Identifiers to ASG’s to Consul Templates
* Parameterized Consul Node which is now passed to bootstrap script
* Added parameterized buckets for S3 and Prefix (which allows for testing in different locations)
* Added Consul Nodes Parameter (Sets ASG parms)

## New bootstrapping script `v2`
* Takes input from template UserData and Dynamically builds base.json
* Consul now looks at generated config to get hints on how many nodes to expect during build
* New bootstrapping script takes parameterized values via Userdata and executes build according to specified values in: `ConsulNodes, S3URL, S3BucketName, S3KeyPrefix`

## Todo
- Enable Atlas Token
- Add wait handles for better failure detection
- Create Deployment Docs

