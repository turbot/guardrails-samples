variable "email_ids" {
  description = "Comma-seperated email IDs to send the Turbot Notifications. Example: user1@example.com,user2@example.com,user3@example.com"
  type        = string
}

variable "aws_account_budget_target" {
  description = "The budget target for this AWS Account, in US Dollars. The Budget > state is calculated by comparing this target to the Current Spend and Forecast Spend."
  type        = number
}
