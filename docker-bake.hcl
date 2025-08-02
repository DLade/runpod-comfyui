variable "GITHUB_WORKSPACE" {
    default = "."
}

target "default" {
    context = "${GITHUB_WORKSPACE}"
    dockerfile = "Dockerfile"
    platforms  = ["linux/amd64"]
    tags = ["dlade/stable-diffusion-comfyui:latest"]
    args = {
        GITHUB_WORKSPACE = "${GITHUB_WORKSPACE}"
    }
}
