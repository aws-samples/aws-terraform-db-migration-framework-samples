variable "env" {
  type = string
}

variable "port" {
  type = string
}

variable "vpc_id" {
  type = string
}


variable "db_name" {
  type = string
}



#Security Group 

#Variable for sg
variable "sg_ports" {
  type   = list(any)
}

variable "cidr_blocks" {
  type = list(any)
}



#Subnet_IDs
variable "subnet_ids" {
  type = list(any)
}




#Region
variable "region" {
  type = string
}

#Project-Code
variable "project_code" {
  type = string
}

variable "protocol" {
  type = string
  default = "TCP"
}

#Client-Name
variable "client" {
  type = string
}

#Parameter group
variable "parameter_group_name" {
  type = string
}

variable "tgt_db_secret" {
  description = "Secret name for the Source DB"
  type        = string
  default     = ""
}

#password
variable "password" {
  type = string
  default = ""
  #  sensitive = true
}

#Username
variable "username" {
  type = string
  default = ""
  #  sensitive = true
}

#RDS_Name
variable "name" {
  type = string
}

variable "allocated_storage" {
  type = string
}
variable "max_allocated_storage" {
  type = string
}
variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}
variable "instance_class" {
  type = string
}
variable "identifier" {
  type = string
}
variable "family" {
  type = string
}

variable "backup_retention_period" {
  type = string
}
variable "transit" {
  type = string
}
