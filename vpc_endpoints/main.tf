module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./ec2"

  public_sg_id     = module.vpc.public_sg_id
  public_subnet_id = module.vpc.public_subnet_id

  private_sg_id     = module.vpc.private_sg_id
  private_subnet_id = module.vpc.private_subnet_id
}
 