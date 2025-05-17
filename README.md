# Infrastructure as Code Template Repository with AWS CloudFormation and Terraform Support

This repository provides a standardized template for Infrastructure as Code (IaC) implementations using both AWS CloudFormation and Terraform. It includes comprehensive CI/CD workflows, security checks, and code quality enforcement to ensure reliable and secure infrastructure deployments.

The repository implements industry best practices for infrastructure management including automated linting, security scanning with Checkov, and pre-commit hooks for code quality. It supports both AWS CloudFormation and Terraform deployments with proper version control integration and automated workflow checks through GitHub Actions.

### Full solution

* The `main` branch is intended as part of walkthrough in the workshop.
* The `solution` branch contains the full solution for the workshop.

## Repository Structure

```
.
├── cloudformation/         # CloudFormation templates and related resources
│   └── template.yaml       # Main CloudFormation template file
├── terraform/              # Terraform configuration files
│   ├── main.tf             # Main Terraform configuration
│   ├── providers.tf        # AWS provider configurations
│   └── version.tf          # Terraform version and backend configuration
├── .github/
│   └── workflows/                # GitHub Actions workflow definitions
│       ├── on-push.yaml          # Workflow for push events
│       └── on-pull-request.yaml  # Workflow for pull requests
└── .config/
    ├── checkov/            # Config for checkov
    ├── cfn-guard/          # Config for cfn-guard
    └── tf-lint/            # Config for tf-lint
```

## Usage Instructions

### Prerequisites
- AWS CLI installed and configured
- Git installed
- GitHub repository created from this template

### Installation

1. Fork this repository into your own GitHub.

2. Clone the repository:

```bash
git clone https://github.com/your-org/your-repo.git
cd your-repo
```

3. Set up the development environment:

```bash
make install
```

4. Configure AWS credentials:

```bash
aws configure
```

## Data Flow

The infrastructure deployment process follows a structured workflow from local development through CI/CD pipelines to production deployment.

```ascii
[Local Development] -> [Pre-commit Hooks] -> [GitHub Actions] -> [AWS Infrastructure]
     |                    |                       |                     |
     v                    v                       v                     v
Code Changes     -->  Code Quality    -->    Validation     -->    Deployment
                     Checks & Linting     Security Scanning
```

Key Component Interactions:

1. Local development triggers pre-commit hooks for initial validation
2. Git push triggers GitHub Actions workflows
3. Workflows perform format checking and linting
4. Security scanning with Checkov validates infrastructure
5. Pull request checks ensure code quality
6. Successful checks allow deployment to AWS
7. Infrastructure changes are tracked in version control
