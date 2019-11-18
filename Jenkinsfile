properties(
	[parameters(
		[string(defaultValue: 'cloud09', description: 'cloud which is allocated to you', name: 'cloud_name'),
 		 choice(choices: 'scale\naliase', description: 'lab name', name: 'lab_name'),
		 password(defaultValue: '', description: 'password used to login to undercloud and hwstore machines', name: 'ansible_ssh_pass'),
		 choice(choices: 'OSP13\nOSP15\nOSP16', description: 'OSP version to install', name: 'osp_release'),
		 string(defaultValue: 'hwstore.rdu2.scalelab.redhat.com', description: '', name: 'hammer_host'),
		 string(defaultValue: 'registry-proxy.engineering.redhat.com', description: '', name: 'registry_mirror'),
		 string(defaultValue: 'rh-osbs', description: '', name: 'registry_namespace'),
		 string(defaultValue: 'docker-registry.upshift.redhat.com', description: '', name: 'insecure_registries')
		])
	])

node {
    checkout scm
    stage("check ansible jump host") {
	sh './ansible_host/verify_ansible_host.sh'
        echo "Jump host is good to go"
    }

    stage("set jetpack setup") {
	sh 'mkdir -p ansible_user_dir'
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
	    }
        }
	dir('ansible_user_dir') {
	    sh 'printf "ansible_user_dir: $(pwd)\n" >> jetpack/group_vars/all.yml'
	    sh 'cat jetpack/group_vars/all.yml'
	}
    }
}
