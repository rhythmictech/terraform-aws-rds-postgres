resource "aws_db_subnet_group" "mysql" {
  subnet_ids = var.subnet_ids

  tags = merge(
    local.base_tags,
    var.tags,
    {
      "Name" = "${var.name}-subnet-group"
    },
  )
}

resource "aws_security_group" "mysql" {
  vpc_id = var.vpc_id

  ingress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    security_groups  = var.allowed_security_groups
    cidr_blocks      = var.allowed_cidr_blocks
    ipv6_cidr_blocks = var.allowed_ipv6_cidr_blocks
  }

  tags = merge(
    local.base_tags,
    var.tags,
    {
      "Name" = "${var.name}-security-group"
    },
  )
}

