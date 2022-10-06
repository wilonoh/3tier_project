# provider region
variable "region" {
    description = "making region a variable"
    default = "eu-west-2"
    type    = string
}

# vpc cidr block
variable "vpc_cidr_block" {
    description = "making vpc cidr block a variable"
    default = "10.0.0.0/16"
    type    = string
}

variable "vpc_instance_tenancy" {
    description = "making vpc instance_tenancy a variable"
    default = "default"
    type    = string
}

variable "enable_dns_hostnames" {
    description = "making enable dns hostnames a variable"
    default = true
    type    = bool
}
  
variable "enable_dns_support" {
    description = "making enable dns support a variable"
    default = true
    type    = bool
}
 
 variable "three_tier_vpc_name" {
    description = "making three_tier_vpc_name a variable"
    default = "three_tier_vpc"
    type    = string
}
variable "priv_sub1_name" {
    description = "making enable vpc_name a variable"
    default = "private_sub1"
    type    = string
}

variable "priv_sub2_name" {
    description = "making private_sub2_name a variable"
    default = "private_sub2"
    type    = string
}

variable "public_sub1_name" {
    description = "making enable vpc_name a variable"
    default = "public_sub1"
    type    = string
}

variable "public_sub2_name" {
    description = "making public sub2 name a variable"
    default = "public_sub2"
    type    = string
}

# variable "vpc_name" {
#     description = "making enable vpc_name a variable"
#     default = "three_tier_vpc"
#     type    = string
# }

variable "igw_name" {
    description = "making igw name a variable"
    default = "igw"
    type    = string
}
 
 variable "ngw_name" {
    description = "making igw name a variable"
    default = "ngw"
    type    = string
}
# private sub1 cidr block
variable "priv_sub1_cidr_block" {
    description = "making enable priv sub1 cidr block a variable"
    default = "10.0.1.0/24"
    type    = string
}

variable "priv_sub1_availability_zone" {
    description = "making priv sub1 availability zone a variable"
    default = "eu-west-2a"
    type    = string
}

variable "priv_sub2_cidr_block" {
    description = "making priv sub2 cidr block a variable"
    default = "10.0.2.0/24"
    type    = string
}

variable "priv_sub2_availability_zone" {
    description = "making enable priv sub2 availability zone a variable"
    default = "eu-west-2b"
    type    = string
}

variable "pub_sub1_cidr_block" {
    description = "making enable pub sub1 cidr block a variable"
    default = "10.0.5.0/24"
    type    = string
}

variable "pub_sub1_availability_zone" {
    description = "making enable pub sub1 availability zone a variable"
    default = "eu-west-2a"
    type    = string
}

variable "pub_sub1_map_public_ip_on_launch" {
    description = "making pub sub1 map_public_ip_on_launch a variable"
    default = true
    type    = bool
}
 
 variable "pub_sub2_cidr_block" {
    description = "making pub sub2 cidr_block a variable"
    default = "10.0.6.0/24"
    type    = string
}

 variable "pub_sub2_availability_zone" {
    description = "making pub sub2 availability_zone a variable"
    default = "eu-west-2b"
    type    = string
}

 variable "pub_sub2_map_public_ip_on_launch" {
    description = "making pub sub2 map_public_ip_on_launch a variable"
    default = true
    type    = bool
}

# route
 variable "priv_route_table_cidr_block" {
    description = "making priv route destination_cidr_block a variable"
    default = "0.0.0.0/0"
    type    = string
}

variable "priv_route_table_name" {
    description = "making priv route table a variable"
    default = "private_route_table"
    type    = string
}
 variable "pub_route_table_cidr_block" {
    description = "making pub route table_cidr_block a variable"
    default = "0.0.0.0/0"
    type    = string
}

 variable "public_route_table_name" {
    description = "making pub route table name a variable"
    default = "public_route_table"
    type    = string
}

 variable "pub_route_destination_cidr_block" {
    description = "making pub route destination_cidr_block a variable"
    default = "0.0.0.0/0"
    type    = string
}

variable "three_tier_sg_name" {
    description = "making three_tier_sg_name a variable"
    default = "three_tier_sg"
    type    = string
}

 variable "sg_ssh_ingress_cidr_block" {
    description = "making sg_ssh_ingress_cidr_block a variable"
    default = ["0.0.0.0/0"]
    type    = list
}

 variable "sg_http_ingress_cidr_block" {
    description = "making sg_http_ingress_cidr_block a variable"
    default = ["0.0.0.0/0"]
    type    = list
}

 variable "sg_egress_cidr_block" {
    description = "making sg_egress_cidr_block a variable"
    default = ["0.0.0.0/0"]
    type    = list
}
# ec2
 variable "ami" {
    description = "making ami a variable"
    default = "ami-0be590cb7a2969726"
    type    = string
}

 variable "instance_type" {
    description = "making instance_type a variable"
    default = "t2.micro"
    type    = string
}
 
  variable "key_name" {
    description = "making key_name a variable"
    default = "threetier"
    type    = string
}

#   variable "ec2_instance_name" {
#     description = "making ec2_instance_name a variable"
#     default = "front-server.${count.index}"
#     type    = string
# }

#alb  
  variable "target_type" {
    description = "making tg target_type a variable"
    default = "instance"
    type    = string
}

variable "ip_address_type" {
    description = "making alb ip_address_type a variable"
    default = "ipv4"
    type    = string
}

variable "load_balancer_type" {
    description = "making alb load_balancer_type a variable"
    default = "application"
    type    = string
}
 
 # mysql
 variable "mysql_allocated_storage" {
    description = "making mysql allocated_storage a variable"
    default = 10
    type    = number
}

 variable "mysql_db_name" {
    description = "making mysql db_name a variable"
    default = "mydb"
    type    = string
}

 variable "mysql_engine_version" {
    description = "making mysql engine_version a variable"
    default = "8.0.28"
    type    = string
}

 variable "mysql_instance_class" {
    description = "making mysql instance_class a variable"
    default = "db.t3.micro"
    type    = string
}

 variable "mysql_username" {
    description = "making mysql username a variable"
    default = "wilon"
    type    = string
}

 variable "mysql_password" {
    description = "making mysql password a variable"
    default = "4Getmen0t"
    type    = string
}

 variable "mysql_storage_type" {
    description = "making mysql storage_type a variable"
    default = "gp2"
    type    = string
}

 variable "mysql_publicly_accessible" {
    description = "making mysql publicly_accessible a variable"
    default = false
    type    = bool
}

 variable "mysql_skip_final_snapshot" {
    description = "making mysql skip_final_snapshot a variable"
    default = true
    type    = bool
}

 variable "three_tier_sql_name" {
    description = "making mysql skip_final_snapshot a variable"
    default = "three_tier_sql"
    type    = string
}

variable "rds_mysql_subnet_group_name" {
    description = "making rds_mysql_subnet_group_name a variable"
    default = "rds_mysql_subnet_group"
    type    = string
}