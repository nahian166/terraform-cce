# terraform-cce
## Overview

This repository is designed to reuse the terraform opentelekomcloud provider's modules for different test purposes. 
The example of some main opentelekomcloud modules are VPC, Subnets, KeyPairs, Loadbalancer, CCE Clusters, more modules will be added later. 

## Authentication
The authentication is done by the clouds.yaml file. All the credentials including username, password, domain, project/tenant id and ak,sk are needed and these will be fetched from the clouds.yaml file. 

clouds.yaml file should be located under the ~/.config/openstack/ directory. 


