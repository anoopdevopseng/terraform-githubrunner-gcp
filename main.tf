resource "kubernetes_namespace" "arc_systems" {
  metadata {
    name = var.arc_systems_namespace
  }
}

resource "kubernetes_namespace" "arc_runners" {
  metadata {
    name = var.arc_runners_namespace
  }
  depends_on = [helm_release.arc]
}



resource "kubernetes_secret" "gh_app_pre_defined_secret" {
  count = lookup(var.github_secret, "gh-app-pre-defined-secret", "") != "" ? 1 : 0

  metadata {
    name      = var.github_secret["gh-app-pre-defined-secret"]
    namespace = kubernetes_namespace.arc_runners.metadata[0].name
  }
  data = {
    github_app_id              = lookup(var.github_secret, "gh_app_id", "")
    github_app_installation_id = lookup(var.github_secret, "gh_app_installation_id", "")
    github_app_private_key     = lookup(var.github_secret, "gh_app_private_key", "")
  }
}

resource "helm_release" "arc" {
  name      = "arc"
  namespace = kubernetes_namespace.arc_systems.metadata[0].name
  chart     = "oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller"
  version   = var.arc_controller_version
  wait      = true
  values    = var.arc_controller_values
}

resource "helm_release" "arc_runners_set" {
  depends_on = [ kubernetes_namespace.arc_runners ]
  name      = "arc-runner-set"
  namespace = kubernetes_namespace.arc_runners.metadata[0].name
  chart     = "oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set"
  version   = var.arc_runners_version

  values = concat([
    templatefile("${path.module}/Files/arc_runner_linux_values.yaml.tmpl", {
      githubConfigSecret = coalesce(lookup(var.github_secret, "gh-app-pre-defined-secret", ""), var.manual_secret_name)
      githubConfigUrl    = var.gh_config_url
      os                 = "linux"
      containerModeType  = var.arc_container_mode
    })
  ],var.arc_runners_values)
}

resource "helm_release" "arc_runners_windows" {
  count      = var.enable_windows_runner ? 1 : 0
  depends_on = [ kubernetes_namespace.arc_runners ]

  name       = "arc-runner-windows"
  namespace  = kubernetes_namespace.arc_runners.metadata[0].name
  chart      = "oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set"
  version    = var.arc_runners_version

  values = concat([
    templatefile("${path.module}/Files/arc_runner_windows_values.yaml.tmpl", {
      githubConfigSecret              = coalesce(lookup(var.github_secret, "gh-app-pre-defined-secret", ""), var.manual_secret_name)
      githubConfigUrl                 = var.gh_config_url
      windows_arc_runner_image        = var.windows_arc_runner_image
      windows_arc_runner_image_pull_secret = var.windows_arc_runner_image_pull_secret
    })
  ],var.arc_runners_values_windows)
}

resource "kubernetes_secret" "docker_registry" {
  count      = var.enable_windows_runner ? 1 : 0
  metadata {
    name      = var.docker_secret.name
    namespace = var.docker_secret.namespace # replace with your actual namespace
  }

  type = "kubernetes.io/dockerconfigjson"
  
  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "${var.docker_secret.url}" = {
          username = var.docker_secret.username
          password = var.docker_secret.password
          email    = var.docker_secret.email
          auth     = base64encode("${var.docker_secret.username}:${var.docker_secret.password}")
        }
      }
    }))
  }
}
