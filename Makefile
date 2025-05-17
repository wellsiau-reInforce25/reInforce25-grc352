.PHONY: install install-terraform install-tflint install-cfn-lint install-cfn-guard install-checkov install-pre-commit all

# Default target
all: install

# Install all prerequisites
install: install-terraform install-tflint install-cfn-lint install-cfn-guard install-checkov install-pre-commit

# Install Terraform
install-terraform:
	@echo "##### Installing Terraform..."
	@if command -v terraform >/dev/null 2>&1; then \
		echo "Terraform is already installed: $$(terraform --version | head -n 1)"; \
	else \
		echo "Installing Terraform..."; \
		wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg; \
		echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list; \
		sudo apt-get update && sudo apt-get install -y terraform || { echo "Failed to install Terraform. Please install manually: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli"; exit 1; }; \
	fi

# Install tflint
install-tflint:
	@echo "##### Installing tflint..."
	@if command -v tflint >/dev/null 2>&1; then \
		echo "tflint is already installed: $$(tflint --version)"; \
	else \
		echo "Installing tflint..."; \
		curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash || { echo "Failed to install tflint. Please install manually: https://github.com/terraform-linters/tflint#installation"; exit 1; }; \
	fi
	@echo "Initializing tflint plugins..."
	@tflint --init

# Install cfn-lint
install-cfn-lint:
	@echo "##### Installing cfn-lint..."
	@if command -v cfn-lint >/dev/null 2>&1; then \
		echo "cfn-lint is already installed: $$(cfn-lint --version)"; \
	else \
		sudo apt-get update && sudo apt-get install -y python3-pip && \
		pip3 install cfn-lint==1.6.1 || { echo "Failed to install cfn-lint. Please install manually: pip install cfn-lint"; exit 1; }; \
	fi

# Install cfn-guard
install-cfn-guard:
	@echo "##### Installing cfn-guard..."
	@if command -v cfn-guard >/dev/null 2>&1; then \
		echo "cfn-guard is already installed: $$(cfn-guard --version)"; \
	else \
		echo "Installing Rust and Cargo..."; \
		sudo apt-get update && sudo apt-get install -y curl build-essential && \
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
		export PATH="$$HOME/.cargo/bin:$$PATH" && \
		. "$$HOME/.cargo/env" && \
		cargo install cfn-guard || { echo "Failed to install cfn-guard. Please install manually: https://github.com/aws-cloudformation/cloudformation-guard"; exit 1; }; \
		echo "Note: You may need to add $$HOME/.cargo/bin to your PATH"; \
	fi

# Install checkov
install-checkov:
	@echo "##### Installing checkov..."
	@if command -v checkov >/dev/null 2>&1; then \
		echo "checkov is already installed: $$(checkov --version)"; \
	else \
		sudo apt-get update && sudo apt-get install -y python3-pip && \
		pip3 install checkov==3.2.410 || { echo "Failed to install checkov. Please install manually: pip install checkov"; exit 1; }; \
	fi

# Install pre-commit
install-pre-commit:
	@echo "##### Installing pre-commit..."
	@if command -v pre-commit >/dev/null 2>&1; then \
		echo "pre-commit is already installed: $$(pre-commit --version)"; \
	else \
		sudo apt-get update && sudo apt-get install -y python3-pip && \
		pip3 install pre-commit==4.2.0 || { echo "Failed to install pre-commit. Please install manually: pip install pre-commit"; exit 1; }; \
	fi
	@pre-commit install

# Setup pre-commit hooks
setup-hooks:
	@echo "##### Setting up pre-commit hooks..."
	@pre-commit install