Azure Log Analytics Windows agent installation can be done using Azure Automation DSC as explained in Microsoft documentation article.

https://docs.microsoft.com/en-us/azure/azure-monitor/platform/agent-windows#install-the-agent-using-dsc-in-azure-automation

But due to server level group policy or firewall restriction or some other reason if the agent service is stopped after the installation then DSC configuration status stays as not compliant on executing the same agent installation node configuration script. The reason for non-compliancy is node configuration script service resource depends on other resources like installer package execution. So to resolve the issue we would need to assign a small DSC node configuration script (StartHealthServiceUsingDSC.ps1) to start the agent service.
