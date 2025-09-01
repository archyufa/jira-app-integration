# Guide: Creating the Integration and Pub/Sub Trigger

This guide covers the initial setup of your integration workflow in the GCP Console, specifically creating the integration and configuring it to be triggered by a Pub/Sub message.

### **Prerequisites**
*   You have successfully configured the JIRA Connector as outlined in the previous guide.
*   You have a Pub/Sub topic ready to receive alerts from Cloud Monitoring. If not, you can create one easily.

---

### **Step-by-Step Guide**

#### **Part 1: Create a Pub/Sub Topic (If you don't have one)**

If you already have a Pub/Sub topic for monitoring alerts, you can skip this part.

1.  **Navigate to Pub/Sub:** In the GCP Console, search for "Pub/Sub" and go to the service page.
2.  **Create Topic:** Click **"+ CREATE TOPIC"**.
3.  **Topic ID:** Give it a descriptive ID, like `monitoring-alerts-for-jira`.
4.  **Defaults:** Leave the remaining settings as default.
5.  **Create:** Click **"CREATE"**.

#### **Part 2: Create the New Integration**

1.  **Navigate to Application Integration:** Go back to the Application Integration service in the GCP Console.
2.  **Go to Integrations List:** In the left-hand menu, click **"Integrations"**.
3.  **Create Integration:** Click **"+ CREATE INTEGRATION"**.
4.  **Details:**
    *   **Integration name:** Enter a name, for example, `CreateJiraIssueFromAlert`.
    *   **Region:** Select the same region where you created your JIRA connection (e.g., `us-central1`).
    *   **Description (Optional):** Describe its purpose, e.g., "Parses a GCP Monitoring alert and creates a JIRA ticket."
5.  **Create:** Click **"CREATE"**. This will open the integration designer canvas.

#### **Part 3: Configure the Pub/Sub Trigger**

The integration designer is a visual tool. Your new integration starts with a default "API Trigger". We need to change this.

1.  **Add a Trigger:** In the designer, find the **"Triggers"** section in the left-hand panel.
2.  **Select Pub/Sub Trigger:** Drag and drop the **"Pub/Sub Trigger"** element onto the canvas where it says "Add a trigger".
3.  **Configure the Trigger:** A configuration panel will open on the right.
    *   **Select Pub/Sub topic:** Click the dropdown and find the Pub/Sub topic you created or designated for this purpose (e.g., `projects/your-project-id/topics/monitoring-alerts-for-jira`).
4.  **Save:** The trigger configuration is saved automatically.

Your integration is now set up. It has a starting point: it will automatically run whenever a new message is published to your specified Pub/Sub topic. The next step will be to add logic to this canvas to do something with that message.

---

Please follow these steps in the GCP Console. Let me know once you have the integration created with the Pub/Sub trigger configured.