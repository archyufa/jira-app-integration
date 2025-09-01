# Guide: Implementing the Integration Workflow Logic

This guide details how to build the logic inside your integration canvas. We will add tasks to parse the incoming alert, map its data, and use the JIRA connector to create an issue.

### **Prerequisites**
*   You have an open integration canvas with a Pub/Sub trigger, as created in the previous step.

---

### **Understanding the Incoming Data**

When Cloud Monitoring sends an alert to Pub/Sub, it's a JSON payload. The data we care about is inside the `message.data` field, which is a Base64-encoded string containing another JSON object. The structure looks roughly like this:

```json
{
  "incident": {
    "scoping_project_id": "your-gcp-project-id",
    "summary": "The metric has crossed a threshold",
    "documentation": {
        "content": "Detailed information about the alert."
    }
  }
}
```

Our workflow needs to decode and parse this to get the `summary` and `documentation.content`.

---

### **Step-by-Step Guide**

#### **Part 1: Add a Data Mapping Task**

This task will extract and transform the data from the Pub/Sub message.

1.  **Open the Integration Canvas:** Navigate to your `CreateJiraIssueFromAlert` integration.
2.  **Add a Task:** From the **"Tasks"** list on the left, drag a **"Data Mapping"** task and drop it onto the canvas, right after the Pub/Sub trigger.
3.  **Configure the Mapping:**
    *   Click on the new Data Mapping task to open its configuration panel.
    *   Click **"Open Data Mapper"**.
    *   **Input:** The input variable is the output of our trigger. It will be named something like `trigger/pubsub-trigger`. We need to access its `message.data` field.
    *   **Create Output Variables:** We need to create variables to hold the parsed data. On the "Variables" panel (usually on the right), create two new variables for your integration:
        *   `jira_summary` (String)
        *   `jira_description` (String)
    *   **Map the Data:** Now, we'll use a function to decode and parse the JSON.
        *   In the mapping for `jira_summary`, click the function (`fx`) icon and use a formula like this (you may need to adjust the input variable name):
            `jsonpath(base64decode(trigger/pubsub-trigger.message.data), "$.incident.summary")`
        *   In the mapping for `jira_description`, use a similar formula:
            `jsonpath(base64decode(trigger/pubsub-trigger.message.data), "$.incident.documentation.content")`
    *   **Close the Data Mapper:** Click "Save" or close the data mapper view.

#### **Part 2: Add the JIRA Connector Task**

1.  **Add a Connector Task:** From the **"Tasks"** list, drag a **"Connectors"** task and place it after the Data Mapping task.
2.  **Configure the Connector:**
    *   **Select Connector:** In the configuration panel, choose the `jira-cloud-connection` you created in Step 1.
    *   **Select Operation:** Choose the operation to perform. Select **"Create Issue"**.
    *   **Configure Input Parameters:** Now you'll see the fields required to create a JIRA issue. We will map our variables to these fields.
        *   **Project Key:** Enter the short key for your JIRA project (e.g., "PROJ", "DEV"). You can hardcode this value.
        *   **Issue Type:** Enter the name of the issue type, like "Bug" or "Task".
        *   **Summary:** Click the "Variable" button for this field and select your `jira_summary` variable.
        *   **Description:** Click the "Variable" button and select your `jira_description` variable.
        *   Fill in any other required fields for your JIRA project.

#### **Part 3: Publish the Integration**

1.  **Enable Publishing:** Before you can test, you must publish the integration. Click the **"Publish"** button in the top-right corner of the integration designer.

Your workflow is now live and ready to be tested. It will listen for messages, parse them, and use the data to create a JIRA issue.

---

Please follow these steps to build out the logic. Let me know when you are ready to move to the final configuration and testing phase.