provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "NORM" {
    cidr_block           = "${var.cidr_block.NORM-VPC}"
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"

    tags {
        "Environment" = "ALL"
        "Name" = "NORM"
    }
}

resource "aws_eip" "NORM-Private1" {
    vpc = true
}

resource "aws_eip" "NORM-Private2" {
    vpc = true
}

resource "aws_eip" "NORM-Private3" {
    vpc = true
}

resource "aws_internet_gateway" "NORM-IGW" {
    vpc_id = "${aws_vpc.NORM.id}"

    tags {
        "Environment" = "All"
        "Name" = "NORM-IGW"
    }
}

resource "aws_nat_gateway" "NORM-Private-1" {
    allocation_id = "${aws_eip.NORM-Private1.id}"
    subnet_id = "${aws_subnet.NORM-Private-1.id}"
}
    
resource "aws_nat_gateway" "NORM-Private-2" {
    allocation_id = "${aws_eip.NORM-Private2.id}"
    subnet_id = "${aws_subnet.NORM-Private-2.id}"
}

resource "aws_nat_gateway" "NORM-Private-3" {
    allocation_id = "${aws_eip.NORM-Private3.id}"
    subnet_id = "${aws_subnet.NORM-Private-3.id}"
}

resource "aws_network_interface" "norm-prv-az1" {
    subnet_id = "${aws_subnet.NORM-Private-1.id}"
    private_ips = ["${var.nics.norm-prv-az1}"]
}

resource "aws_network_interface" "norm-prv-az2" {
    subnet_id = "${aws_subnet.NORM-Private-2.id}"
    private_ips = ["${var.nics.norm-prv-az2}"]
}

resource "aws_network_interface" "norm-prv-az3" {
    subnet_id = "${aws_subnet.NORM-Private-3.id}"
    private_ips = ["${var.nics.norm-prv-az3}"]
}

# associate with all public subnets
# associate with public gateway
resource "aws_route_table" "NORM-RoutePublic" {
    vpc_id     = "${aws_vpc.NORM.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.NORM-IGW.id}"
    }

    route {
        cidr_block = "172.31.0.0/16"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.phitovpc.id}"
    }

    tags {
        "Name" = "NORM-RoutePublic"
        "Environment" = "All"
    }
}

resource "aws_route_table_association" "NORM-Public-1" {
    subnet_id = "${aws_subnet.NORM-Public-1.id}"
    route_table_id = "${aws_route_table.NORM-RoutePublic.id}"
}


resource "aws_route_table_association" "NORM-Public-2" {
    subnet_id = "${aws_subnet.NORM-Public-2.id}"
    route_table_id = "${aws_route_table.NORM-RoutePublic.id}"
}

resource "aws_route_table_association" "NORM-Public-3" {
    subnet_id = "${aws_subnet.NORM-Public-3.id}"
    route_table_id = "${aws_route_table.NORM-RoutePublic.id}"
}

resource "aws_route_table" "NORM-Route-Private-1" {
    vpc_id     = "${aws_vpc.NORM.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.NORM-Private-1.id}"
    }

    route {
        cidr_block = "172.31.0.0/16"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.phitovpc.id}"

     }

    tags {
        "Name" = "NORM-Route-Private-1"
        "Environment" = "All"
    }
}

resource "aws_route_table_association" "NORM-Route-Private-1" {
    subnet_id = "${aws_subnet.NORM-Private-1.id}"
    route_table_id = "${aws_route_table.NORM-Route-Private-1.id}"
}


resource "aws_route_table" "NORM-Route-Private-2" {
    vpc_id     = "${aws_vpc.NORM.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.NORM-Private-2.id}"
    }

    route {
        cidr_block = "172.31.0.0/16"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.phitovpc.id}"

     }

    tags {
        "Environment" = "All"
        "Name" = "NORM-Route-Private-2"
    }
}


resource "aws_route_table_association" "NORM-Route-Private-2" {
    subnet_id = "${aws_subnet.NORM-Private-2.id}"
    route_table_id = "${aws_route_table.NORM-Route-Private-2.id}"
}

resource "aws_route_table" "NORM-Route-Private-3" {
    vpc_id     = "${aws_vpc.NORM.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.NORM-Private-3.id}"
    }


    route {
        cidr_block = "172.31.0.0/16"
        vpc_peering_connection_id = "${aws_vpc_peering_connection.phitovpc.id}"

     }

    tags {
        "Environment" = "All"
        "Name" = "NORM-Route-Private-3"
    }
}

resource "aws_route_table_association" "NORM-Route-Private-3" {
    subnet_id = "${aws_subnet.NORM-Private-3.id}"
    route_table_id = "${aws_route_table.NORM-Route-Private-3.id}"
}

resource "aws_subnet" "NORM-Public-1" {
    vpc_id                  = "${aws_vpc.NORM.id}"
    cidr_block              = "${var.cidr_block.NORM-Public1}"
    availability_zone       = "${var.az1}"
    map_public_ip_on_launch = true

    tags {
        "Name" = "NORM-Public-1"
        "Environment" = "All"
    }
}

resource "aws_subnet" "NORM-Public-2" {
    vpc_id                  = "${aws_vpc.NORM.id}"
    cidr_block              = "${var.cidr_block.NORM-Public2}"
    availability_zone       = "${var.az2}"
    map_public_ip_on_launch = true

    tags {
        "Name" = "NORM-Public-2"
        "Environment" = "All"
    }
}

resource "aws_subnet" "NORM-Public-3" {
    vpc_id                  = "${aws_vpc.NORM.id}"
    cidr_block              = "${var.cidr_block.NORM-Public3}"
    availability_zone       = "${var.az3}"
    map_public_ip_on_launch = true

    tags {
        "Environment" = "All"
        "Name" = "NORM-Public-3"
    }
}

resource "aws_subnet" "NORM-Private-1" {
    vpc_id                  = "${aws_vpc.NORM.id}"
    cidr_block              = "${var.cidr_block.NORM-Private1}"
    availability_zone       = "${var.az1}"
    map_public_ip_on_launch = false

    tags {
        "Name" = "NORM-Private-1"
        "Environment" = "All"
    }
}

resource "aws_subnet" "NORM-Private-2" {
    vpc_id                  = "${aws_vpc.NORM.id}"
    cidr_block              = "${var.cidr_block.NORM-Private2}"
    availability_zone       = "${var.az2}"
    map_public_ip_on_launch = false

    tags {
        "Name" = "NORM-Private-2"
        "Environment" = "All"
    }
}

resource "aws_subnet" "NORM-Private-3" {
    vpc_id                  = "${aws_vpc.NORM.id}"
    cidr_block              = "${var.cidr_block.NORM-Private3}"
    availability_zone       = "${var.az3}"
    map_public_ip_on_launch = false

    tags {
        "Name" = "NORM-Private-3"
        "Environment" = "All"
    }
}

resource "aws_elasticache_subnet_group" "NORM-ELASTICACHE" {
    name = "norm-elasticache" 
    description = "NORM ELASTICACHE SUBNETS"
   subnet_ids = ["${aws_subnet.NORM-Private-1.id}", "${aws_subnet.NORM-Private-2.id}", "${aws_subnet.NORM-Private-3.id}"]
}

resource "aws_db_subnet_group" "NORM-RDS" {
    name = "norm-rds" 
    description = "NORM RDS SUBNETS"
    subnet_ids = ["${aws_subnet.NORM-Private-1.id}", "${aws_subnet.NORM-Private-2.id}", "${aws_subnet.NORM-Private-3.id}"]
}