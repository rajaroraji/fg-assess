variable "security_group_id" {}
variable "rule_type" {
  description = "Specifies ingress or egress rule"
}
variable "cidr_blocks" {}
variable "protocol" {
  description = "Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
}
variable "to_port" {}
variable "from_port" {}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule