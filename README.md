# CI/CD App Deployment with Terraform and GitHub Actions

[![Deploy to Azure](https://github.com/godsofhell/CI-CD-app-deployment/actions/workflows/deploy.yml/badge.svg)](https://github.com/godsofhell/CI-CD-app-deployment/actions/workflows/deploy.yml)

A complete CI/CD pipeline demonstration that automatically deploys infrastructure and applications to Azure using Terraform and GitHub Actions.

## 🎯 Project Overview

This project demonstrates a fully automated deployment pipeline that:
- **Provisions Azure infrastructure** using Terraform (Infrastructure as Code)
- **Builds a .NET 8.0 web application** (ASP.NET Core Razor Pages)
- **Deploys everything to Azure** automatically on every code push
- **No manual intervention required** - push code and it goes live!

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     GitHub Repository                    │
│  ┌──────────────┐              ┌────────────────────┐   │
│  │ Application  │              │  Infrastructure    │   │
│  │  (.NET 8.0)  │              │   (Terraform)      │   │
│  └──────────────┘              └────────────────────┘   │
└────────────────────┬────────────────────────────────────┘
                     │ Git Push
                     ↓
        ┌────────────────────────┐
        │   GitHub Actions       │
        │   (CI/CD Pipeline)     │
        └────────────────────────┘
                     │
        ┌────────────┴────────────┐
        ↓                         ↓
┌───────────────┐         ┌──────────────┐
│  Terraform    │         │   .NET App   │
│  Apply        │         │   Build      │
└───────────────┘         └──────────────┘
        ↓                         ↓
┌─────────────────────────────────────────┐
│           Azure Cloud                    │
│  ┌────────────────────────────────────┐ │
│  │  Resource Group: web-grp           │ │
│  │  Location: UK South                │ │
│  │  ┌──────────────────────────────┐  │ │
│  │  │  App Service Plan (F1 Free)  │  │ │
│  │  └──────────────────────────────┘  │ │
│  │  ┌──────────────────────────────┐  │ │
│  │  │  Web App: webapp781929       │  │ │
│  │  │  Runtime: .NET 8.0           │  │ │
│  │  └──────────────────────────────┘  │ │
│  └────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

## 📁 Project Structure

```
CI-CD-app-deployment/
├── .github/
│   └── workflows/
│       └── deploy.yml              # GitHub Actions CI/CD pipeline
├── application/
│   └── webapp/                     # ASP.NET Core 8.0 Application
│       ├── Pages/                  # Razor Pages (Index, Privacy, Error)
│       ├── wwwroot/                # Static files (CSS, JS, libraries)
│       ├── Program.cs              # Application entry point
│       ├── appsettings.json        # App configuration
│       └── webapp.csproj           # Project file
├── infrastructure/                 # Terraform Infrastructure as Code
│   ├── main.tf                    # Resource definitions
│   ├── providers.tf               # Azure provider configuration
│   ├── variables.tf               # Input variables
│   └── terraform.tfvars           # Variable values
├── webapp.sln                     # Visual Studio solution file
└── README.md                      # This file
```

## 🚀 Quick Start

### Prerequisites

- Git installed
- GitHub account
- Azure subscription
- Azure Service Principal (for authentication)

### 1. Clone the Repository

```bash
git clone https://github.com/godsofhell/CI-CD-app-deployment.git
cd CI-CD-app-deployment
```

### 2. Update Configuration

Edit `infrastructure/terraform.tfvars`:
```hcl
resource_group_name = "your-resource-group"
location = "UK South"  # Or your preferred region
webapp_name = "your-unique-app-name"  # Must be globally unique
service_details = ["your-service-plan", "F1", "Windows"]
```

### 3. Update Credentials

Edit `infrastructure/providers.tf` with your Azure credentials:
```hcl
provider "azurerm" {
  features {}
  client_id       = "your-client-id"
  client_secret   = "your-client-secret"
  tenant_id       = "your-tenant-id"
  subscription_id = "your-subscription-id"
}
```

Edit `.github/workflows/deploy.yml` with the same credentials.

### 4. Push to GitHub

```bash
git add .
git commit -m "Configure deployment"
git push origin master
```

### 5. Watch the Magic! ✨

- Go to your GitHub repository → **Actions** tab
- Watch the workflow run automatically
- After completion, visit: `https://your-app-name.azurewebsites.net`

## 🔧 Local Development

### Run Locally (Without Deployment)

```bash
cd application/webapp
dotnet restore
dotnet build
dotnet run
```

Visit: `https://localhost:5001`

### Test Terraform Locally

```bash
cd infrastructure
terraform init
terraform plan    # Preview changes
terraform apply   # Deploy resources
```

## 📋 CI/CD Pipeline Details

### Workflow Triggers

The pipeline runs automatically on:
- ✅ Push to `main` or `master` branch
- ✅ Pull requests (plan only, no deployment)
- ✅ Manual trigger via GitHub Actions UI

### Pipeline Stages

#### **Stage 1: Terraform Infrastructure** 
```yaml
1. Checkout code
2. Setup Terraform
3. Format check
4. Initialize Terraform
5. Validate configuration
6. Plan changes (PR only)
7. Apply infrastructure (main/master only)
```

**Creates:**
- Azure Resource Group
- App Service Plan (F1 Free tier)
- Windows Web App (.NET 8.0 runtime)

#### **Stage 2: Build & Deploy Application**
```yaml
1. Checkout code
2. Setup .NET 8.0 SDK
3. Restore dependencies
4. Build application (Release mode)
5. Publish application
6. Login to Azure
7. Deploy to Web App
8. Logout from Azure
```

**Deploys:**
- Compiled .NET application to Azure Web App

### Environment Variables

```yaml
DOTNET_VERSION: '8.0.x'               # .NET SDK version
AZURE_WEBAPP_NAME: 'webapp781929'     # Azure Web App name
AZURE_WEBAPP_PACKAGE_PATH: 'application/webapp'
TERRAFORM_WORKING_DIR: 'infrastructure'
```

## 🛠️ Technologies Used

| Technology | Purpose | Version |
|-----------|---------|---------|
| **Terraform** | Infrastructure as Code | Latest |
| **Azure** | Cloud Platform | - |
| **.NET** | Application Framework | 8.0 |
| **ASP.NET Core** | Web Framework | 8.0 |
| **Razor Pages** | UI Framework | - |
| **GitHub Actions** | CI/CD Pipeline | - |
| **PowerShell** | Scripting | 5.1+ |

## 📦 Azure Resources Created

```hcl
# Resource Group
resource_group_name = "web-grp"
location           = "UK South"

# App Service Plan
name    = "serviceplan5000991"
sku     = "F1"              # Free tier
os_type = "Windows"

# Web App
name    = "webapp781929"
runtime = ".NET 8.0"
```

**Monthly Cost:** **FREE** (F1 tier)

## 🔐 Security Considerations

### ⚠️ Current Setup (Development/Learning)
```
❌ Credentials hardcoded in repository
❌ Visible in GitHub (if public repo)
✅ Suitable for learning and testing
❌ NOT recommended for production
```

### ✅ Production Best Practices

1. **Use GitHub Secrets**
   - Store credentials in: Settings → Secrets → Actions
   - Reference with: `${{ secrets.SECRET_NAME }}`

2. **Use Azure Managed Identity**
   - No credentials needed
   - Azure handles authentication automatically

3. **Use Azure Key Vault**
   - Store secrets centrally
   - Rotate credentials regularly

4. **Enable Branch Protection**
   - Require PR reviews
   - Require status checks to pass
   - Restrict who can push to main

## 🎯 Deployment Workflow

```mermaid
graph LR
    A[Developer] -->|git push| B[GitHub]
    B -->|Trigger| C[GitHub Actions]
    C -->|Terraform| D[Azure Infrastructure]
    C -->|Build & Deploy| E[Azure Web App]
    D -->|Ready| E
    E -->|Live| F[End Users]
```

## 📊 Monitoring & Logs

### View GitHub Actions Logs
1. Go to repository → **Actions** tab
2. Click on workflow run
3. View logs for each job and step

### View Azure Logs
```bash
# Using Azure CLI
az webapp log tail --name webapp781929 --resource-group web-grp

# Or visit Azure Portal
# App Service → Log stream
```

## 🐛 Troubleshooting

### Pipeline Fails on Terraform Init
**Problem:** Authentication failure  
**Solution:** Verify Azure credentials in `providers.tf`

### Pipeline Fails on Terraform Apply
**Problem:** Resource already exists or quota exceeded  
**Solution:** 
- Check if resource group already exists
- Verify subscription limits
- Run `terraform destroy` to clean up

### Pipeline Fails on .NET Build
**Problem:** Wrong .NET version  
**Solution:** Ensure `webapp.csproj` uses `net8.0`

### Pipeline Fails on Azure Deploy
**Problem:** Web app name not unique  
**Solution:** Change `webapp_name` in `terraform.tfvars`

### Application Shows 500 Error
**Problem:** Runtime mismatch  
**Solution:** Ensure Terraform and app both use .NET 8.0

## 📚 Learn More

### GitHub Actions
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)

### Terraform
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Learn](https://learn.hashicorp.com/terraform)

### Azure
- [Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/)
- [Azure CLI Reference](https://learn.microsoft.com/en-us/cli/azure/)

### .NET
- [ASP.NET Core Documentation](https://learn.microsoft.com/en-us/aspnet/core/)
- [.NET 8.0 Release Notes](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-8)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is for educational purposes. Feel free to use and modify as needed.

## 👨‍💻 Author

**godsofhell**
- GitHub: [@godsofhell](https://github.com/godsofhell)
- Repository: [CI-CD-app-deployment](https://github.com/godsofhell/CI-CD-app-deployment)

## 🙏 Acknowledgments

- Microsoft Azure for cloud infrastructure
- HashiCorp for Terraform
- GitHub for Actions platform
- The open-source community

---

## 🎓 What You'll Learn

By studying this project, you'll understand:

✅ **Infrastructure as Code** with Terraform  
✅ **CI/CD Pipelines** with GitHub Actions  
✅ **Azure Cloud** deployment and management  
✅ **.NET Application** development and deployment  
✅ **DevOps Best Practices** and automation  
✅ **YAML** configuration for workflows  
✅ **Git** version control integration  

---

## 📞 Support

If you encounter issues:
1. Check the **Troubleshooting** section above
2. Review **GitHub Actions** logs
3. Consult **Azure Portal** for resource status
4. Open an **Issue** in the repository

---

**⭐ If this project helped you learn CI/CD, please give it a star!**

**Live Demo:** https://webapp781929.azurewebsites.net
=======
# GitHub Actions CI/CD Deployment Guide

## Overview
This project uses GitHub Actions to automatically deploy infrastructure (via Terraform) and the .NET web application to Azure.

## 🚀 How CI/CD Works

### Workflow Triggers
The deployment pipeline runs on:
- **Push to `main` or `master` branch** → Full deployment
- **Pull Request** → Terraform plan only (preview changes)
- **Manual trigger** → Via GitHub Actions UI

### Pipeline Stages

#### 1. Terraform Infrastructure (Job 1)
- ✅ Validates Terraform configuration
- ✅ Creates Azure Resource Group
- ✅ Provisions App Service Plan (F1 Free tier)
- ✅ Creates Windows Web App
- ✅ Only runs `terraform apply` on main/master branch

#### 2. Build & Deploy Application (Job 2)
- ✅ Builds .NET 10.0 application
- ✅ Publishes release package
- ✅ Deploys to Azure Web App
- ✅ Only runs after infrastructure is ready
- ✅ Only runs on main/master branch

## 📋 Setup Instructions

### Step 1: Configure GitHub Secrets

Go to your GitHub repository → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

Add the following secrets:

| Secret Name | Value | Description |
|------------|-------|-------------|
| `AZURE_CLIENT_ID` | `4100c47e-4d39-4cd6-9af9-8ce7c5e5142d` | Azure Service Principal App ID |
| `AZURE_CLIENT_SECRET` | `G0J8Q~EX9URj2~AKeNImRjh-arz7muTTvigBCduh` | Azure Service Principal Secret |
| `AZURE_TENANT_ID` | `8cddfc2a-1f62-42be-a522-8ae3ca2fc894` | Azure AD Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | `2ab4f266-3113-46c7-9a11-16bcb8ae5659` | Azure Subscription ID |

⚠️ **IMPORTANT**: After adding secrets to GitHub, you can delete the original values from `providers.tf` (already done).

### Step 2: Push to GitHub

```bash
git add .
git commit -m "Add GitHub Actions CI/CD pipeline"
git push origin main
```

### Step 3: Monitor Deployment

1. Go to **Actions** tab in your GitHub repository
2. Watch the workflow progress
3. Check for any errors

## 🔍 Workflow Details

### Terraform Job
```yaml
- Checkout code
- Setup Terraform
- Format check
- Initialize Terraform
- Validate configuration
- Plan (on PR only)
- Apply (on main/master only)
```

### Build & Deploy Job
```yaml
- Checkout code
- Setup .NET 10.0
- Restore dependencies
- Build application
- Publish application
- Login to Azure
- Deploy to Web App
- Logout
```

## 🌐 Access Your Application

After successful deployment, your application will be available at:
```
https://webapp781929.azurewebsites.net
```

## 🛠️ Manual Deployment (Alternative)

If you need to deploy manually:

### Terraform
```powershell
cd infrastructure
terraform init
terraform plan
terraform apply
```

### Application
```powershell
cd application/webapp
dotnet publish -c Release -o ./publish
az webapp deployment source config-zip `
  --resource-group web-grp `
  --name webapp781929 `
  --src publish.zip
```

## 📊 Monitoring

- **Azure Portal**: Monitor application logs and metrics
- **GitHub Actions**: View deployment history and logs
- **Application Insights**: (Not configured yet - consider adding)

## 🔐 Security Best Practices

✅ Credentials removed from source code  
✅ Using GitHub Secrets for sensitive data  
✅ Service Principal authentication  
⚠️ Consider using Azure Managed Identity in production  
⚠️ Enable branch protection rules  
⚠️ Require PR reviews before merging  

## 🐛 Troubleshooting

### Pipeline Fails on Terraform Init
- Check if secrets are correctly configured
- Verify Service Principal has Contributor role on subscription

### Deployment Fails
- Ensure webapp name `webapp781929` is globally unique
- Check if resource group exists
- Verify App Service Plan is in correct region

### Application Not Starting
- Check Azure Portal logs: **App Service** → **Log stream**
- Verify .NET 10.0 runtime is supported (may need to update to stable version)

## � Learn More

### GitHub Actions
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)

### Terraform
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Learn](https://learn.hashicorp.com/terraform)

### Azure
- [Azure App Service](https://learn.microsoft.com/en-us/azure/app-service/)
- [Azure CLI Reference](https://learn.microsoft.com/en-us/cli/azure/)

### .NET
- [ASP.NET Core Documentation](https://learn.microsoft.com/en-us/aspnet/core/)
- [.NET 8.0 Release Notes](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-8)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is for educational purposes. Feel free to use and modify as needed.

## 👨‍� Author

**godsofhell**
- GitHub: [@godsofhell](https://github.com/godsofhell)
- Repository: [CI-CD-app-deployment](https://github.com/godsofhell/CI-CD-app-deployment)

## 🙏 Acknowledgments

- Microsoft Azure for cloud infrastructure
- HashiCorp for Terraform
- GitHub for Actions platform
- The open-source community

---

## 🎓 What You'll Learn

By studying this project, you'll understand:

✅ **Infrastructure as Code** with Terraform  
✅ **CI/CD Pipelines** with GitHub Actions  
✅ **Azure Cloud** deployment and management  
✅ **.NET Application** development and deployment  
✅ **DevOps Best Practices** and automation  
✅ **YAML** configuration for workflows  
✅ **Git** version control integration  

---

## 📞 Support

If you encounter issues:
1. Check the **Troubleshooting** section above
2. Review **GitHub Actions** logs
3. Consult **Azure Portal** for resource status
4. Open an **Issue** in the repository

---

**⭐ If this project helped you learn CI/CD, please give it a star!**

**Live Demo:** https://webapp781929.azurewebsites.net
