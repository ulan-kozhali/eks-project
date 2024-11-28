# resource "aws_eks_cluster" "example" {
#   name     = "eks-project"
#   role_arn = aws_iam_role.role.arn
# }

#   vpc_config = {
#     subnet_ids = [aws_vpc.main.id, aws_vpc.main2.id]
#   }

# #   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
# #   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
# # #   depends_on = [
# # #     aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
# # #     aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
# # #   ]


# # output "endpoint" {
# #   value = aws_eks_cluster.example.endpoint
# # }

# # output "kubeconfig-certificate-authority-data" {
# #   value = aws_eks_cluster.example.certificate_authority[0].data
# # }

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["eks.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "role" {
#   name               = "eks-cluster-example"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.role.name
# }

# # # Optionally, enable Security Groups for Pods
# # # Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
# # resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
# #   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
# #   role       = aws_iam_role.role.name
# # }

# # resource "aws_eks_cluster" "cluster" {
# #   depends_on = [aws_cloudwatch_log_group.example]

# #   enabled_cluster_log_types = ["api", "audit"]
# #   name                      = var.cluster_name

# #   # ... other configuration ...
# # }

# # resource "aws_cloudwatch_log_group" "logs" {
# #   # The log group name format is /aws/eks/<cluster-name>/cluster
# #   # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
# #   name              = "/aws/eks/${var.cluster_name}/cluster"
# #   retention_in_days = 7

# #   # ... potentially other configuration ...
# # }

# # resource "aws_eks_cluster" "cluster" {
# #   # ... other configuration ...
# # }

# # data "tls_certificate" "tls" {
# #   url = aws_eks_cluster.example.identity[0].oidc[0].issuer
# # }

# # resource "aws_iam_openid_connect_provider" "provider" {
# #   client_id_list  = ["sts.amazonaws.com"]
# #   thumbprint_list = [data.tls_certificate.example.certificates[0].sha1_fingerprint]
# #   url             = data.tls_certificate.example.url
# # }

# # # data "aws_iam_policy_document" "example_assume_role_policy" {
# # #   statement {
# # #     actions = ["sts:AssumeRoleWithWebIdentity"]
# # #     effect  = "Allow"

# # #     condition {
# # #       test     = "StringEquals"
# # #       variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
# # #       values   = ["system:serviceaccount:kube-system:aws-node"]
# # #     }

# # #     principals {
# # #       identifiers = [aws_iam_openid_connect_provider.example.arn]
# # #       type        = "Federated"
# # #     }
# # #   }
# # # }

# # # resource "aws_iam_role" "example3" {
# # #   assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
# # #   name               = "example"
# # # }

# # # resource "aws_iam_role" "example4" {
# # #   assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
# # #   name               = "example"
# # # }

# # # resource "aws_eks_cluster" "example5" {
# # #   name     = "example-cluster"
# # #   role_arn = aws_iam_role.example.arn

# # #   vpc_config {
# # #     endpoint_private_access = true
# # #     endpoint_public_access  = false
# # #     # ... other configuration ...
# # #   }

# # #   outpost_config {
# # #     control_plane_instance_type = "m5d.large"
# # #     outpost_arns                = [data.aws_outposts_outpost.example.arn]
# # #   }
# # # }

# # # resource "aws_iam_role" "example6" {
# # #   assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
# # #   name               = "example"
# # # }

# # # resource "aws_eks_cluster" "example7" {
# # #   name     = "example-cluster"
# # #   role_arn = aws_iam_role.example.arn

# # #   vpc_config {
# # #     endpoint_private_access = true
# # #     endpoint_public_access  = false
# # #     # ... other configuration ...
# # #   }

# # #   access_config {
# # #     authentication_mode                         = "CONFIG_MAP"
# # #     bootstrap_cluster_creator_admin_permissions = true
# # #   }
# # # }