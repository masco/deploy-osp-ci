//properties([parameters([string(defaultValue: 'Hello', description: 'How should I greet the world?', name: 'Greeting')])])
node {
    checkout scm
    stage("check ansible jump host") {
	sh './ansible_host/verify_ansible_host.sh'
        echo "Jump host is good to go"
    }

    stage("set jetpack setup") {
	sh 'mkdir -p ansible_user_dir'
        dir('ansible_user_dir') {
	    git url: 'https://github.com/redhat-performance/jetpack.git'
        }
    }
}
