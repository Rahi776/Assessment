# Assessment
## Overview

Brief overview of the project, its purpose, and technologies used.

## Getting Started

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/your-repo.git
   cd your-repo

   Set Up AWS Credentials:
Ensure you have AWS CLI installed and configured.

Install Serverless Framework:
    npm install -g serverless
Initialize Serverless Project:
    cd Assessment
    serverless create --template aws-nodejs --path my-lambda-function
Install Node.js Dependencies:
    cd my-lambda-function
    npm install
Zip Lambda Function:
    cd my-lambda-function
    zip -r HelloWorldLambda.zip index.js
Configure Terraform:
    Update terraform/main.tf with your desired configurations.

    Run Terraform:
    cd terraform
    terraform init
    terraform apply -auto-approve
Monitor GitHub Actions:
Check the "Actions" tab on GitHub to monitor the CI/CD pipeline.