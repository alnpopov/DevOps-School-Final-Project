pipeline {
    agent any

    stages {
        stage('Terraform: Init') {
            steps {
                sh "terraform init -input=false"
            }
        }
        stage('Terraform: Validate and Plan') {
            steps {
                sh "terraform validate"
                sh "terraform plan"
            }
        }
        stage('Terraform: Apply') {
            steps {
                sh 'terraform apply -auto-approve'
                sh 'terraform output > output'
            }
        }
        stage('Ansible: Create Docker Image and Push it to DockerHub') {
            steps {
                sh 'ansible-playbook -i hosts ansible_build_srv_role.yml --vault-password-file docker.pass'
            }
        }
        stage('Ansible: Pull Docker Image and Deploy it to Stage') {
            steps {
                sh 'ansible-playbook -i hosts ansible_stage_srv_role.yml --vault-password-file docker.pass'
            }
        }
    }
}
