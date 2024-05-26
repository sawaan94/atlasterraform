module "alb" {
  source     = "./alb"
  sgid       = module.sg.sgid
  vpcid      = module.vpc.vpcid
  defsub1    = module.vpc.defsub1
  defsub2    = module.vpc.defsub2
  depends_on = [module.sg]
}

module "asg" {
  source     = "./asg"
  sgid       = module.sg.sgid
  tg1        = module.alb.tg1
  defsub1    = module.vpc.defsub1
  defsub2    = module.vpc.defsub2
  depends_on = [module.alb, module.sg]
}

module "sg" {
  source = "./securitygroup"
  vpcid  = module.vpc.vpcid

}

module "vpc" {
  source = "./vpc"

}