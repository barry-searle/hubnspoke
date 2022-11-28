variable "env" {
        default = "dev"
    }

variable "company" {
        default = "test"
    }

variable "region_name" {
        default = "test"
    }

variable "user"{
    type=string
}

variable "password"{
    type=string
    default=""
}

variable hub_pan_subnet{
    default="10.0.7.0/24"
}

variable hub_spoke1_mysql_subnet{
    default = "10.0.10.0/20"
}

variable "network_self_link" {
        default = "test"
    }

variable "consumer_subnet"{
    default = "10.0.10.0/20"
}