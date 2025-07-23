variable "COMFYUI_VERSION" {
    default = "v0.3.44"
}

variable "GITHUB_WORKSPACE" {
    default = "."
}

target "default" {
    context = "${GITHUB_WORKSPACE}"
    dockerfile = "Dockerfile"
    platforms  = ["linux/amd64"]
    tags = ["dlade/stable-diffusion-comfyui:${COMFYUI_VERSION}"]
    args = {
        COMFYUI_VERSION = "${COMFYUI_VERSION}"
        GITHUB_WORKSPACE = "${GITHUB_WORKSPACE}"
    }
}
