variable "env" {
        default = "dev"
    }

variable "company" {
        default = "test"
    }

variable "region_name" {
        default = "us-central1"
    }


variable "hub_pan_subnet" {
    default ="10.0.7.0/24"
}

variable "hub_spoke1_mysql_subnet"{
    default="10.0.8.0/24"
}

variable "consumer_mysqlclient_subnet"{
    default = "10.0.10.0/24"
}