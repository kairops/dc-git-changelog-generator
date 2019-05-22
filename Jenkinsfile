#!groovy

@Library('github.com/red-panda-ci/jenkins-pipeline-library@v3.0.1') _

// Initialize global config
cfg = jplConfig('dc-git-changelog-generator', 'bash', '', [slack: '#integrations', email:'redpandaci+dc-git-changelog-generator@gmail.com'])

pipeline {
    agent none

    stages {
        stage ('Initialize') {
            agent { label 'master' }
            steps  {
                jplStart(cfg)
            }
        }
        stage ('Build') {
            agent { label 'docker' }
            steps {
                script {
                    jplDockerPush (cfg, "kairops/dc-git-changelog-generator", "test", ".", "https://registry.hub.docker.com", "cikairos-docker-credentials")
                }
            }
        }
        stage ('Test') {
            agent { label 'docker' }
            steps  {
                sh 'bin/test.sh'
            }
        }
        stage ('Make release'){
            agent { label 'master' }
            when { branch 'release/new' }
            steps {
                script { cfg.promoteBuild.enabled = true }
                jplMakeRelease(cfg)
            }
        }
        stage ('Release confirm') {
            when { expression { cfg.BRANCH_NAME.startsWith('release/v') || cfg.BRANCH_NAME.startsWith('hotfix/v') } }
            steps {
                jplPromoteBuild(cfg)
            }
        }
        stage ('Release finish') {
            agent { label 'master' }
            when { expression { (cfg.BRANCH_NAME.startsWith('release/v') || cfg.BRANCH_NAME.startsWith('hotfix/v')) && cfg.promoteBuild.enabled } }
            steps {
                jplDockerPush (cfg, "kairops/dc-git-changelog-generator", cfg.releaseTag, ".", "https://registry.hub.docker.com", "cikairos-docker-credentials")
                jplDockerPush (cfg, "kairops/dc-git-changelog-generator", "latest", ".", "https://registry.hub.docker.com", "cikairos-docker-credentials")
                jplCloseRelease(cfg)
            }
        }
    }

    post {
        always {
            jplPostBuild(cfg)
        }
    }

    options {
        timestamps()
        ansiColor('xterm')
        buildDiscarder(logRotator(artifactNumToKeepStr: '20',artifactDaysToKeepStr: '30'))
        disableConcurrentBuilds()
        timeout(time: 1, unit: 'DAYS')
    }
}
