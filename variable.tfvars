region = "us-east-2"
name = "demo"
instance_type = "t2.micro"
cidr_block = "10.10.0.0/16"
cidr_block_subnet_1 = "10.10.0.0/24"
cidr_block_subnet_2 = "10.10.1.0/24"
cidr_block_subnet_3 = "10.10.2.0/24"
cidr_block_subnet_4 = "10.10.3.0/24"
az_1 = "us-east-2a"
az_2 = "us-east-2b"
ami = "ami-0862be96e41dcbf74"
demo_key_name = "demo-key"
demo_key_value = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnWfXdWECxjE2in1OnLRPMT2CHRk/Z1LQlrPTMl3EdoxeowRwA3jlmVEWjkg1+Q0DShqMUNR2uFP4J64Il2R6/cJk8cDCIXmAoiI0f6klxAM3XkwRirhr4Qd8N0Ujqc+NxABUo7CK6lEuQ9UIFBXeaWl9VzSLPoxFIU1DY8xnjAjqAFrIkTmZ6aG+827h5CiB9NwoV345C7d3LWlQPiur2NtkT0aglwSxzIeyIEx3p9C/msYTvBijBojxnbpeUfGVi8q4B1BbUZHCRWynNvkMDNH01UlUJFUuxAMk3nF/ClP3VqBx7fHWr6d9MzhCWv2jAq9/lyRMpRVh3euNWwKrNl1Ld5XsT6nB8fHCbjB++0mFUNoZN2OrbJNvNJBe2TzS8/YO067gq5TdUrxPGqB42GTxKoSNEiDmAcZD6ogPhj3pr3u5V6cpb0/0yd7L2xTd8VYBx5jFp9deHrCY+GMqcp5Y/ln4JnARyCdWeRbvTvSI5esoYhokMkQ/ok77llHM= ssankar1@ussd-ofcmc6821.lan"
desired_capacity = 2
max_size = 5
min_size = 2
Environment = "production"