# Detailed Guide: Configuring the JIRA Connector in GCP Application Integration

This guide provides a step-by-step walkthrough for configuring the JIRA Cloud Connector in GCP.

### **Prerequisites**
1.  You have a JIRA Cloud account with administrative privileges.
2.  You have generated a JIRA API token. (See Atlassian's documentation: [Manage API tokens for your Atlassian account](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/))
3.  You have successfully run the `gcloud` commands to store this API token in GCP Secret Manager under the name `jira-api-token`.

---

### **Step-by-Step Configuration in the GCP Console**

#### **Part 1: Find the Application Integration Service**

1.  **Open the GCP Console:** Go to [console.cloud.google.com](https://console.cloud.google.com).
2.  **Use the Search Bar:** The easiest way to find the service is to use the search bar at the top of the page. Type "**Application Integration**" and select the matching service from the results.
3.  **Enable the API:** If you haven't used it before, you may be prompted to **Enable** the `integrations.googleapis.com` API. Go ahead and enable it.

#### **Part 2: Navigate to the Connectors Page**

1.  **Open the Connectors UI:** In the Application Integration left-hand navigation menu, click on **Connectors**.
2.  **Go to the Marketplace:** The Connectors page might show you existing connections. We need to add a new one from the marketplace. Click the **"+ CREATE NEW"** or **"Go to Marketplace"** button.

#### **Part 3: Find and Configure the JIRA Connector**

1.  **Search for JIRA:** In the Connector Marketplace, use the search bar to find "**JIRA**".
2.  **Select the JIRA Connector:** Click on the JIRA connector from the search results. You will be taken to its details page.
3.  **Initiate Configuration:** Click the **"Configure"** or **"Create Connection"** button.

#### **Part 4: Fill in the Connection Details**

This is the most critical part. You will see a form to create the connection. Fill it out as follows:

1.  **Location:** Select the GCP region where you want to deploy the connection (e.g., `us-central1`). This should match the region of your other resources.
2.  **Connection Name:** Give your connection a descriptive name, for example, `jira-cloud-connection`.
3.  **Description (Optional):** Add a description, like "Connection to our team's JIRA Cloud instance".
4.  **JIRA Instance URL:** Enter the full base URL of your JIRA Cloud site. It looks like `https://your-company-name.atlassian.net`.
5.  **Authentication Type:** From the dropdown, select **"Username and API Token"**.
6.  **Username:** Enter the email address you use to log in to JIRA.
7.  **API Token (Secret):**
    *   This is where we link to Secret Manager. **Do not paste your token directly.**
    *   Click the **"Select"** button or the field itself. A dialog will appear.
    *   In the "Select Secret" panel, find the secret named `jira-api-token` that you created earlier.
    *   For the "Version", select **"latest"**. This ensures you always use the most recent version of the token.
    *   Click **"Select"** to confirm. The field should now be populated with the resource path to your secret.
8.  **Forward proxy (Optional):** Leave this blank unless you use a proxy to connect to the internet.

#### **Part 5: Finalize and Create**

1.  **Review:** Double-check all the details you entered.
2.  **Create:** Click the **"Create"** button at the bottom of the page.

GCP will now provision the connection. It might take a minute or two. Once it's done, you should see your new `jira-cloud-connection` in the list of connections with a **"Ready"** status.

---

If you get stuck on a specific step, please let me know which one it is!