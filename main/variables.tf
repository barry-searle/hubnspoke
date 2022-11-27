variable "var_project" {
        default = "hubnspoke"
    }

variable "var_env" {
        default = "dev"
    }
variable "var_company" { 
        default = "acme-corp"
    }

variable "var_region" { 
        default = "us-central1"
    }

variable "var_zone" { 
        default = "us-central1-a"
    }

variable "hub_pan_subnet" {
        default = "10.0.7.0/24"
    }
variable "hub_spoke1_mysql_subnet" {
        default = "10.0.8.0/24"
    }
variable "consumer_mysqlclient_subnet" {
        default = "10.0.10.0/24"
    }
