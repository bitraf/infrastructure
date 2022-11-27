resource "docker_image" "concourse" {
  name = "concourse/concourse:7.8.3"
}

resource "docker_container" "concourse" {
  image      = docker_image.concourse.image_id
  name       = "concourse"
  privileged = true
  must_run   = false

  command = ["quickstart"]

  networks_advanced {
    name = "traefik"
  }

  labels {
    label = "traefik.enable"
    value = "true"
  }
  labels {
    label = "traefik.http.routers.healthchecks.entrypoints"
    value = "websecure"
  }
  labels {
    label = "traefik.http.routers.healthchecks.rule"
    value = "Host(`concourse.bitraf.no`)"
  }
  labels {
    label = "traefik.http.routers.healthchecks.tls.certresolver"
    value = "bitraf"
  }
  labels {
    label = "traefik.http.services.healthchecks.loadbalancer.server.port"
    value = "8080"
  }

  env = [
    "CONCOURSE_POSTGRES_HOST=bite.lan.bitraf.no",
    "CONCOURSE_POSTGRES_USER=${postgresql_role.concourse.name}",
    "CONCOURSE_POSTGRES_PASSWORD=${postgresql_role.concourse.password}",
    "CONCOURSE_POSTGRES_DATABASE=${postgresql_database.concourse.name}",
    "CONCOURSE_POSTGRES_PORT=${local.port}",
    "CONCOURSE_POSTGRES_SSLMODE=require",
    "CONCOURSE_EXTERNAL_URL=https://concourse.bitraf.no",
    "CONCOURSE_WORKER_BAGGAGECLAIM_DRIVER=overlay",
    "CONCOURSE_CLIENT_SECRET=Y29uY291cnNlLXdlYgo=",
    "CONCOURSE_TSA_CLIENT_SECRET=Y29uY291cnNlLXdvcmtlcgo=",
    "CONCOURSE_X_FRAME_OPTIONS=allow",
    "CONCOURSE_CONTENT_SECURITY_POLICY=*",
    "CONCOURSE_CLUSTER_NAME=tutorial",
    "CONCOURSE_WORKER_CONTAINERD_DNS_SERVER=8.8.8.8",
    "CONCOURSE_WORKER_RUNTIME=containerd",
    "CONCOURSE_ENABLE_ACROSS_STEP=true",

    "CONCOURSE_ADD_LOCAL_USER=test:test",
    "CONCOURSE_MAIN_TEAM_LOCAL_USER=test",

#    "CONCOURSE_MAIN_TEAM_GITHUB_ORG=org-name",
    "CONCOURSE_MAIN_TEAM_GITHUB_TEAM=bitraf:Drift",
#    "CONCOURSE_MAIN_TEAM_GITHUB_USER=some-user",

    "CONCOURSE_GITHUB_CLIENT_ID=${data.ansiblevault_path.github_client_id.value}",
    "CONCOURSE_GITHUB_CLIENT_SECRET=${data.ansiblevault_path.github_client_secret.value}",
  ]
}

data "ansiblevault_path" "github_client_id" {
  path = "group_vars/concourse/vault.yml"
  key  = "concourse_github_client_id"
}

data "ansiblevault_path" "github_client_secret" {
  path = "group_vars/concourse/vault.yml"
  key  = "concourse_github_client_secret"
}
