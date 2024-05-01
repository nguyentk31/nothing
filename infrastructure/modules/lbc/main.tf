# Security Group for Application load balancer (ALB)
resource "aws_security_group" "alb" {
 name        = "${var.default_tags.Project}-${var.default_tags.Environment}-ALB-SG"
 description = "Allow HTTP to ALB"
 vpc_id      = var.cluster_vpc

ingress {
   description = "HTTPS ingress"
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}