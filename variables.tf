variable region {
  description = "Region"
  default = "eu-central-1"
}
variable "key-name" {
  default = "Java-App-Project-KP"
  description = "EC2 acces key pair"
}
variable "security-group" {
  default = "Java-App-Project-SecGr"
  description = "Security group for AWS Instances"
}