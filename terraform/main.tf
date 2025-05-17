###### PLACEHOLDER FOR TERRAFORM CONFIG ######
resource "aws_ecr_repository" "my_repository" {
  name                 = "test-repo-tf"
  image_tag_mutability = "IMMUTABLE"
}
##############################################