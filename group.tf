
resource "aws_security_group" "this" {
  name_prefix = local.sg_name_prefix

  description = "RDS instance SG"
  tags        = local.sg_tags
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_groups" {
  count = length(var.allowed_security_groups)

  description              = "Permit RDS access (${var.allowed_security_groups[count.index]})"
  from_port                = var.port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = var.allowed_security_groups[count.index]
  to_port                  = var.port
  type                     = "ingress"
}

resource "aws_security_group_rule" "allow_ipv4_cidrs" {
  count = length(var.allowed_cidr_blocks) > 0 ? 1 : 0

  cidr_blocks       = var.allowed_cidr_blocks
  description       = "Permit access to CIDRs"
  from_port         = var.port
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = var.port
  type              = "ingress"
}

resource "aws_security_group_rule" "allow_ipv6_cidrs" {
  count = length(var.allowed_ipv6_cidr_blocks) > 0 ? 1 : 0

  cidr_blocks       = var.allowed_ipv6_cidr_blocks
  description       = "Permit access to IPv6 CIDRs"
  from_port         = var.port
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = var.port
  type              = "ingress"
}