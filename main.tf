terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = "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"
  owner = "Practical-DevOps-GitHub"
}

resource "github_branch" "develop" {
  repository = "github-terraform-task-Piter1608"
  branch     = "develop"
}

resource "github_branch_default" "default"{
  repository = "github-terraform-task-Piter1608"
  branch     = github_branch.develop.branch
}
resource "github_repository_collaborator" "example_collaborator" {
  repository = "github-terraform-task-Piter1608"
  username   = "softservedata"
  permission = "push"
}
resource "github_repository_deploy_key" "deploy_key" {
  repository = "github-terraform-task-Piter1608"
  title      = "DEPLOY_KEY"
  key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoPZm6fhgpWG2eS09kshSNs8g05enu7d9Swbo/bE6eQyvRuMURapHR4Ne9NQvji0gli2AOBGt4B2xVOMRKu7lVKnqM6U8kqrh2euhANn2pYxCzVVxrGPLwXJgn/PICi5nexMhBMubWlNz8Ndok9AuKbA2IPbym7zlFOUwfB2PHkA9vtpKMxNcXXRxGSf77o+Fax9yPVirAIn+ZJAzc2tEyyhPFRBaO6Ek8wVfjE/q20rVX5Lk6znGuVDDmbIZFQcVZgdnwiY4S0zBKSKBgNesdwL5Pu2s9r3nkEElu+lv+QCNQU3RKjqxN/87NHzKwknCM2JD8j4UrvyfwtWmacYZJNjPhkC0IQCsnZPf9CmUHB/ukeN9D+WA09sON2nNZKrxMftKe4jQghP5hahKLcMGuVDoXOHzF2Hron50BDwsqAW6DQmLNmHcO4Pi0iVJGzp5kx+XMqEO5y4c0VWybmGHd/xncWa8SsbBd5SsD8zNBe74wulzl0LGHg6PG94w474U="
}
resource "github_actions_environment_secret" "pat_secret" {
  repository = "github-terraform-task-Piter1608"
  secret_name       = "PAT"
  plaintext_value   = "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"
}


