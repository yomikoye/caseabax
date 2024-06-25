# ABAX CASE STUDY

### Link
https://sre.google/classroom/imageserver/

### Problem Statement
Design an architecture for a Distributed ImageServer and implement the infrastructure in terraform

### Requirements
###### Solution
- The solution is a global service and should be accessible to clients all over the world.
- There are three services powering the solution which include:
  - Upload: users can upload an image and it's tag
  - Search: users can search images by tag or uploading user and 10 search reesults are displayed per page. Results include thumbnail and image metadata
  - Detail: shows image in full resolution
###### Data
- ~200 TB/day in image uploads. 30 days retention required which is ~6 PB/30days
- Storage metadata is ~15TB/30days

### Proposed Solution
The architectural diagram is shown below:
![alt text](<Distributed_ImageServer.jpg>)

From the internet, users connect to the front door service which is a global load balancer with WAF and caching capabilities. The front door service routes requests between regions. Users will be directed to the closest edge location to minimize latency. 

The uploaded image and metadata is stored in Azure Cosmodb. The whole system is highly reliable and fault tolerant. Cached images in edge locations ensures fast retrieval of images while using the search service.

For the deployment, Azure App Service is used in a multi-region setup which are all active and routed via Frontdoor.  Azure application insights is used to collect metrics and logs and alerts can be configured based on interested parameters.

CosmoDB with the multi-region writes replication protocol ensures every region supports both writes and reads. The multi-region writes capability also enables:
- Unlimited elastic write and read scalability.
- 99.999% read and write availability all around the world.
- Guaranteed reads and writes served in less than 10 milliseconds at the 99th percentile.

### Implementation
The terraform code is avialable in the terraform folder. The code creates:
- one cosmodb database
- 4 webapps per region for the upload, download, search and metadata services
- one frontdoor service and associated configurations
- necessary rbac permissions 

The result is shown in the imageb
![alt text](<image.png>)
