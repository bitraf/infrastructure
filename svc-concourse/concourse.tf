resource "docker_image" "concourse" {
  name = "concourse/concourse:6.8.0"
}

resource "docker_container" "concourse" {
  image      = docker_image.concourse.image_id
  name       = "concourse"
  privileged = true
  must_run   = false

  command = ["quickstart"]
  #  start   = false

  network_mode = "host"
  ports {
    internal = "8080"
    external = "8080"
  }

  env = [
    "CONCOURSE_POSTGRES_HOST=bite.lan.bitraf.no",
    "CONCOURSE_POSTGRES_USER=${postgresql_role.concourse.name}",
    "CONCOURSE_POSTGRES_PASSWORD=${postgresql_role.concourse.password}",
    "CONCOURSE_POSTGRES_DATABASE=${postgresql_database.concourse.name}",
    "CONCOURSE_POSTGRES_PORT=${local.port}",
    "CONCOURSE_POSTGRES_SSLMODE=require",
    "CONCOURSE_EXTERNAL_URL=https://concourse.bitraf.no",
    "CONCOURSE_ADD_LOCAL_USER=test:test",
    "CONCOURSE_MAIN_TEAM_LOCAL_USER=test",
    "CONCOURSE_WORKER_BAGGAGECLAIM_DRIVER=overlay",
    "CONCOURSE_CLIENT_SECRET=Y29uY291cnNlLXdlYgo=",
    "CONCOURSE_TSA_CLIENT_SECRET=Y29uY291cnNlLXdvcmtlcgo=",
    "CONCOURSE_X_FRAME_OPTIONS=allow",
    "CONCOURSE_CONTENT_SECURITY_POLICY=*",
    "CONCOURSE_CLUSTER_NAME=tutorial",
    "CONCOURSE_WORKER_CONTAINERD_DNS_SERVER=8.8.8.8",
    "CONCOURSE_WORKER_RUNTIME=containerd",
    "CONCOURSE_ENABLE_ACROSS_STEP=true",
  ]
}
