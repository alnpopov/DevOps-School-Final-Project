pipeline {
    agent any

    stages {
        stage('Terraform: Init, Validate and Plan') {
            steps {
                sh "terraform init -input=false"
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
        stage('Ansible: Pull Docker Image and Deploy to Stage') {
            steps {
                sh 'ansible-playbook'
            }
        }
    }
}
