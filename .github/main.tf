provider "github" {
  token = var.github_token
}

resource "github_repository" "example_repo" {
  name        = "https://github.com/Practical-DevOps-GitHub/github-terraform-task-Piter1608.git"  
  description = "my repository description."

  # Set the default branch to "develop"
  default_branch = "develop"
}

resource "github_repository_collaborator" "example_collaborator" {
  repository = github_repository.example_repo.name
  username   = "softservedata"
  permission = "push"
}

resource "github_branch_protection" "main" {
  repository = github_repository.example_repo.name
  branch     = "main"

  required_pull_request_reviews {
    dismiss_stale_reviews = false
    require_code_owner_reviews = true
    required_approving_review_count = 1
  }

  enforce_admins = true
}

resource "github_branch_protection" "develop" {
  repository = github_repository.example_repo.name
  branch     = "develop"

  required_pull_request_reviews {
    dismiss_stale_reviews = false
    required_approving_review_count = 2
  }

  enforce_admins = true
}

resource "github_repository_file" "pull_request_template" {
  repository = github_repository.example_repo.name
  file_path  = ".github/pull_request_template.md"
  content    = file("${path.module}/pull_request_template.md")
}

resource "github_repository_deploy_key" "example_deploy_key" {
  repository = github_repository.example_repo.name
  title      = "DEPLOY_KEY"
  key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoPZm6fhgpWG2eS09kshSNs8g05enu7d9Swbo/bE6eQyvRuMURapHR4Ne9NQvji0gli2AOBGt4B2xVOMRKu7lVKnqM6U8kqrh2euhANn2pYxCzVVxrGPLwXJgn/PICi5nexMhBMubWlNz8Ndok9AuKbA2IPbym7zlFOUwfB2PHkA9vtpKMxNcXXRxGSf77o+Fax9yPVirAIn+ZJAzc2tEyyhPFRBaO6Ek8wVfjE/q20rVX5Lk6znGuVDDmbIZFQcVZgdnwiY4S0zBKSKBgNesdwL5Pu2s9r3nkEElu+lv+QCNQU3RKjqxN/87NHzKwknCM2JD8j4UrvyfwtWmacYZJNjPhkC0IQCsnZPf9CmUHB/ukeN9D+WA09sON2nNZKrxMftKe4jQghP5hahKLcMGuVDoXOHzF2Hron50BDwsqAW6DQmLNmHcO4Pi0iVJGzp5kx+XMqEO5y4c0VWybmGHd/xncWa8SsbBd5SsD8zNBe74wulzl0LGHg6PG94w474U=" 
}

# Save your Terraform code in a GitHub secret named "TERRAFORM"
resource "github_actions_secret" "terraform_secret" {
  repository = github_repository.example_repo.name
  secret_name = "TERRAFORM"
  plaintext_value = file("${path.module}/main.tf")
}
resource "github_repository_webhook" "discord_webhook" {
  repository    = github_repository.example_repo.name
  name          = "discord"
  active        = true
  events        = ["pull_request"]
  configuration = jsonencode({
    url          = "https://discord.com/api/webhooks/1131858326402109441/7Af5xj-RbzuEJLi0o5_4VRRqLSPjuD6GDwK-5uz3fUpZQM_ZbJ6aWQLta0iwdbSX2th8" 
    content_type = "json"
  })
}
resource "github_actions_secret" "pat_secret" {
  repository = github_repository.example_repo.name
  secret_name = "PAT"
  plaintext_value = "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" 
}
