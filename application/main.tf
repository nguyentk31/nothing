provider "aws" {
  region = var.aws_region
}

data "aws_ecr_authorization_token" "token" {
  registry_id = split(".", var.chart_ecr_url)[0]
}

data "aws_eks_cluster_auth" "cluster-auth" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_ca)
    token                  = data.aws_eks_cluster_auth.cluster-auth.token
  }

  registry {
    url      = "oci://${split("/", var.chart_ecr_url)[0]}"
    password = data.aws_ecr_authorization_token.token.password
    username = data.aws_ecr_authorization_token.token.user_name
  }
}

# Using helm to install LBC chart 
resource "helm_release" "aws-lbc-chart" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = var.lbc_namespace

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.lbc_role
  }

  set {
    name  = "serviceAccount.name"
    value = var.lbc_sa
  }
}

# Using helm to install app chart after pushed to ECR
resource "helm_release" "app-chart" {
  name       = "my-application"
  repository = "oci://${split("/", var.chart_ecr_url)[0]}"
  chart      = split("/", var.chart_ecr_url)[1]
  version    = var.chart_version

  set {
    name  = "image.repository"
    value = var.image_ecr_url
  }

  set {
    name  = "image.tag"
    value = var.image_tag
  }

  set {
    name  = "ingress.annotations.alb\\.ingress\\.kubernetes\\.io/security-groups"
    value = var.alb_sg
  }

  depends_on = [ helm_release.aws-lbc-chart ]
}