output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}