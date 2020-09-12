
module "basic" {
  source = "../.."

  name              = "app-database"
  identifier_prefix = "appdb"
  instance_class    = "db.m5.xlarge"
  storage           = 100
  subnet_group_name = "db_subnet_group"
  vpc_id            = "vpc-1234567890"
}
