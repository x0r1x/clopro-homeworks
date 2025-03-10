locals {
    sa_key_file = file("~/.yc-bender-key.json")
    ssh_pub_key = file("~/.ssh/id_ed25519.pub")
    ssh_key = "alekseykashin:${file("~/.ssh/id_ed25519.pub")}"
}