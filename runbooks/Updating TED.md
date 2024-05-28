# Runbook: Updating TED

## Introduction

**Purpose**: This runbook guides administrators through the process of updating TED.

**Prerequisites**: 
- Access to the Guardrails master account.
- Administrator privileges.
- Familiarity with AWS Console, Service Catalog, and CloudFormation services.

---

## Procedure

### Step 1: Access AWS Console

Open the AWS Console and navigate to the Service Catalog service in the region where the TED is deployed.

<!-- ![AWS Console Home Page](screenshot_aws_console.png) -->

---

### Step 2: Navigate to Provisioned Products

Select the hamburger menu in the top left and click on `Provisioned products`.

<!-- ![Navigation Menu](screenshot_navigation_menu.png) -->

---

### Step 3: Identify TED Product

There should be three or more provisioned products: TED product(s), a TEF product, and TE product(s). The TED is identifiable by a postfix that matches the database hive name.

<!-- ![Provisioned Products List](screenshot_provisioned_products_list.png) -->

---

### Step 4: Update TED Product

Select the TED product. Click `Actions` and then `Update`.

<!-- ![TED Product Details and Actions Menu](screenshot_ted_product_details.png) -->

---

### Step 5: Select Version

Choose the desired version from the `Product versions`.

<!-- ![Version Selection Page](screenshot_version_selection.png) -->

---

### Step 6: Verify Parameters

Ensure all parameters are correct. Generally, these can be left as default.

<!-- ![Parameters Verification Page](screenshot_parameters_verification.png) -->

---

### Step 7: Confirm Update

Verify the parameters again and select `Update`.

<!-- ![Update Confirmation Page](screenshot_update_confirmation.png) -->

---

### Step 8: Monitor Update

The TED provisioned product status should change to `Under Change` and the TED stack in CloudFormation will begin updating. This process typically takes a couple of minutes.

<!-- ![CloudFormation Stack Update Status](screenshot_stack_update_status.png) -->

---

## Validation

- The status of the TED stack in CloudFormation should be `UPDATE_COMPLETE` which ensures the update completed successfully.
- Confirm that the TED product `Version name` reflects the update and the status moves back to `Available`.

---

## Troubleshooting

**Common Issues**:
1. **The update process takes longer than expected**:
    - Solution: Check the CloudFormation events tab for errors or issues.
2. **Parameters need to be adjusted**:
    - Solution: Review the parameters and consult the product documentation for correct values.

---

## Conclusion

**Summary**: You have successfully updated the TED Service Catalog product.

**Next Steps**: Monitor the product for any issues post-update and document any anomalies.
