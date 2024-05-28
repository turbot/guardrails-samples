# Runbook: Installing TE

## Introduction

**Purpose**: This runbook guides administrators through the process of installing TE.

**Prerequisites**: 
- Access to the Guardrails master account.
- Administrator privileges.
- Familiarity with AWS Console, Service Catalog, and CloudFormation services.

---

## Procedure

### Step 1: Access AWS Console

Open the AWS Console and navigate to the Service Catalog service in the region to deploy TE.

<!-- ![AWS Console Home Page](screenshot_aws_console.png) -->

---

### Step 2: Navigate to Products

Select the hamburger menu in the top left and click on `Products`.

<!-- ![Navigation Menu](screenshot_navigation_menu.png) -->

---

### Step 3: Identify the TE Product

Select `Turbot Guardrails Enterprise` from the products list and click `Launch Product`.

<!-- ![Service Catalog Products List](screenshot_service_catalog_products_list.png) -->

---

### Step 4: Name the TE Product

Select the desired version and name the provisioned product with the version number prefixed with `te`.

<!-- ![Provisioned Product Naming](screenshot_provisioned_product_naming.png) -->

---

### Step 5: Verify Parameters

Ensure all parameters are correct. Generally, these can be left as default.

<!-- ![Parameters Verification Page](screenshot_parameters_verification.png) -->

---

### Step 6: Launch Product

Verify the parameters again and select `Launch product`.

<!-- ![Update Confirmation Page](screenshot_update_confirmation.png) -->

---

### Step 7: Monitor Installation

The installed TE version should appear in `Provisioned products` with the status `Under change` and a new CloudFormation stack should be created with the status `CREATING`.

<!-- ![Verification Page](screenshot_verification_page.png) -->

---

## Validation

The TE provisioned product status should change to `Available` and the CloudFormation stack status should be `CREATE_COMPLETE` to ensure the installation completed successfully.

<!-- ![CloudFormation Stack Update Status](screenshot_stack_update_status.png) -->

---

## Troubleshooting

**Common Issues**:
1. **Installation fails or takes too long**:
    - Solution: Check the CloudFormation events tab for errors or issues.
2. **Parameters need adjustment**:
    - Solution: Review the parameters and consult the product documentation for correct values.

---

## Conclusion

**Summary**: You have successfully installed the TE Service Catalog product.

**Next Steps**: Monitor the product for any issues post-installation and document any anomalies.
