# resource "aws_eks_cluster" "this" {
#   count = local.create ? 1 : 0

#   name                          = var.cluster_name
#   role_arn                      = local.cluster_role
#   version                       = var.cluster_version
#   enabled_cluster_log_types     = var.cluster_enabled_log_types
#   bootstrap_self_managed_addons = var.bootstrap_self_managed_addons
# }
# access_config {
#   authentication_mode                         = var.authentication_mode
#   bootstrap_cluster_creator_admin_permissions = false
# }
# vpc_config {
#   security_group_ids      = compact(distinct(concat(var.cluster_additional_security_group_ids, [local.cluster_security_group_id])))
#   subnet_ids              = coalescelist(var.control_plane_subnet_ids, var.subnet_ids)
#   endpoint_private_access = var.cluster_endpoint_private_access
#   endpoint_public_access  = var.cluster_endpoint_public_access
#   public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
# }

# dynamic "kubernetes_network_config" {
#   for_each = local.create_outposts_local_cluster ? [] : [1]

#   content {
#     ip_family         = var.cluster_ip_family
#     service_ipv4_cidr = var.cluster_service_ipv4_cidr
#     service_ipv6_cidr = var.cluster_service_ipv6_cidr
#   }
# }

# dynamic "outpost_config" {
#   for_each = local.create_outposts_local_cluster ? [var.outpost_config] : []

#   content {
#     control_plane_instance_type = outpost_config.value.control_plane_instance_type
#     outpost_arns                = outpost_config.value.outpost_arns
#   }
# }

# dynamic "encryption_config" {
#   for_each = local.enable_cluster_encryption_config ? [var.cluster_encryption_config] : []

#   content {
#     provider {
#       key_arn = var.create_kms_key ? module.kms.key_arn : encryption_config.value.provider_key_arn
#     }
#     resources = encryption_config.value.resources
#   }
# }

# dynamic "upgrade_policy" {
#   for_each = length(var.cluster_upgrade_policy) > 0 ? [var.cluster_upgrade_policy] : []

#   content {
#     support_type = try(upgrade_policy.value.support_type, null)
#   }
# }

# dynamic "zonal_shift_config" {
#   for_each = length(var.cluster_zonal_shift_config) > 0 ? [var.cluster_zonal_shift_config] : []

#   content {
#     enabled = try(zonal_shift_config.value.enabled, null)
#   }
# }

# tags = merge(
#   { terraform-aws-modules = "eks" },
#   var.tags,
#   var.cluster_tags,
# )

# timeouts {
#   create = try(var.cluster_timeouts.create, null)
#   update = try(var.cluster_timeouts.update, null)
#   delete = try(var.cluster_timeouts.delete, null)
# }

# depends_on = [
#   aws_iam_role_policy_attachment.this,
#   aws_security_group_rule.cluster,
#   aws_security_group_rule.node,
#   aws_cloudwatch_log_group.this,
#   aws_iam_policy.cni_ipv6_policy,
# ]

# lifecycle {
#   ignore_changes = [
#     access_config[0].bootstrap_cluster_creator_admin_permissions
#   ]
# }
# resource "aws_ec2_tag" "cluster_primary_security_group" {

#   for_each = { for k, v in merge(var.tags, var.cluster_tags) :
#     k => v if local.create && k != "Name" && var.create_cluster_primary_security_group_tags
#   }

#   resource_id = aws_eks_cluster.this[0].vpc_config[0].cluster_security_group_id
#   key         = each.key
#   value       = each.value
# }

# resource "aws_cloudwatch_log_group" "this" {
#   count = local.create && var.create_cloudwatch_log_group ? 1 : 0

#   name              = "/aws/eks/${var.cluster_name}/cluster"
#   retention_in_days = var.cloudwatch_log_group_retention_in_days
#   kms_key_id        = var.cloudwatch_log_group_kms_key_id
#   log_group_class   = var.cloudwatch_log_group_class

#   tags = merge(
#     var.tags,
#     var.cloudwatch_log_group_tags,
#     { Name = "/aws/eks/${var.cluster_name}/cluster" }
#   )
# }