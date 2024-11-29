# variable "cluster_name" {
#   description = "Name of the EKS cluster"
#   type        = string
#   default     = ""
# }

# variable "cluster_version" {
#   description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.27`)"
#   type        = string
#   default     = null
# }

# variable "cluster_enabled_log_types" {
#   description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
#   type        = list(string)
#   default     = ["audit", "api", "authenticator"]
# }

# variable "authentication_mode" {
#   type    = string
#   default = "API_AND_CONFIG_MAP"
# }

# variable "cluster_upgrade_policy" {
#   description = "Configuration block for the cluster upgrade policy"
#   type        = any
#   default     = {}
# }

# variable "cluster_zonal_shift_config" {
#   description = "Configuration block for the cluster zonal shift"
#   type        = any
#   default     = {}
# }

# variable "cluster_additional_security_group_ids" {
#   description = "List of additional, externally created security group IDs to attach to the cluster control plane"
#   type        = list(string)
#   default     = []
# }

# variable "control_plane_subnet_ids" {
#   description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
#   type        = list(string)
#   default     = []
# }

# variable "subnet_ids" {
#   description = "A list of subnet IDs where the nodes/node groups will be provisioned. If `control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets"
#   type        = list(string)
#   default     = []
# }

# variable "cluster_endpoint_private_access" {
#   description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
#   type        = bool
#   default     = true
# }

# variable "cluster_endpoint_public_access" {
#   description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
#   type        = bool
#   default     = false
# }

# variable "cluster_endpoint_public_access_cidrs" {
#   description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
#   type        = list(string)
#   default     = ["0.0.0.0/0"]
# }

# variable "cluster_ip_family" {
#   description = "The IP family used to assign Kubernetes pod and service addresses. Valid values are `ipv4` (default) and `ipv6`. You can only specify an IP family when you create a cluster, changing this value will force a new cluster to be created"
#   type        = string
#   default     = "ipv4"
# }

# variable "cluster_service_ipv4_cidr" {
#   description = "The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks"
#   type        = string
#   default     = null
# }

# variable "cluster_service_ipv6_cidr" {
#   description = "The CIDR block to assign Kubernetes pod and service IP addresses from if `ipv6` was specified when the cluster was created. Kubernetes assigns service addresses from the unique local address range (fc00::/7) because you can't specify a custom IPv6 CIDR block when you create the cluster"
#   type        = string
#   default     = null
# }

# variable "outpost_config" {
#   description = "Configuration for the AWS Outpost to provision the cluster on"
#   type        = any
#   default     = {}
# }

# variable "cluster_encryption_config" {
#   description = "Configuration block with encryption configuration for the cluster. To disable secret encryption, set this value to `{}`"
#   type        = any
#   default = {
#     resources = ["secrets"]
#   }
# }

# variable "attach_cluster_encryption_policy" {
#   description = "Indicates whether or not to attach an additional policy for the cluster IAM role to utilize the encryption key provided"
#   type        = bool
#   default     = true
# }

# variable "cluster_tags" {
#   description = "A map of additional tags to add to the cluster"
#   type        = map(string)
#   default     = {}
# }

# variable "create_cluster_primary_security_group_tags" {
#   description = "Indicates whether or not to tag the cluster's primary security group. This security group is created by the EKS service, not the module, and therefore tagging is handled after cluster creation"
#   type        = bool
#   default     = true
# }

# variable "cluster_timeouts" {
#   description = "Create, update, and delete timeout configurations for the cluster"
#   type        = map(string)
#   default     = {}
# }

# # TODO - hard code to false on next breaking change
# variable "bootstrap_self_managed_addons" {
#   description = "Indicates whether or not to bootstrap self-managed addons after the cluster has been created"
#   type        = bool
#   default     = null
# }