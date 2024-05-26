module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source     = "./modules/sg"
  vpc        = module.vpc.vpcid
  depends_on = [module.vpc]
}

module "ec2" {
  source     = "./modules/ec2"
  sgid       = module.sg.sgid
  subnet     = module.vpc.subnet
  depends_on = [module.sg, module.vpc]
}

module "route53" {
  source     = "./modules/route53"
  vpcid        = module.vpc.vpcid
  privateip  = module.ec2.privateip
  depends_on = [module.vpc, module.ec2]
}
