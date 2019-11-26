properties(
	[parameters(
		[string(defaultValue: 'cloud09', description: 'cloud which is allocated to you', name: 'cloud_name'),
 		 choice(choices: 'scale\naliase', description: 'lab name', name: 'lab_name'),
		 password(defaultValue: '', description: 'password used to login to undercloud and hwstore machines', name: 'ansible_ssh_pass'),
		 choice(choices: '13\n15\n16', description: 'OSP version to install', name: 'osp_release'),
		 string(defaultValue: 'hwstore.rdu2.scalelab.redhat.com', description: '', name: 'hammer_host'),
		 string(defaultValue: 'registry-proxy.engineering.redhat.com', description: '', name: 'registry_mirror'),
		 string(defaultValue: 'rh-osbs', description: '', name: 'registry_namespace'),
		 string(defaultValue: 'docker-registry.upshift.redhat.com', description: '', name: 'insecure_registries')
		])
	])

def remote = [:]
remote.name = "f03-h27-000-r620.rdu2.scalelab.redhat.com"
remote.host = "f03-h27-000-r620.rdu2.scalelab.redhat.com"
remote.allowAnyHosts = true

node {
    checkout scm
    withCredentials([usernamePassword(credentialsId: 'sshUserAcc', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password

	stage("check ansible jump host") {
	    sshScript remote: remote, script: 'ansible_host/verify_ansible_host.sh'
	    echo "Jump host is good to go"
	}

	stage("set jetpack setup") {/*
	    sshCommand remote: remote, command: 'cd ~ && rm -rf jetpack && git clone https://github.com/redhat-performance/jetpack.git'
	    sshPut remote: remote, from: 'instackenv.json', into: '/root/instackenv.json', override: true
	    //workaround for ansible 3.8
	    sshCommand remote: remote, command: 'rm -f ~/jetpack/overcloud.yml && cp ~/overcloud.yml.bk ~/jetpack/overcloud.yml'
	    sshGet remote: remote, from: '/root/jetpack/group_vars/all.yml', into: 'all.yml', override: true
	    // populate vars
	    sh 'echo "cloud_name: ${cloud_name}" >> all.yml'
            sh 'echo "lab_name: ${lab_name}" >> all.yml'
            sh 'echo "ansible_ssh_pass: ${ansible_ssh_pass}" >> all.yml'
            sh 'echo "osp_release: ${osp_release}" >> all.yml'
            sh 'echo "hammer_host: ${hammer_host}" >> all.yml'
            sh 'echo "registry_mirror: ${registry_mirror}" >> all.yml'
            sh 'echo "registry_namespace: ${registry_namespace}" >> all.yml'
            sh 'echo "insecure_registries: ${insecure_registries}" >> all.yml'
	    // set one controller
	    sh 'echo "controller_count: 1" >> all.yml'
	    sh 'echo "compute_count: 1" >> all.yml'
	    sshPut remote: remote, from: 'all.yml', into: '/root/jetpack/group_vars/all.yml', override: true*/
	}

	stage("run jetpack") {
	    //sshCommand remote: remote, command: 'cd ~/jetpack && ansible-playbook -vvv main.yml 2>&1 | tee log1'
	    sshGet remote: remote, from: '/root/jetpack/log1', into: 'log1', override: true
	    sh 'tail -3 log1 > log2'
	    sh 'cat log2'
	    sh 'python verifier.py ./log2'
	    sh '''
		if [[ $? -ne 0 ]]; then
		    echo 'Deployment failed, check log file'
		    exit 1
		fi
	    '''
	}
    }

    /*stage("set jetpack setup") {
	sh 'rm -rf ansible_user_dir'
        dir('ansible_user_dir/jetpack') {
	    git url: 'https://github.com/redhat-performance/jetpack.git'
	    dir('group_vars') {
		sh 'echo "cloud_name: ${cloud_name}" >> all.yml'
		sh 'echo "lab_name: ${lab_name}" >> all.yml'
		sh 'echo "ansible_ssh_pass: ${ansible_ssh_pass}" >> all.yml'
		sh 'echo "osp_release: ${osp_release}" >> all.yml'
		sh 'echo "hammer_host: ${hammer_host}" >> all.yml'
		sh 'echo "registry_mirror: ${registry_mirror}" >> all.yml'
		sh 'echo "registry_namespace: ${registry_namespace}" >> all.yml'
		sh 'echo "insecure_registries: ${insecure_registries}" >> all.yml'
		sh 'cat all.yml'
	    }
        }
	sh 'cp instackenv.json ansible_user_dir/.'
	sh 'ansible-playbook -vvv test.yml'
	sh 'echo $HOME'
	sh 'cp instackenv.json /var/lib/jenkins/.'
	sh 'ls -a /var/lib/jenkins/'
	dir('ansible_user_dir') {
	    sh 'ls -a'
	}
    }

    stage("run jetpack") {
	dir('ansible_user_dir/jetpack') {
	    sh 'ansible-playbook -vvv main.yml'
	}
    }*/
}
