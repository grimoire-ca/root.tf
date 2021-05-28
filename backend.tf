terraform {
  backend "remote" {
    organization = "grimoire-ca"

    workspaces {
      name = "roottf"
    }
  }
}
