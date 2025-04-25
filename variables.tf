variable "arc_systems_namespace" {
  type        = string
  description = "Namespace created for the ARC operator pods."
  default     = "arc-systems"
}

variable "arc_runners_namespace" {
  type        = string
  description = "Namespace created for the ARC runner pods."
  default     = "arc-runners"
}

variable "github_secret" {
  description = "GitHub App secrets used to create a Kubernetes secret"
  type = map(string)
  default = {
    gh_app_pre_defined_secret_name = ""
    gh_app_id                      = ""
    gh_app_installation_id         = ""
    gh_app_private_key             = ""
  }
}


variable "manual_secret_name" {
  type = string
  default = "gh_app_pre_defined_secret"
}

variable "gh_config_url" {
  type        = string
  description = "URL of GitHub App config. If installed in an organization, this is in the format \"https://github.com/ORGANIZATION\""
}

variable "arc_runners_version" {
  type        = string
  description = "Version tag for the ARC image. See [https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set](https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set) for releases."
  default     = "0.9.3"
}

variable "arc_controller_version" {
  type        = string
  description = "Version tag for the ARC image. See [https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set-controller](https://github.com/actions/actions-runner-controller/pkgs/container/actions-runner-controller-charts%2Fgha-runner-scale-set-controller) for releases."
  default     = "0.9.3"
}

variable "arc_container_mode" {
  type        = string
  description = "value of containerMode.type in ARC runner scale set helm chart. If set, value can be `dind` or `kubernetes`"
  default     = ""
}

variable "arc_controller_values" {
  type        = list(string)
  description = "List of values in raw yaml format to pass to helm for ARC runners scale set controller chart"
  default     = []
}

variable "arc_runners_values" {
  type        = list(string)
  description = "List of values in raw yaml format to pass to helm for ARC runners scale set chart"
  default     = []
}

variable "enable_windows_runner" {
  type = bool
  default = false
}

variable "arc_runners_values_windows" {
  type = list(string)
  default = []
}

variable "windows_arc_runner_image" {
  type = string
  default = ""
  # example = "ghcr.io/your-org/your-windows-runner:latest"
}

variable "windows_arc_runner_image_pull_secret" {
  type = string
  default = ""
}

variable "docker_secret" {
  type = object({
    name        = string
    namespace   = string
    url         = string
    username    = string
    password    = string
    email       = string

  })
  default = null
}