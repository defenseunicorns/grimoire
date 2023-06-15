# delete_vpc

A shell script to delete AWS VPC with its dependencies (EC2 Instance, NAT Gateway, VPN Connection, VPN Gateway, VPC Peering, Endpoint, Egress Only Internet Gateway, Network ACL, Security Group, Elastic IP, Internet Gateway, Network Interface, Subnet and Route Table).

**Modified on Jun 7, 2020:** Solved the issue of Security Group deleting failed when Security Group attached to ENI.

Note:
1. The script requires [AWS CLI](https://aws.amazon.com/cli/) and does not depend on any other tools.
2. **Optional.** To use a specific credential, add a [profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) in the environment variable [AWS_PROFILE](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html).
```
Usage      : ./delete_vpc.sh <region-id> <vpc-id>
For example: ./delete_vpc.sh us-east-1 vpc-xxxxxxxxxx
             AWS_PROFILE=xxxxx ./delete_vpc.sh eu-central-1 vpc-xxxxxxxxxx

if you want to know what's the VpcID in the specific region, please try
For example: ./delete_vpc.sh us-east-1

Notes (8/22/2021):
      Added support for ELBs (Automaticly delete listener,load-balancer and target_group)
```

# NOTE

The original script was copied from https://github.com/lianghong/delete_vpc. All credits and upstream changes should be made there. Or this should be a submodule.
