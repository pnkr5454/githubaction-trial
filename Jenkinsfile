pipeline{
    agent any
    tools {
    maven 'maven1'
    }
    environment {
      DOCKER_TAG = latestcommitID()
    }

    stages{
        /*
        stage("git checkout"){
            steps{
                git 'https://github.com/pnkr5454/Docker-CICD-with-ansible'
            }
        }
        */
        stage("Build by Maven"){
            steps{
                sh "mvn clean package"
            }
        }
        stage("build the image using docker"){
            steps{
                sh "docker build . -t pnkr5454/mycicd:${DOCKER_TAG}"
            }
        }
        stage("push the code to docker hub"){
            steps{
                withCredentials([string(credentialsId: 'docker_pswd', variable: 'dockerpassword')]) {
                 sh "docker login -u pnkr5454 -p ${dockerpassword}"
                 sh "docker push pnkr5454/mycicd:${DOCKER_TAG} "
                }
            }
        }
        stage("deploy the code docker host server"){
            steps{
                ansiblePlaybook credentialsId: 'docker_hub', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'Ansible2', inventory: 'dev.inv', playbook: 'deploy.yml'
            }
        }
    }
    post {
        success{
			mail  body: """Hi Dev Team,
	        Your ${env.JOB_NAME} Job succeed, This is your build URL ${env.BUILD_URL},
            Thanks,
            DevOps Team""", subject: "${env.JOB_NAME} - Success", 
            to: 'pnkr5454@gmail.com'
		}
        failure{
          mail body: """Hi Developer, Your ${env.JOB_NAME} Job failed, This is your build URL ${env.BUILD_URL},
            Regards,
            DevOps Team""",subject: "${env.JOB_NAME} - Failed", 
            to: 'pnkr5454@gmail.com'
        }
    }
}
def latestcommitID(){
    def commitID = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitID
}