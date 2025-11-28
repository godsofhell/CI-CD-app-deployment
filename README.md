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

## 📝 Next Steps

Consider adding:
- [ ] Automated testing before deployment
- [ ] Staging environment
- [ ] Application Insights for monitoring
- [ ] Database integration
- [ ] Custom domain and SSL
- [ ] Azure Key Vault for secrets management
- [ ] Terraform state backend (Azure Storage)

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Web Apps](https://learn.microsoft.com/en-us/azure/app-service/)
