Azure Log Analytics Windows agent installation can be done using Azure Automation DSC as explained in Microsoft documentation article.

https://docs.microsoft.com/en-us/azure/azure-monitor/platform/agent-windows#install-the-agent-using-dsc-in-azure-automation

But due to server level group policy or firewall restriction or some other reason if the agent service is stopped after the installation then executing the same agent installation script does not resolve the issue as it depends on installer package execution. So a small DSC node configuration script (StartHealthServiceUsingDSC.ps1) to start the agent service needs to be explicitly assigned to DSC node.
