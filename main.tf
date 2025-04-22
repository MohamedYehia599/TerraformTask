module "terraform-basic-network" {
    source = "github.com/MohamedYehia599/TerraformBasicNetwork?ref=main"
    region = var.region
    vpc_cidr = var.vpc_cidr
    subnet_cidr = var.subnet_cidr
    first_availability_zone = var.first_availability_zone
    second_availability_zone = var.second_availability_zone
}