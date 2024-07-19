# module "minikube_cluster" {
#   source = "./modules/minikube"
# }

module "network" {
  source = "./modules/vpc"
  region = var.region
}

module "kubernetes_cluster" {
  source = "./modules/eks"
  vpc_id = module.network.vpc_id
  vpc_private_subnets = module.network.private_subnets
}