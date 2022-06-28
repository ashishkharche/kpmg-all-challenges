# Challenges #2

## Problem

**Summary**

We need to write code that will query the metadata of an instance within AWS and provide a JSON formatted output. The choice of language and implementation is up to you.

**Bonus Points**

The code allows for a particular data key to be retrieved individually

**Hints**

- [Aws Documentation](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html)

- [Azure Documentation](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/instance-metadata-service)

- [Google Documentation](https://cloud.google.com/compute/docs/storing-retrieving-metadata)

## Solution

### Getting metadata

The IP address 169.254.169.254 belongs to the IPv4 Link Local Address space 169.254.0.0/16 (169.254.0.0 through 169.254.255.255).

The selection of an address within this block allows Amazon Web Services to create a service endpoint accessible from any system, without conflicting with the commonly used IP address space.

Reference: https://stackoverflow.com/questions/42314029/whats-special-about-169-254-169-254-ip-address-for-aws