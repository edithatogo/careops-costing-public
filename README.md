# CareOps Costing — public source

Reusable offline Power Platform packaging, generated solution bootstrap and UI
source. This clean-history publication excludes the private workbook analysis,
Word document, ZIP inputs, CSV registers, tenant bindings and operational history.
It does not establish redistribution rights for those retained private materials.

Run the existing PowerShell packaging command tests and source CI before using
an artifact. Native deployment and substantive costing parity remain separate.
The bootstrap and UI source are development candidates, not operational approval.


## Modular source delivery and ALM

Follow the shared delivery policy and ordered source/native queue in
[the module profile](.careops/module.json). Prefer exact useful development pins,
isolated qualification and retained recovery over replacing a working runtime.
Preserve existing publisher/logical names, stable IDs, connections, schedules and
current owners. Deduplicate only with component identity and dependency evidence.

Keep native exports, target bindings and operational records private. Version
external artifacts that do not belong in a Dataverse solution through their
existing deployment manifests. Record actual solution-layer and pipeline/Git
prerequisites separately from source CI; this profile configures no tenant.
SharePoint structured document generation remains the preferred route for any
selected structured report or document, subject to exact entitlement, complete
output, human-edit preservation and recovery qualification.

## Locked solution SDK build

The bootstrap project pins Microsoft.PowerApps.MSBuild.Solution 2.14.1 and
.NET Framework reference assemblies 1.0.3 with a committed NuGet content-hash lock.
On Windows, run `dotnet restore powerplatform/solution_bootstrap/bootstrap_solution.cdsproj --locked-mode`,
then `dotnet build powerplatform/solution_bootstrap/bootstrap_solution.cdsproj --no-restore -c Release -p:SolutionPackageType=Managed`.
Source CI compares every SDK archive member against the existing pinned PAC
package, allowing only XML formatting, top-level entity collection order and ZIP container
metadata differences. Entity identities and all nested content/order remain checked.
The SDK candidate is retained separately; the existing PAC package remains the
attested release path. Neither build authenticates to or deploys into a tenant.

## Explicit deployment targets and existing sessions

Both `pac-environment-check.ps1` and `pac-solution-deploy.ps1` require
`-EnvironmentUrl` with the exact HTTPS Dataverse root; a display label does not
select an environment. Use `-PacPath` for the already-qualified VS Code PAC
executable. The environment check performs only one explicit-target identity/read
and fails on a failed or empty response. Inspect that identity against the intended
account and tenant; a stored profile alone is not access proof.

Deployment reuses the existing session by default and never falls back to a legacy
NuGet cache or an ambient environment. Existing application authentication is used
only when its explicit federated or application credential mode is supplied;
this source support does not authorize new identities, consent or credentials.
Neither a successful read nor source CI grants deployment authority or proves
solution membership, runtime results or recovery.
