terraform {
    backend "s3" {
        bucket = "s3-dev-aws-app-assignment"
        key    = "state.tfstate"
    }
}