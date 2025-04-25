# GithubRunner

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.3.0, < 7 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.0 |

## Modules

No modules.

## DOCKERFILE
If You are trying to setup the windows github runner In GKE. 
Then follow these step and build the docker file for Custom-Github-arc-runner-image

```
git clone https://github.com/anoopdevopseng/terraform-githubrunner-gcp.git
cd Windows_Runner_Dockerfile
docker build -t <url_of_your_docker_registry> .
docker push <url_of_your_docker_registry>
```

## Resources

| Name | Type |
|------|------|
| [helm_release.arc](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.arc_runners_set](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.arc_runners_windows](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.arc_runners](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.arc_systems](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.docker_registry](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.gh_app_pre_defined_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arc_container_mode"></a> [arc\_container\_mode](#input\_arc\_container\_mode) | value of containerMode.type in ARC runner scale set helm chart. If set, value can be `dind` or `kubernetes` | `string` | `""` | no |
| <a name="input_arc_controller_values"></a> [arc\_controller\_values](#input\_arc\_controller\_values) | List of values in raw yaml format to pass to helm for ARC runners scale set controller chart | `list(string)` | `[]` | no |
| <a name="input_arc_controller_version"></a> [arc\_controller\_version](#input\_arc\_controller\_version) | Version tag for the ARC image. See [https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set-controller](https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set-controller) for releases. | `string` | `"0.9.3"` | no |
| <a name="input_arc_runners_namespace"></a> [arc\_runners\_namespace](#input\_arc\_runners\_namespace) | Namespace created for the ARC runner pods. | `string` | `"arc-runners"` | no |
| <a name="input_arc_runners_values"></a> [arc\_runners\_values](#input\_arc\_runners\_values) | List of values in raw yaml format to pass to helm for ARC runners scale set chart | `list(string)` | `[]` | no |
| <a name="input_arc_runners_values_windows"></a> [arc\_runners\_values\_windows](#input\_arc\_runners\_values\_windows) | n/a | `list(string)` | `[]` | no |
| <a name="input_arc_runners_version"></a> [arc\_runners\_version](#input\_arc\_runners\_version) | Version tag for the ARC image. See [https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set](https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set) for releases. | `string` | `"0.9.3"` | no |
| <a name="input_arc_systems_namespace"></a> [arc\_systems\_namespace](#input\_arc\_systems\_namespace) | Namespace created for the ARC operator pods. | `string` | `"arc-systems"` | no |
| <a name="input_docker_secret"></a> [docker\_secret](#input\_docker\_secret) | n/a | <pre>object({<br/>    name        = string<br/>    namespace   = string<br/>    url         = string<br/>    username    = string<br/>    password    = string<br/>    email       = string<br/><br/>  })</pre> | `null` | no |
| <a name="input_enable_windows_runner"></a> [enable\_windows\_runner](#input\_enable\_windows\_runner) | n/a | `bool` | `false` | no |
| <a name="input_gh_config_url"></a> [gh\_config\_url](#input\_gh\_config\_url) | URL of GitHub App config. If installed in an organization, this is in the format "https://github.com/ORGANIZATION" | `string` | n/a | yes |
| <a name="input_github_secret"></a> [github\_secret](#input\_github\_secret) | GitHub App secrets used to create a Kubernetes secret | `map(string)` | <pre>{<br/>  "gh_app_id": "",<br/>  "gh_app_installation_id": "",<br/>  "gh_app_pre_defined_secret_name": "",<br/>  "gh_app_private_key": ""<br/>}</pre> | no |
| <a name="input_manual_secret_name"></a> [manual\_secret\_name](#input\_manual\_secret\_name) | n/a | `string` | `"gh_app_pre_defined_secret"` | no |
| <a name="input_windows_arc_runner_image"></a> [windows\_arc\_runner\_image](#input\_windows\_arc\_runner\_image) | n/a | `string` | `""` | no |
| <a name="input_windows_arc_runner_image_pull_secret"></a> [windows\_arc\_runner\_image\_pull\_secret](#input\_windows\_arc\_runner\_image\_pull\_secret) | n/a | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->