data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.project}-${var.environment}-SSHKey"
  public_key = var.ssh_pubkey

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_instance" "bastion-hosts" {
  count         = var.number_bastion_hosts
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh-key.key_name

  tags = {
    Name        = "${var.project}-${var.environment}-BastionHost-${count.index + 1}"
    Project     = var.project
    Environment = var.environment
  }
}