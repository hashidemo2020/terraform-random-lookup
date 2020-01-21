# Source the data from hashijit/settings workspace
data "terraform_remote_state" "info" {
  backend = "remote"
  config {
    organization = "hashijit"
    workspaces {
      name = "settings"
    }
  }
}

output "connection_string" {
  value = "${data.terraform_remote_state.info.uuid}:${data.terraform_remote_state.info.password}@${data.terraform_remote_state.info.server}"
}
